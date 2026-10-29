import 'package:flutter_test/flutter_test.dart';
import 'package:pricemate/core/utils/currency_formatter.dart';

void main() {
  test('always shows 3 decimals', () {
    expect(formatOmr(1250), 'OMR 1.250');
    expect(formatOmr(1000), 'OMR 1.000');
    expect(formatOmr(5), 'OMR 0.005');
    expect(formatOmr(0), 'OMR 0.000');
    expect(formatOmr(1), 'OMR 0.001');
  });

  test('groups thousands and handles the 1,000,000 baisa max', () {
    expect(formatOmr(1000000), 'OMR 1,000.000');
    expect(formatOmr(123456), 'OMR 123.456');
  });

  test('Arabic uses the Arabic symbol but still 3 decimals', () {
    expect(formatOmr(1250, languageCode: 'ar'), '1.250 ر.ع.');
  });
}
