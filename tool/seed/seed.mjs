// Seeds Firestore `chains/` and `stores/` (idempotent: fixed ids, merge writes).
//
//   cd tool/seed && npm install
//   set GOOGLE_APPLICATION_CREDENTIALS=path\to\service-account.json   (PowerShell: $env:...)
//   node seed.mjs            # writes to project groceryapp-ac3e7
//   node seed.mjs --dry-run  # prints what would be written
//
// Branch coordinates are APPROXIMATE area centres (not surveyed GPS pins), and
// every seeded store is `verified: false`. Users add exact branches in the app
// and an admin can correct/verify these later.
import { initializeApp, applicationDefault } from 'firebase-admin/app';
import { getFirestore, GeoPoint } from 'firebase-admin/firestore';
import ngeohash from 'ngeohash';

const PROJECT_ID = 'groceryapp-ac3e7';
const dryRun = process.argv.includes('--dry-run');

// Keep ids/names in sync with lib/features/stores/domain/chain.dart.
const chains = {
  lulu: ['Lulu Hypermarket', 'لولو هايبرماركت'],
  carrefour: ['Carrefour', 'كارفور'],
  nesto: ['Nesto', 'نستو'],
  alfair: ['Al Fair', 'الفير'],
  almeera: ['Al Meera', 'الميرة'],
  safeer: ['Safeer', 'السفير'],
  sultancenter: ['Sultan Center', 'مركز السلطان'],
  spar: ['Spar', 'سبار'],
  ramez: ['Ramez', 'رامز'],
  kmtrading: ['KM Trading', 'كي إم للتجارة'],
  mars: ['Mars Hypermarket', 'مارس هايبرماركت'],
};

// area -> [city (OmanCity enum name), lat, lng]
const areas = {
  'Al Khuwair': ['muscat', 23.589, 58.415],
  Qurum: ['muscat', 23.62, 58.47],
  Ruwi: ['muscat', 23.595, 58.535],
  Azaiba: ['muscat', 23.615, 58.385],
  Ghubra: ['muscat', 23.58, 58.37],
  Bawshar: ['bawshar', 23.575, 58.4],
  'Al Mawaleh': ['seeb', 23.627, 58.15],
  Seeb: ['seeb', 23.67, 58.19],
  Barka: ['barka', 23.68, 57.89],
  Sohar: ['sohar', 24.347, 56.709],
  Salalah: ['salalah', 17.015, 54.092],
  Nizwa: ['nizwa', 22.933, 57.533],
  Sur: ['sur', 22.567, 59.529],
  Ibri: ['ibri', 23.226, 56.516],
  Rustaq: ['rustaq', 23.39, 57.424],
  Buraimi: ['buraimi', 24.25, 55.793],
  Khasab: ['khasab', 26.18, 56.24],
};

const branches = {
  lulu: ['Ghubra', 'Qurum', 'Al Khuwair', 'Seeb', 'Sohar', 'Salalah', 'Nizwa', 'Sur', 'Barka', 'Buraimi'],
  carrefour: ['Qurum', 'Al Mawaleh', 'Seeb', 'Sohar', 'Salalah'],
  nesto: ['Ruwi', 'Al Khuwair', 'Bawshar', 'Seeb', 'Sohar', 'Nizwa', 'Salalah', 'Sur'],
  alfair: ['Qurum', 'Al Khuwair', 'Ruwi', 'Sohar'],
  almeera: ['Ruwi', 'Seeb', 'Bawshar', 'Barka', 'Sohar', 'Nizwa', 'Salalah', 'Sur', 'Ibri', 'Rustaq', 'Buraimi', 'Khasab'],
  safeer: ['Azaiba', 'Qurum', 'Seeb'],
  sultancenter: ['Qurum', 'Al Khuwair', 'Ghubra'],
  spar: ['Al Khuwair', 'Ruwi', 'Bawshar'],
  ramez: ['Azaiba', 'Seeb', 'Sohar', 'Barka', 'Salalah'],
  kmtrading: ['Ruwi', 'Al Khuwair', 'Bawshar', 'Seeb'],
  mars: ['Seeb', 'Bawshar', 'Sohar', 'Barka', 'Nizwa'],
};

const slug = (s) => s.toLowerCase().replace(/[^a-z0-9]+/g, '');

const docs = [];
for (const [chainId, [name, nameAr]] of Object.entries(chains)) {
  docs.push([`chains/${chainId}`, { name, nameAr, logoUrl: null }]);
}
const chainIds = Object.keys(chains);
for (const [chainId, list] of Object.entries(branches)) {
  const jitter = chainIds.indexOf(chainId) * 0.0007; // keep chains' pins apart
  for (const area of list) {
    const [city, lat0, lng0] = areas[area];
    const lat = +(lat0 + jitter).toFixed(5);
    const lng = +(lng0 + jitter).toFixed(5);
    docs.push([
      `stores/${chainId}_${slug(area)}`,
      {
        chainId,
        branchName: `${chains[chainId][0]} ${area}`,
        city,
        area,
        geo: { geopoint: new GeoPoint(lat, lng), geohash: ngeohash.encode(lat, lng, 9) },
        addedBy: 'seed',
        verified: false,
      },
    ]);
  }
}

if (dryRun) {
  for (const [path, data] of docs) console.log(path, JSON.stringify(data));
  console.log(`\n${docs.length} documents (dry run, nothing written)`);
  process.exit(0);
}

initializeApp({ credential: applicationDefault(), projectId: PROJECT_ID });
const db = getFirestore();
const batch = db.batch();
for (const [path, data] of docs) batch.set(db.doc(path), data, { merge: true });
await batch.commit();
console.log(`Wrote ${docs.length} documents to ${PROJECT_ID}`);
