import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';

void main() {
  group('UserProfile', () {
    final profile = UserProfile(
      firstName: 'Anna',
      lastName: 'Kowalska',
      birthDate: DateTime(1990, 6, 15),
    );

    group('ageAt', () {
      test('is one year less on the day before the birthday', () {
        expect(profile.ageAt(DateTime(2026, 6, 14)), 35);
      });

      test('counts the full year on the birthday itself', () {
        expect(profile.ageAt(DateTime(2026, 6, 15)), 36);
      });

      test('ignores the time of day', () {
        expect(profile.ageAt(DateTime(2026, 6, 15, 0, 0, 1)), 36);
        expect(profile.ageAt(DateTime(2026, 6, 14, 23, 59)), 35);
      });

      test('is zero for a birth date in the future', () {
        expect(profile.ageAt(DateTime(1980)), 0);
      });

      group('born on 29 February', () {
        final leapling = UserProfile(
          firstName: 'Jan',
          lastName: 'Nowak',
          birthDate: DateTime(2000, 2, 29),
        );

        test('has not had a birthday yet on 28 Feb of a common year', () {
          expect(leapling.ageAt(DateTime(2027, 2, 28)), 26);
        });

        test('celebrates on 1 March in a common year', () {
          expect(leapling.ageAt(DateTime(2027, 3)), 27);
        });

        test('celebrates on 29 Feb in a leap year', () {
          expect(leapling.ageAt(DateTime(2028, 2, 29)), 28);
        });
      });
    });
  });
}
