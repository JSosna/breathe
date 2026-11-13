import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/onboarding/domain/repositories/onboarding_repository.dart';

@injectable
class CompleteOnboardingUseCase {
  const new(this._repository);

  final OnboardingRepository _repository;

  Future<Result<void>> call() => _repository.complete();
}
