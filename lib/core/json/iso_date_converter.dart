import 'package:json_annotation/json_annotation.dart';

class IsoDateConverter implements JsonConverter<DateTime, String> {
  const new();

  static final _pattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

  @override
  DateTime fromJson(String json) {
    if (!_pattern.hasMatch(json)) {
      throw FormatException('Expected a YYYY-MM-DD date', json);
    }
    final date = DateTime.parse(json);
    if (toJson(date) != json) {
      throw FormatException('Not a real calendar date', json);
    }
    return date;
  }

  @override
  String toJson(DateTime date) =>
      '${_pad(date.year, 4)}-${_pad(date.month, 2)}-${_pad(date.day, 2)}';

  String _pad(int value, int width) => value.toString().padLeft(width, '0');
}
