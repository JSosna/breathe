import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/core/error/failure.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:medcare_breathing/features/onboarding/domain/repositories/onboarding_repository.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  const new(this._local);

  final OnboardingLocalDataSource _local;

  @override
  Future<bool> isCompleted() async => _local.readCompleted();

  @override
  Future<Result<void>> complete() async {
    try {
      await _local.writeCompleted();

      return const Success(null);
    } on Object {
      return const Failed(StorageFailure());
    }
  }
}
