import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/di/injection.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breathing_settings.dart';
import 'package:medcare_breathing/features/breathing/presentation/bloc/breathing_setup_bloc.dart';
import 'package:medcare_breathing/features/summary/presentation/cubit/summary_cubit.dart';

@RoutePage()
class SessionShellPage extends StatelessWidget implements AutoRouteWrapper {
  const new({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => getIt<BreathingSetupBloc>()),
      BlocProvider(
        create: (context) {
          final cubit = getIt<SummaryCubit>()
            ..settingsChanged(context.read<BreathingSetupBloc>().state);
          unawaited(cubit.load());
          return cubit;
        },
      ),
    ],
    child: BlocListener<BreathingSetupBloc, BreathingSettings>(
      listener: (context, settings) =>
          context.read<SummaryCubit>().settingsChanged(settings),
      child: this,
    ),
  );

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
