import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/app/router/app_router.dart';
import 'package:medcare_breathing/features/onboarding/domain/usecases/is_onboarding_completed_use_case.dart';

@lazySingleton
class OnboardingGuard extends AutoRouteGuard {
  new(this._isOnboardingCompleted);

  final IsOnboardingCompletedUseCase _isOnboardingCompleted;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    if (await _isOnboardingCompleted()) {
      resolver.next();
    } else {
      resolver.redirectUntil(OnboardingRoute(onCompleted: resolver.next));
    }
  }
}
