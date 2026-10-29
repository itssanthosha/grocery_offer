// Run: cd tool/rules-test && npm install && npm test
// (needs Java 11+ for the Firestore emulator). The batches below mirror
// lib/features/prices/data/price_repository.dart exactly.
import { readFileSync } from 'node:fs';
import { before, after, beforeEach, describe, it } from 'node:test';
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from '@firebase/rules-unit-testing';
import {
  GeoPoint,
  Timestamp,
  arrayUnion,
  collection,
  deleteField,
  doc,
  getDoc,
  increment,
  serverTimestamp,
  setDoc,
  updateDoc,
  writeBatch,
} from 'firebase/firestore';

let env;

const real = (uid) =>
  env.authenticatedContext(uid, { firebase: { sign_in_provider: 'google.com' } }).firestore();
const guest = (uid) =>
  env.authenticatedContext(uid, { firebase: { sign_in_provider: 'anonymous' } }).firestore();
const admin = () =>
  env.authenticatedContext('root', {
    admin: true,
    firebase: { sign_in_provider: 'google.com' },
  }).firestore();

const utcDay = () => {
  const d = new Date();
  return d.getUTCFullYear() * 10000 + (d.getUTCMonth() + 1) * 100 + d.getUTCDate();
};

const STORE = 'lulu_ghubra';
const STORE2 = 'nesto_ruwi';

async function seed(extra = async () => {}) {
  await env.withSecurityRulesDisabled(async (ctx) => {
    const db = ctx.firestore();
    await setDoc(doc(db, 'products/p1'), {
      name: 'Milk',
      categoryId: 'dairyEggs',
      createdBy: 'seed',
      searchKeywords: ['milk'],
      latestPrices: {},
    });
    await setDoc(doc(db, 'products/p2'), {
      name: 'Rice',
      categoryId: 'riceGrains',
      createdBy: 'seed',
      searchKeywords: ['rice'],
      latestPrices: {},
    });
    for (const [id, chainId, branchName] of [
      [STORE, 'lulu', 'Lulu Hypermarket Ghubra'],
      [STORE2, 'nesto', 'Nesto Ruwi'],
    ]) {
      await setDoc(doc(db, 'stores', id), {
        chainId,
        branchName,
        city: 'muscat',
        geo: { geopoint: new GeoPoint(23.58, 58.37), geohash: 'tk1w0w14h' },
        addedBy: 'seed',
        verified: false,
      });
    }
    await extra(db);
  });
}

/** Same batch as PriceRepository.submit. Returns the new price id. */
async function addPrice(db, uid, o = {}) {
  const { productId = 'p1', storeId = STORE, baisa = 450, tweakEntry = {}, tweakPrice = {} } = o;
  const chainId = storeId === STORE ? 'lulu' : 'nesto';
  const branchName = storeId === STORE ? 'Lulu Hypermarket Ghubra' : 'Nesto Ruwi';
  const priceRef = doc(collection(db, 'prices'));
  const stamp = serverTimestamp();
  const dailyRef = doc(db, 'dailyCounts', `${uid}_${utcDay()}`);
  const daily = await getDoc(dailyRef);
  const batch = writeBatch(db);
  batch.set(priceRef, {
    productId,
    storeId,
    chainId,
    priceBaisa: baisa,
    isOffer: false,
    reportedBy: uid,
    reportedAt: stamp,
    confirmations: 0,
    confirmedBy: [],
    flags: 0,
    status: 'active',
    needsReview: false,
    ...tweakPrice,
  });
  batch.set(doc(db, 'rateLimits', `${uid}_${productId}_${storeId}`), { lastAt: stamp });
  batch.update(doc(db, 'products', productId), {
    [`latestPrices.${storeId}`]: {
      priceId: priceRef.id,
      storeId,
      chainId,
      branchName,
      lat: 23.58,
      lng: 58.37,
      priceBaisa: baisa,
      isOffer: false,
      offerEndDate: null,
      reportedAt: stamp,
      confirmations: 0,
      verified: false,
      hasPhoto: false,
      flags: 0,
      reportedBy: uid,
      ...tweakEntry,
    },
    lastPriceAt: stamp,
    lastPriceId: priceRef.id,
  });
  if (daily.exists()) {
    batch.update(dailyRef, { count: increment(1), lastAt: stamp });
  } else {
    batch.set(dailyRef, { count: 1, lastAt: stamp });
  }
  await batch.commit();
  return priceRef.id;
}

