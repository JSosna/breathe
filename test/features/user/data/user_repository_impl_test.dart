import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/core/error/failure.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/user/data/datasources/user_remote_data_source.dart';
import 'package:medcare_breathing/features/user/data/mappers/user_mapper.dart';
import 'package:medcare_breathing/features/user/data/models/user_dto.dart';
import 'package:medcare_breathing/features/user/data/repositories/user_repository_impl.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements UserRemoteDataSource;

void main() {
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

  late _MockRemote remote;
  late UserRepositoryImpl repository;

  setUpAll(() => registerFallbackValue(dto));

  setUp(() {
    remote = _MockRemote();
    repository = UserRepositoryImpl(remote, const UserMapper());
  });

  group('getProfile', () {
    test('returns the mapped profile', () async {
      when(remote.fetchProfile).thenAnswer((_) async => dto);
      expect(await repository.getProfile(), Success(profile));
    });

    test('maps a missing profile to NotFoundFailure', () async {
      when(remote.fetchProfile).thenThrow(const ProfileNotFoundException());
      expect(
        await repository.getProfile(),
        const Failed<UserProfile>(NotFoundFailure()),
      );
    });

    test('maps a malformed payload to ParsingFailure', () async {
      when(remote.fetchProfile)
          .thenThrow(const UserDtoFormatException('bad', {}));
      expect(
        await repository.getProfile(),
        const Failed<UserProfile>(ParsingFailure()),
      );
    });

    test('maps transport errors to NetworkFailure', () async {
      when(remote.fetchProfile).thenThrow(Exception('timeout'));
      expect(
        await repository.getProfile(),
        const Failed<UserProfile>(NetworkFailure()),
      );
    });
  });

  group('saveProfile', () {
    test('sends the mapped profile', () async {
      when(() => remote.sendProfile(any())).thenAnswer((_) async {});

      expect(await repository.saveProfile(profile), const Success<void>(null));
      verify(() => remote.sendProfile(dto)).called(1);
    });

    test('maps transport errors to NetworkFailure', () async {
      when(() => remote.sendProfile(any())).thenThrow(Exception('offline'));
      expect(
        await repository.saveProfile(profile),
        const Failed<void>(NetworkFailure()),
      );
    });
  });
}
