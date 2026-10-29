import 'package:flutter_test/flutter_test.dart';
import 'package:pricemate/features/products/domain/unit_price.dart';

void main() {
  UnitPrice? up(int baisa, String? size) => unitPrice(baisa, size);

  test('kg and g are normalised to price per kg', () {
    expect(up(1250, '1 kg')!.baisa, 1250);
    expect(up(1250, '1 kg')!.kind, UnitKind.kg);
    expect(up(450, '500g')!.baisa, 900);
    expect(up(450, '500 G')!.baisa, 900);
  });

  test('ml, l are normalised to price per litre', () {
    expect(up(300, '500 ml')!.baisa, 600);
    expect(up(300, '500 ml')!.kind, UnitKind.litre);
    expect(up(1800, '1.5 L')!.baisa, 1200);
    expect(up(1800, '1,5 l')!.baisa, 1200);
  });

  test('multipacks multiply', () {
    expect(up(1200, '6 x 200 ml')!.baisa, 1000); // 1.2 L
    expect(up(1200, '6\u00d7200ml')!.baisa, 1000);
  });

  test('pieces', () {
    expect(up(1200, '12 pcs')!.baisa, 100);
    expect(up(1200, '12 pcs')!.kind, UnitKind.piece);
  });

  test('Arabic units', () {
    expect(up(900, '500 \u062c\u0645')!.baisa, 1800); // 500 ??
    expect(up(900, '2 \u0644\u062a\u0631')!.baisa, 450); // 2 ???
  });

  test('rounds to the nearest baisa', () {
    expect(up(100, '3 kg')!.baisa, 33);
  });

  test('unparseable or zero sizes give null, never throw', () {
    expect(up(100, null), isNull);
    expect(up(100, ''), isNull);
    expect(up(100, 'large'), isNull);
    expect(up(100, '0 kg'), isNull);
    expect(up(100, '5 parsecs'), isNull);
  });
}