/** Same batch as PriceRepository.confirm. */
async function confirm(db, uid, priceId, { productId = 'p1', storeId = STORE, confirmations = 0, hasPhoto = false } = {}) {
  const key = `latestPrices.${storeId}`;
  const batch = writeBatch(db);
  batch.update(doc(db, 'prices', priceId), {
    confirmations: increment(1),
    confirmedBy: arrayUnion(uid),
  });
  batch.update(doc(db, 'products', productId), {
    [`${key}.confirmations`]: increment(1),
    [`${key}.verified`]: confirmations + 1 >= 3 || (hasPhoto && confirmations + 1 >= 1),
    lastPriceId: priceId,
  });
  await batch.commit();
}

/** Same batch as PriceRepository.flag. */
async function flag(db, uid, priceId, { productId = 'p1', storeId = STORE, flags = 0, reason = 'wrong price' } = {}) {
  const key = `latestPrices.${storeId}`;
  const hide = flags + 1 >= 3;
  const batch = writeBatch(db);
  batch.set(doc(db, 'reports', `${priceId}_${uid}`), {
    priceId,
    reportedBy: uid,
    reason,
    createdAt: serverTimestamp(),
  });
  batch.update(doc(db, 'prices', priceId), { flags: increment(1) });
  batch.update(
    doc(db, 'products', productId),
    hide
      ? { [key]: deleteField(), lastPriceId: priceId }
      : { [`${key}.flags`]: increment(1), lastPriceId: priceId },
  );
  await batch.commit();
}

before(async () => {
  env = await initializeTestEnvironment({
    projectId: 'demo-pricemate',
    firestore: { rules: readFileSync(new URL('../../firestore.rules', import.meta.url), 'utf8') },
  });
});
after(() => env.cleanup());
beforeEach(async () => {
  await env.clearFirestore();
  await seed();
});

