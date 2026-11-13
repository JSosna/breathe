import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/features/user/data/mappers/user_mapper.dart';
import 'package:medcare_breathing/features/user/data/models/user_dto.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';

void main() {
  const mapper = UserMapper();
  final dto = UserDto(
    firstName: 'Anna',
    lastName: 'Kowalska',
    birthDate: DateTime(1991, 3, 14),
  );
  final profile = UserProfile(
    firstName: 'Anna',
    lastName: 'Kowalska',
    birthDate: DateTime(1991, 3, 14),
  );

  test('maps the backend model to the domain entity', () {
    expect(mapper.toDomain(dto), profile);
  });

  test('maps the domain entity to the backend model', () {
    final mapped = mapper.toDto(profile);
    expect(mapped.firstName, 'Anna');
    expect(mapped.lastName, 'Kowalska');
    expect(mapped.birthDate, DateTime(1991, 3, 14));
  });

  test('drops the time of day from the birth date', () {
    final withTime = UserProfile(
      firstName: 'Anna',
      lastName: 'Kowalska',
      birthDate: DateTime(1991, 3, 14, 23, 59),
    );
    expect(mapper.toDto(withTime).birthDate, DateTime(1991, 3, 14));
  });
}
