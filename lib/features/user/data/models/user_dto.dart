import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medcare_breathing/core/json/iso_date_converter.dart';

part 'user_dto.g.dart';

@JsonSerializable()
@IsoDateConverter()
class UserDto extends Equatable {
  const new({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  factory fromJson(Map<String, dynamic> json) {
    try {
      return _$UserDtoFromJson(json);
    } on CheckedFromJsonException catch (error) {
      throw UserDtoFormatException(error.message ?? 'Invalid field', json);
    } on BadKeyException catch (error) {
      throw UserDtoFormatException(error.message, json);
    }
  }

  @JsonKey(required: true)
  final String firstName;
  @JsonKey(required: true)
  final String lastName;
  @JsonKey(required: true)
  final DateTime birthDate;

  @override
  List<Object?> get props => [firstName, lastName, birthDate];

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

class UserDtoFormatException extends FormatException {
  const new(super.message, Object super.source);
}
