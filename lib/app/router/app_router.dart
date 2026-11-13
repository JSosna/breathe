import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/app/router/fade_through.dart';
import 'package:medcare_breathing/app/router/onboarding_guard.dart';
import 'package:medcare_breathing/features/breathing/presentation/pages/breathing_setup_page.dart';
import 'package:medcare_breathing/features/breathing/presentation/pages/session_shell_page.dart';
import 'package:medcare_breathing/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:medcare_breathing/features/summary/presentation/pages/summary_page.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  new(this._onboardingGuard);

  static const _transition = Duration(milliseconds: 400);

  final OnboardingGuard _onboardingGuard;

  @override
  RouteType get defaultRouteType => RouteType.custom(
    transitionsBuilder: FadeThrough.build,
    duration: _transition,
    reverseDuration: _transition,
  );

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(
      page: SessionShellRoute.page,
      initial: true,
      guards: [_onboardingGuard],
      children: [
        AutoRoute(page: BreathingSetupRoute.page, initial: true),
        AutoRoute(page: SummaryRoute.page),
      ],
    ),
  ];
}
