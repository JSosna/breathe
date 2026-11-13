import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/features/user/data/datasources/user_remote_data_source.dart';
import 'package:medcare_breathing/features/user/data/models/user_dto.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FailingStorage extends Mock implements SharedPreferences;

void main() {
  final dto = UserDto(
    firstName: 'Jan',
    lastName: 'Nowak',
    birthDate: DateTime(2001, 2, 3),
  );

  late SharedPreferences storage;
  late MockUserRemoteDataSource backend;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    storage = await SharedPreferences.getInstance();
    backend = MockUserRemoteDataSource(storage);
  });

  test('stores the sent profile as JSON after the simulated latency', () {
    fakeAsync((async) {
      var sent = false;
      unawaited(backend.sendProfile(dto).then((_) => sent = true));

      async.elapse(
        MockUserRemoteDataSource.latency - const Duration(milliseconds: 1),
      );
      expect(sent, isFalse);

      async.elapse(const Duration(milliseconds: 1));
      expect(sent, isTrue);
      expect(
        storage.getString(MockUserRemoteDataSource.storageKey),
        '{"first_name":"Jan","last_name":"Nowak","birth_date":"2001-02-03"}',
      );
    });
  });

  test('returns the stored profile on fetch', () {
    fakeAsync((async) {
      UserDto? fetched;
      unawaited(backend.sendProfile(dto));
      async.elapse(MockUserRemoteDataSource.latency);

      unawaited(backend.fetchProfile().then((value) => fetched = value));
      async.elapse(MockUserRemoteDataSource.latency);

      expect(fetched, dto);
    });
  });

  test('answers 404 when no profile was ever sent', () {
    fakeAsync((async) {
      Object? error;
      unawaited(
        backend.fetchProfile().then<void>(
          (_) {},
          onError: (Object e) => error = e,
        ),
      );
      async.elapse(MockUserRemoteDataSource.latency);
      expect(error, isA<ProfileNotFoundException>());
    });
  });
  Object? fetchError(FakeAsync async) {
    Object? error;
    unawaited(
      backend.fetchProfile().then<void>(
        (_) {},
        onError: (Object e) => error = e,
      ),
    );
    async.elapse(MockUserRemoteDataSource.latency);
    return error;
  }

  test('reports malformed JSON as a format error', () async {
    await storage.setString(MockUserRemoteDataSource.storageKey, '{"first');
    fakeAsync((async) {
      expect(fetchError(async), isA<UserDtoFormatException>());
    });
  });

  test('reports a JSON body that is not an object as a format error', () async {
    await storage.setString(MockUserRemoteDataSource.storageKey, '[1, 2]');
    fakeAsync((async) {
      expect(fetchError(async), isA<UserDtoFormatException>());
    });
  });

  test('fails the send when the storage write is rejected', () {
    final failing = _FailingStorage();
    when(() => failing.setString(any(), any())).thenAnswer((_) async => false);
    fakeAsync((async) {
      Object? error;
      unawaited(
        MockUserRemoteDataSource(failing)
            .sendProfile(dto)
            .then<void>((_) {}, onError: (Object e) => error = e),
      );
      async.elapse(MockUserRemoteDataSource.latency);
      expect(error, isA<ProfileSaveException>());
    });
  });
}
