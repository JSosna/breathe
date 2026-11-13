import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/core/json/iso_date_converter.dart';

void main() {
  const converter = IsoDateConverter();

  test('parses a calendar date', () {
    expect(converter.fromJson('1994-05-17'), DateTime(1994, 5, 17));
  });

  test('accepts a leap day', () {
    expect(converter.fromJson('2000-02-29'), DateTime(2000, 2, 29));
  });

  test('rejects dates that do not exist', () {
    for (final json in [
      '2001-02-30',
      '2001-02-29',
      '2001-13-01',
      '2001-04-31',
    ]) {
      expect(
        () => converter.fromJson(json),
        throwsFormatException,
        reason: json,
      );
    }
  });

  test('rejects anything that is not YYYY-MM-DD', () {
    expect(() => converter.fromJson('17.05.1994'), throwsFormatException);
  });

  test('writes zero-padded dates', () {
    expect(converter.toJson(DateTime(7, 3, 9)), '0007-03-09');
  });
}
