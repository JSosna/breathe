import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/features/user/data/models/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class UserRemoteDataSource {
  Future<UserDto> fetchProfile();

  Future<void> sendProfile(UserDto profile);
}

class ProfileNotFoundException implements Exception {
  const new();
}

class ProfileSaveException implements Exception {
  const new();
}

@LazySingleton(as: UserRemoteDataSource)
class MockUserRemoteDataSource implements UserRemoteDataSource {
  const new(this._serverStorage);

  static const latency = Duration(milliseconds: 1200);
  static const storageKey = 'mock_backend.users.me';

  final SharedPreferences _serverStorage;

  @override
  Future<UserDto> fetchProfile() async {
    await Future<void>.delayed(latency);
    final body = _serverStorage.getString(storageKey);
    if (body == null) throw const ProfileNotFoundException();
    return UserDto.fromJson(_decodeObject(body));
  }

  @override
  Future<void> sendProfile(UserDto profile) async {
    await Future<void>.delayed(latency);
    final saved = await _serverStorage.setString(
      storageKey,
      jsonEncode(profile.toJson()),
    );
    if (!saved) throw const ProfileSaveException();
  }

  Map<String, dynamic> _decodeObject(String body) {
    final Object? decoded;
    try {
      decoded = jsonDecode(body);
    } on FormatException catch (error) {
      throw UserDtoFormatException(error.message, body);
    }
    if (decoded is! Map<String, dynamic>) {
      throw UserDtoFormatException('Expected a JSON object', body);
    }
    return decoded;
  }
}
