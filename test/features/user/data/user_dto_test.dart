import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/features/user/data/models/user_dto.dart';

void main() {
  const validJson = {
    'first_name': 'Anna',
    'last_name': 'Kowalska',
    'birth_date': '1991-03-14',
  };

  group('UserDto.fromJson', () {
    test('reads the backend contract', () {
      final dto = UserDto.fromJson(validJson);

      expect(dto.firstName, 'Anna');
      expect(dto.lastName, 'Kowalska');
      expect(dto.birthDate, DateTime(1991, 3, 14));
    });

    test('rejects a payload with a missing field', () {
      expect(
        () => UserDto.fromJson({...validJson}..remove('last_name')),
        throwsA(isA<UserDtoFormatException>()),
      );
    });

    test('rejects a field of the wrong type', () {
      expect(
        () => UserDto.fromJson(Map.of(validJson)..['last_name'] = 42),
        throwsA(isA<UserDtoFormatException>()),
      );
    });

    test('rejects a date that is not YYYY-MM-DD', () {
      expect(
        () =>
            UserDto.fromJson(Map.of(validJson)..['birth_date'] = '14.03.1991'),
        throwsA(isA<UserDtoFormatException>()),
      );
    });
  });

  group('UserDto.toJson', () {
    test('writes snake_case keys and a zero-padded date', () {
      final dto = UserDto(
        firstName: 'Jan',
        lastName: 'Nowak',
        birthDate: DateTime(2001, 2, 3),
      );

      expect(dto.toJson(), {
        'first_name': 'Jan',
        'last_name': 'Nowak',
        'birth_date': '2001-02-03',
      });
    });
  });
}
