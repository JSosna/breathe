import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/core/error/failure.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:medcare_breathing/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocal extends Mock implements OnboardingLocalDataSource;

void main() {
  late _MockLocal local;
  late OnboardingRepositoryImpl repository;

  setUp(() {
    local = _MockLocal();
    repository = OnboardingRepositoryImpl(local);
  });

  test('complete succeeds when the flag is written', () async {
    when(local.writeCompleted).thenAnswer((_) async {});
    expect(await repository.complete(), const Success<void>(null));
  });

  test('complete maps storage errors to StorageFailure', () async {
    when(local.writeCompleted).thenThrow(Exception('disk full'));
    expect(await repository.complete(), const Failed<void>(StorageFailure()));
  });
}