describe('adding prices', () => {
  it('a real user can add a price and the product entry follows', async () => {
    const db = real('alice');
    await assertSucceeds(addPrice(db, 'alice'));
    const p = (await getDoc(doc(db, 'products/p1'))).data();
    if (p.latestPrices[STORE].priceBaisa !== 450) throw new Error('entry not written');
  });

  it('guests cannot add prices', async () => {
    await assertFails(addPrice(guest('gus'), 'gus'));
  });

  it('signed-out users cannot add prices', async () => {
    await assertFails(addPrice(env.unauthenticatedContext().firestore(), 'x'));
  });

  it('rejects prices outside 1..1,000,000 baisa', async () => {
    const db = real('alice');
    await assertFails(addPrice(db, 'alice', { baisa: 0, tweakEntry: { priceBaisa: 0 } }));
    await assertFails(addPrice(db, 'alice', { baisa: 1000001, tweakEntry: { priceBaisa: 1000001 } }));
    await assertFails(addPrice(db, 'alice', { baisa: 4.5, tweakEntry: { priceBaisa: 4.5 } }));
    await assertSucceeds(addPrice(db, 'alice', { baisa: 1, productId: 'p2', tweakEntry: {} }));
    await assertSucceeds(addPrice(db, 'alice', { baisa: 1000000, storeId: STORE2 }));
  });

  it('same user + product + store only once per 6 hours', async () => {
    const db = real('alice');
    await assertSucceeds(addPrice(db, 'alice'));
    await assertFails(addPrice(db, 'alice'));
    // other store / other product / other user are fine
    await assertSucceeds(addPrice(db, 'alice', { storeId: STORE2 }));
    await assertSucceeds(addPrice(db, 'alice', { productId: 'p2' }));
    await assertSucceeds(addPrice(real('bob'), 'bob'));
  });

  it('allows again after 6 hours', async () => {
    const db = real('alice');
    await assertSucceeds(addPrice(db, 'alice'));
    await env.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(doc(ctx.firestore(), `rateLimits/alice_p1_${STORE}`), {
        lastAt: Timestamp.fromMillis(Date.now() - 7 * 3600 * 1000),
      });
    });
    await assertSucceeds(addPrice(db, 'alice'));
  });

  it('max 50 submissions per day', async () => {
    await env.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(doc(ctx.firestore(), `dailyCounts/alice_${utcDay()}`), {
        count: 49,
        lastAt: Timestamp.now(),
      });
    });
    const db = real('alice');
    await assertSucceeds(addPrice(db, 'alice')); // #50
    await assertFails(addPrice(db, 'alice', { productId: 'p2' })); // #51
  });

  it('banned users cannot write', async () => {
    await env.withSecurityRulesDisabled((ctx) =>
      setDoc(doc(ctx.firestore(), 'users/bad'), { isBanned: true, points: 0, trustScore: 5 }),
    );
    await assertFails(addPrice(real('bad'), 'bad'));
  });

  it('cannot skip the counters', async () => {
    const db = real('alice');
    const priceRef = doc(collection(db, 'prices'));
    await assertFails(
      setDoc(priceRef, {
        productId: 'p1', storeId: STORE, chainId: 'lulu', priceBaisa: 100, isOffer: false,
        reportedBy: 'alice', reportedAt: serverTimestamp(), confirmations: 0, confirmedBy: [],
        flags: 0, status: 'active', needsReview: false,
      }),
    );
  });

  it('cannot start with confirmations, flags or a fake status', async () => {
    const db = real('alice');
    await assertFails(addPrice(db, 'alice', { tweakPrice: { confirmations: 3, confirmedBy: ['a', 'b', 'c'] }, tweakEntry: { confirmations: 3, verified: true } }));
    await assertFails(addPrice(db, 'alice', { tweakPrice: { status: 'removed' } }));
  });

  it('cannot forge the product entry', async () => {
    const db = real('alice');
    // cheaper price in the product than in the price document
    await assertFails(addPrice(db, 'alice', { baisa: 450, tweakEntry: { priceBaisa: 1 } }));
    // wrong store location / name
    await assertFails(addPrice(db, 'alice', { tweakEntry: { lat: 0 } }));
    await assertFails(addPrice(db, 'alice', { tweakEntry: { branchName: 'Fake' } }));
    // claiming to be verified
    await assertFails(addPrice(db, 'alice', { tweakEntry: { verified: true } }));
  });

  it('cannot edit latestPrices without a matching price document', async () => {
    const db = real('alice');
    await assertFails(
      updateDoc(doc(db, 'products/p1'), {
        [`latestPrices.${STORE}`]: { priceId: 'nope', priceBaisa: 1 },
        lastPriceId: 'nope',
      }),
    );
    await assertFails(updateDoc(doc(db, 'products/p1'), { name: 'Hacked' }));
  });
});

