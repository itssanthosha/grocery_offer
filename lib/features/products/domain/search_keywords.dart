const _maxPrefix = 12;

final _tashkeel = RegExp('[\u064B-\u065F\u0670\u0640]'); // harakat + tatweel
final _separators = RegExp(r'[^\p{L}\p{N}]+', unicode: true);

/// Lowercases and folds Arabic spelling variants so "أُرز", "ارز" and "إرز"
/// all match.
String normalizeSearchText(String s) => s
    .toLowerCase()
    .replaceAll(_tashkeel, '')
    .replaceAll(RegExp('[أإآٱ]'), 'ا')
    .replaceAll('ى', 'ي')
    .replaceAll('ة', 'ه');

List<String> searchTokens(String text) => normalizeSearchText(
  text,
).split(_separators).where((t) => t.isNotEmpty).toList();

/// `products.searchKeywords`: for every token of the English name, Arabic name
/// and brand we store its prefixes (2..12 chars) plus the whole token, so
/// `arrayContains` finds "mil" -> "milk" without a search service. The barcode
/// is stored whole.
List<String> buildSearchKeywords({
  required String name,
  String? nameAr,
  String? brand,
  String? barcode,
}) {
  final keywords = <String>{};
  for (final text in [name, ?nameAr, ?brand]) {
    for (final token in searchTokens(text)) {
      keywords.add(token.length > _maxPrefix ? token.substring(0, _maxPrefix) : token);
      for (var i = 2; i < token.length && i <= _maxPrefix; i++) {
        keywords.add(token.substring(0, i));
      }
    }
  }
  if (barcode != null && barcode.isNotEmpty) keywords.add(barcode);
  return keywords.toList()..sort();
}

/// What a user typed, split into the token to query Firestore with (the
/// longest one: most selective) and all tokens to verify client-side.
({String queryToken, List<String> tokens})? parseSearchQuery(String input) {
  final tokens = searchTokens(input)
      .map((t) => t.length > _maxPrefix ? t.substring(0, _maxPrefix) : t)
      .toList();
  if (tokens.isEmpty) return null;
  final longest = tokens.reduce((a, b) => b.length > a.length ? b : a);
  return (queryToken: longest, tokens: tokens);
}
