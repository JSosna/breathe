import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/features/user/domain/entities/birth_date_rules.dart';

void main() {
  final today = DateTime(2026, 11, 12, 18, 30);

  group('BirthDateRules', () {
    test('accepts today and dates in the past', () {
      expect(BirthDateRules.isValid(DateTime(2026, 11, 12), today), isTrue);
      expect(BirthDateRules.isValid(DateTime(1991, 3, 14), today), isTrue);
    });

    test('rejects dates in the future', () {
      expect(BirthDateRules.isValid(DateTime(2026, 11, 13), today), isFalse);
    });

    test('rejects people older than the supported maximum', () {
      expect(BirthDateRules.earliest(today), DateTime(1906, 11, 12));
      expect(BirthDateRules.isValid(DateTime(1906, 11, 12), today), isTrue);
      expect(BirthDateRules.isValid(DateTime(1906, 11, 11), today), isFalse);
    });
  });
}
