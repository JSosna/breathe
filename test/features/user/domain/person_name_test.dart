import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/features/user/domain/entities/person_name.dart';

void main() {
  group('PersonName.normalize', () {
    test('trims and collapses inner whitespace', () {
      expect(PersonName.normalize('  Jan   Maria '), 'Jan Maria');
    });

    test('returns null for an empty or blank name', () {
      expect(PersonName.normalize(''), isNull);
      expect(PersonName.normalize('   \n '), isNull);
    });

    test('caps the length without splitting characters', () {
      final long = 'Ż' * 40;
      expect(PersonName.normalize(long), 'Ż' * PersonName.maxLength);
      expect(PersonName.normalize('${'a' * 29}😊😊'), '${'a' * 29}😊');
    });
  });
}
