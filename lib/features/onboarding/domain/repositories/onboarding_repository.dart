import 'package:medcare_breathing/core/result.dart';

abstract interface class OnboardingRepository {
  Future<bool> isCompleted();

  Future<Result<void>> complete();
}
