abstract final class PersonName {
  static const maxLength = 30;

  static String? normalize(String raw) {
    final collapsed = raw.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (collapsed.isEmpty) return null;
    final runes = collapsed.runes;
    return runes.length <= maxLength
        ? collapsed
        : String.fromCharCodes(runes.take(maxLength));
  }
}
