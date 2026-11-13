// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'UserDto',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      requiredKeys: const ['first_name', 'last_name', 'birth_date'],
    );
    final val = UserDto(
      firstName: $checkedConvert('first_name', (v) => v as String),
      lastName: $checkedConvert('last_name', (v) => v as String),
      birthDate: $checkedConvert(
        'birth_date',
        (v) => const IsoDateConverter().fromJson(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'firstName': 'first_name',
    'lastName': 'last_name',
    'birthDate': 'birth_date',
  },
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'birth_date': const IsoDateConverter().toJson(instance.birthDate),
};
