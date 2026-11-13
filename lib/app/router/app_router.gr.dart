// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [BreathingSetupPage]
class BreathingSetupRoute extends PageRouteInfo<void> {
  const BreathingSetupRoute({List<PageRouteInfo>? children})
    : super(BreathingSetupRoute.name, initialChildren: children);

  static const String name = 'BreathingSetupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BreathingSetupPage();
    },
  );
}

/// generated route for
/// [OnboardingPage]
class OnboardingRoute extends PageRouteInfo<OnboardingRouteArgs> {
  OnboardingRoute({
    VoidCallback? onCompleted,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         OnboardingRoute.name,
         args: OnboardingRouteArgs(onCompleted: onCompleted, key: key),
         initialChildren: children,
       );

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OnboardingRouteArgs>(
        orElse: () => const OnboardingRouteArgs(),
      );
      return WrappedRoute(
        child: OnboardingPage(onCompleted: args.onCompleted, key: args.key),
      );
    },
  );
}

class OnboardingRouteArgs {
  const OnboardingRouteArgs({this.onCompleted, this.key});

  final VoidCallback? onCompleted;

  final Key? key;

  @override
  String toString() {
    return 'OnboardingRouteArgs{onCompleted: $onCompleted, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OnboardingRouteArgs) return false;
    return onCompleted == other.onCompleted && key == other.key;
  }

  @override
  int get hashCode => onCompleted.hashCode ^ key.hashCode;
}

/// generated route for
/// [SessionShellPage]
class SessionShellRoute extends PageRouteInfo<void> {
  const SessionShellRoute({List<PageRouteInfo>? children})
    : super(SessionShellRoute.name, initialChildren: children);

  static const String name = 'SessionShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SessionShellPage());
    },
  );
}

/// generated route for
/// [SummaryPage]
class SummaryRoute extends PageRouteInfo<void> {
  const SummaryRoute({List<PageRouteInfo>? children})
    : super(SummaryRoute.name, initialChildren: children);

  static const String name = 'SummaryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SummaryPage();
    },
  );
}
