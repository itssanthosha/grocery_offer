import 'package:intl/intl.dart';

/// Prices are stored as integer baisa (1 OMR = 1000 baisa) and ALWAYS shown
/// with 3 decimals. Latin digits are used in both languages so prices stay
/// unambiguous when read aloud or compared across screens.
final _omr = NumberFormat('#,##0.000', 'en');

/// `1250` -> `OMR 1.250` (or `1.250 ر.ع.` for Arabic).
String formatOmr(int baisa, {String languageCode = 'en'}) {
  final number = _omr.format(baisa / 1000);
  return languageCode == 'ar' ? '$number ر.ع.' : 'OMR $number';
}
