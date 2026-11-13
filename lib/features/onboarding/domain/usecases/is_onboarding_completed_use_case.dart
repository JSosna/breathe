import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/features/onboarding/domain/repositories/onboarding_repository.dart';

@injectable
class IsOnboardingCompletedUseCase {
  const new(this._repository);

  final OnboardingRepository _repository;

  Future<bool> call() => _repository.isCompleted();
}