describe('confirmations', () => {
  it('another user can confirm once; the entry follows; 3 confirmations verify', async () => {
    const priceId = await addPrice(real('alice'), 'alice');
    await assertSucceeds(confirm(real('bob'), 'bob', priceId, { confirmations: 0 }));
    await assertFails(confirm(real('bob'), 'bob', priceId, { confirmations: 1 })); // twice
    await assertSucceeds(confirm(real('carol'), 'carol', priceId, { confirmations: 1 }));
    await assertSucceeds(confirm(real('dave'), 'dave', priceId, { confirmations: 2 }));
    const p = (await getDoc(doc(real('x'), 'products/p1'))).data().latestPrices[STORE];
    if (p.confirmations !== 3 || p.verified !== true) throw new Error(JSON.stringify(p));
  });

  it('cannot confirm your own price', async () => {
    const priceId = await addPrice(real('alice'), 'alice');
    await assertFails(confirm(real('alice'), 'alice', priceId));
  });

  it('guests cannot confirm; nobody can add +2', async () => {
    const priceId = await addPrice(real('alice'), 'alice');
    await assertFails(confirm(guest('gus'), 'gus', priceId));
    await assertFails(
      updateDoc(doc(real('bob'), 'prices', priceId), { confirmations: 5, confirmedBy: arrayUnion('bob') }),
    );
  });

  it('a photo plus one confirmation verifies', async () => {
    const priceId = await addPrice(real('alice'), 'alice', {
      tweakPrice: { photoUrl: 'https://x/y.jpg' },
      tweakEntry: { hasPhoto: true },
    });
    await assertSucceeds(confirm(real('bob'), 'bob', priceId, { hasPhoto: true }));
    const p = (await getDoc(doc(real('x'), 'products/p1'))).data().latestPrices[STORE];
    if (p.verified !== true) throw new Error('should be verified');
  });
});

describe('flags and reports', () => {
  it('a user can flag once; the 3rd distinct flag hides the price', async () => {
    const priceId = await addPrice(real('alice'), 'alice');
    await assertSucceeds(flag(real('bob'), 'bob', priceId, { flags: 0 }));
    await assertFails(flag(real('bob'), 'bob', priceId, { flags: 1 })); // same user again
    await assertSucceeds(flag(real('carol'), 'carol', priceId, { flags: 1 }));
    await assertSucceeds(flag(real('dave'), 'dave', priceId, { flags: 2, reason: 'spam' }));
    const p = (await getDoc(doc(real('x'), 'products/p1'))).data();
    if (STORE in p.latestPrices) throw new Error('entry should be removed');
  });

  it('cannot hide a price with fewer than 3 flags, or flag your own', async () => {
    const priceId = await addPrice(real('alice'), 'alice');
    await assertFails(
      updateDoc(doc(real('bob'), 'products/p1'), { [`latestPrices.${STORE}`]: deleteField(), lastPriceId: priceId }),
    );
    await assertFails(flag(real('alice'), 'alice', priceId));
  });

  it('rejects unknown reasons and skipping the report', async () => {
    const priceId = await addPrice(real('alice'), 'alice');
    await assertFails(flag(real('bob'), 'bob', priceId, { reason: 'because' }));
    await assertFails(updateDoc(doc(real('bob'), 'prices', priceId), { flags: increment(1) }));
  });

  it('only admins read reports', async () => {
    const priceId = await addPrice(real('alice'), 'alice');
    await flag(real('bob'), 'bob', priceId);
    await assertFails(getDoc(doc(real('bob'), 'reports', `${priceId}_bob`)));
    await assertSucceeds(getDoc(doc(admin(), 'reports', `${priceId}_bob`)));
  });
});

