import 'package:flutter_test/flutter_test.dart';
import 'package:pricemate/features/products/domain/search_keywords.dart';

void main() {
  test('prefixes of every token in both languages plus the barcode', () {
    final k = buildSearchKeywords(
      name: 'Fresh Milk',
      nameAr: 'حليب طازج',
      brand: 'Almarai',
      barcode: '6281007',
    );
    expect(k, containsAll(['fr', 'fre', 'fresh', 'mi', 'mil', 'milk']));
    expect(k, containsAll(['حل', 'حلي', 'حليب', 'طازج']));
    expect(k, containsAll(['al', 'almarai', '6281007']));
    expect(k, isNot(contains('f'))); // single letters would match everything
  });

  test('Arabic spelling variants fold together', () {
    expect(normalizeSearchText('أُرز'), normalizeSearchText('ارز'));
    expect(normalizeSearchText('مدرسة'), normalizeSearchText('مدرسه'));
    expect(normalizeSearchText('حَلِيب'), 'حليب');
  });

  test('query: longest token goes to Firestore, all tokens verified locally', () {
    final q = parseSearchQuery('  Fresh  MIL ')!;
    expect(q.queryToken, 'fresh');
    expect(q.tokens, ['fresh', 'mil']);
    expect(parseSearchQuery('   '), isNull);
  });

  test('a typed query matches the keywords of the product it describes', () {
    final k = buildSearchKeywords(name: 'Basmati Rice 5kg', nameAr: 'أرز بسمتي');
    for (final input in ['bas rice', 'RICE', 'ارز', 'أرز بسم', '5kg']) {
      expect(
        parseSearchQuery(input)!.tokens.every(k.contains),
        isTrue,
        reason: input,
      );
    }
    expect(parseSearchQuery('rice pasta')!.tokens.every(k.contains), isFalse);
  });
}
