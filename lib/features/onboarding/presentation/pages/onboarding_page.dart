import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/app/router/app_router.dart';
import 'package:medcare_breathing/core/di/injection.dart';
import 'package:medcare_breathing/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:medcare_breathing/features/onboarding/presentation/widgets/onboarding_view.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget implements AutoRouteWrapper {
  const new({this.onCompleted, super.key});

  final VoidCallback? onCompleted;

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider(create: (_) => getIt<OnboardingCubit>(), child: this);

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (_, current) => current.status == OnboardingStatus.completed,
      listener: (context, _) => _onCompleted(context),
      child: const OnboardingView(),
    );
  }

  void _onCompleted(BuildContext context) {
    final onCompleted = this.onCompleted;

    if (onCompleted != null) {
      onCompleted();
    } else {
      unawaited(context.router.replaceAll([const SessionShellRoute()]));
    }
  }
}