describe('own edits and reads', () => {
  it('author may edit within 1 hour, not after', async () => {
    const db = real('alice');
    const priceId = await addPrice(db, 'alice');
    await assertSucceeds(updateDoc(doc(db, 'prices', priceId), { priceBaisa: 500 }));
    await assertFails(updateDoc(doc(db, 'prices', priceId), { priceBaisa: 0 }));
    await assertFails(updateDoc(doc(db, 'prices', priceId), { status: 'removed' }));
    await env.withSecurityRulesDisabled((ctx) =>
      updateDoc(doc(ctx.firestore(), 'prices', priceId), {
        reportedAt: Timestamp.fromMillis(Date.now() - 2 * 3600 * 1000),
      }),
    );
    await assertFails(updateDoc(doc(db, 'prices', priceId), { priceBaisa: 600 }));
    await assertFails(
      (async () => {
        const { deleteDoc } = await import('firebase/firestore');
        await deleteDoc(doc(db, 'prices', priceId));
      })(),
    );
  });

  it("others cannot edit someone's price", async () => {
    const priceId = await addPrice(real('alice'), 'alice');
    await assertFails(updateDoc(doc(real('bob'), 'prices', priceId), { priceBaisa: 1 }));
  });

  it('active prices are public; removed ones are not', async () => {
    const priceId = await addPrice(real('alice'), 'alice');
    await assertSucceeds(getDoc(doc(env.unauthenticatedContext().firestore(), 'prices', priceId)));
    await env.withSecurityRulesDisabled((ctx) =>
      updateDoc(doc(ctx.firestore(), 'prices', priceId), { status: 'removed' }),
    );
    await assertFails(getDoc(doc(real('bob'), 'prices', priceId)));
    await assertSucceeds(getDoc(doc(real('alice'), 'prices', priceId)));
  });
});

describe('users, products, stores', () => {
  it('users cannot give themselves points or trust', async () => {
    const db = real('alice');
    await assertFails(setDoc(doc(db, 'users/alice'), { points: 500, trustScore: 50, reportsCount: 0, isBanned: false }));
    await assertSucceeds(setDoc(doc(db, 'users/alice'), { points: 0, trustScore: 50, reportsCount: 0, isBanned: false, city: 'muscat' }));
    await assertFails(updateDoc(doc(db, 'users/alice'), { points: 9999 }));
    await assertFails(updateDoc(doc(db, 'users/alice'), { trustScore: 100 }));
    await assertFails(updateDoc(doc(db, 'users/alice'), { isBanned: false, reportsCount: 99 }));
    await assertSucceeds(updateDoc(doc(db, 'users/alice'), { city: 'sohar' }));
    await assertFails(getDoc(doc(real('bob'), 'users/alice')));
  });

  const newProduct = (uid, o = {}) => ({
    name: 'Tea', categoryId: 'beverages', createdBy: uid, searchKeywords: ['tea'], latestPrices: {}, ...o,
  });

  it('real users create products; guests and forgeries cannot', async () => {
    await assertSucceeds(setDoc(doc(real('alice'), 'products/new1'), newProduct('alice')));
    await assertFails(setDoc(doc(guest('gus'), 'products/new2'), newProduct('gus')));
    await assertFails(setDoc(doc(real('alice'), 'products/new3'), newProduct('bob')));
    await assertFails(setDoc(doc(real('alice'), 'products/new4'), newProduct('alice', { name: '' })));
    await assertFails(setDoc(doc(real('alice'), 'products/new5'), newProduct('alice', {
      latestPrices: { x: { priceBaisa: 1 } },
    })));
  });

  const newStore = (uid, o = {}) => ({
    chainId: 'spar', branchName: 'Spar Qurum', city: 'muscat', area: 'Qurum',
    geo: { geopoint: new GeoPoint(23.6, 58.4), geohash: 'tk1w0w14h' },
    addedBy: uid, verified: false, ...o,
  });

  it('real users add unverified branches of known chains', async () => {
    await assertSucceeds(setDoc(doc(real('alice'), 'stores/s1'), newStore('alice')));
    await assertFails(setDoc(doc(real('alice'), 'stores/s2'), newStore('alice', { verified: true })));
    await assertFails(setDoc(doc(real('alice'), 'stores/s3'), newStore('alice', { chainId: 'madeup' })));
    await assertFails(setDoc(doc(guest('gus'), 'stores/s4'), newStore('gus')));
    await assertFails(updateDoc(doc(real('alice'), `stores/${STORE}`), { verified: true }));
  });

  it('catalogue is public to read', async () => {
    const anon = env.unauthenticatedContext().firestore();
    await assertSucceeds(getDoc(doc(anon, 'products/p1')));
    await assertSucceeds(getDoc(doc(anon, `stores/${STORE}`)));
  });
});
