import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/features/user/data/models/user_dto.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';

@injectable
class UserMapper {
  const new();

  UserProfile toDomain(UserDto dto) => UserProfile(
    firstName: dto.firstName,
    lastName: dto.lastName,
    birthDate: dto.birthDate,
  );

  UserDto toDto(UserProfile profile) => UserDto(
    firstName: profile.firstName,
    lastName: profile.lastName,
    birthDate: DateTime(
      profile.birthDate.year,
      profile.birthDate.month,
      profile.birthDate.day,
    ),
  );
}
