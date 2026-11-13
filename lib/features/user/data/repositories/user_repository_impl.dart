import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/core/error/failure.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/user/data/datasources/user_remote_data_source.dart';
import 'package:medcare_breathing/features/user/data/mappers/user_mapper.dart';
import 'package:medcare_breathing/features/user/data/models/user_dto.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';
import 'package:medcare_breathing/features/user/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  const new(this._remote, this._mapper);

  final UserRemoteDataSource _remote;
  final UserMapper _mapper;

  @override
  Future<Result<UserProfile>> getProfile() async {
    try {
      return Success(_mapper.toDomain(await _remote.fetchProfile()));
    } on ProfileNotFoundException {
      return const Failed(NotFoundFailure());
    } on UserDtoFormatException {
      return const Failed(ParsingFailure());
    } on Exception {
      return const Failed(NetworkFailure());
    }
  }

  @override
  Future<Result<void>> saveProfile(UserProfile profile) async {
    try {
      await _remote.sendProfile(_mapper.toDto(profile));
      return const Success(null);
    } on Exception {
      return const Failed(NetworkFailure());
    }
  }
}
