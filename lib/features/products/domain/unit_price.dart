enum UnitKind {
  kg('kg'),
  litre('l'),
  piece('pcs');

  const UnitKind(this.code);

  /// Stored in `products.unit`.
  final String code;
}

class UnitPrice {
  const UnitPrice(this.baisa, this.kind);

  /// Price in baisa per 1 [kind] (per kg / per litre / per piece).
  final int baisa;
  final UnitKind kind;
}

class ParsedSize {
  const ParsedSize(this.amount, this.kind);
  final double amount; // in kg / litres / pieces
  final UnitKind kind;
}

final _sizeRe = RegExp(
  r'^\s*(?:(\d+)\s*[x×*]\s*)?(\d+(?:[.,]\d+)?)\s*([^\d\s.,]+)\s*$',
  caseSensitive: false,
);

/// Unit name -> (kind, multiplier to kg / litre / piece).
const _units = <String, (UnitKind, double)>{
  'kg': (UnitKind.kg, 1),
  'kgs': (UnitKind.kg, 1),
  'كجم': (UnitKind.kg, 1),
  'كغ': (UnitKind.kg, 1),
  'g': (UnitKind.kg, 0.001),
  'gm': (UnitKind.kg, 0.001),
  'gms': (UnitKind.kg, 0.001),
  'gram': (UnitKind.kg, 0.001),
  'grams': (UnitKind.kg, 0.001),
  'جم': (UnitKind.kg, 0.001),
  'غ': (UnitKind.kg, 0.001),
  'l': (UnitKind.litre, 1),
  'ltr': (UnitKind.litre, 1),
  'litre': (UnitKind.litre, 1),
  'liter': (UnitKind.litre, 1),
  'لتر': (UnitKind.litre, 1),
  'ml': (UnitKind.litre, 0.001),
  'مل': (UnitKind.litre, 0.001),
  'cl': (UnitKind.litre, 0.01),
  'pc': (UnitKind.piece, 1),
  'pcs': (UnitKind.piece, 1),
  'piece': (UnitKind.piece, 1),
  'pieces': (UnitKind.piece, 1),
  'pack': (UnitKind.piece, 1),
  'حبة': (UnitKind.piece, 1),
};

/// Parses sizes like `1 kg`, `500ml`, `1.5 L`, `6 x 200 ml`, `12 pcs`.
/// Returns null when the size is missing or not understood.
ParsedSize? parseSize(String? size) {
  final m = size == null ? null : _sizeRe.firstMatch(size);
  if (m == null) return null;
  final unit = _units[m.group(3)!.toLowerCase()];
  if (unit == null) return null;
  final count = double.parse(m.group(1) ?? '1');
  final amount = double.parse(m.group(2)!.replaceAll(',', '.'));
  final total = count * amount * unit.$2;
  return total > 0 ? ParsedSize(total, unit.$1) : null;
}

/// Price per kg / litre / piece for fair comparison, or null if the size can't
/// be parsed (callers then simply hide the unit price).
UnitPrice? unitPrice(int priceBaisa, String? size) {
  final s = parseSize(size);
  if (s == null) return null;
  return UnitPrice((priceBaisa / s.amount).round(), s.kind);
}
