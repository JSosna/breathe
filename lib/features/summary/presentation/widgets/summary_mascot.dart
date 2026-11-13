import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';
import 'package:medcare_breathing/features/breathing/presentation/bloc/breathing_setup_bloc.dart';
import 'package:medcare_breathing/features/breathing/presentation/breath_goal_style.dart';
import 'package:medcare_breathing/features/summary/presentation/cubit/summary_cubit.dart';
import 'package:medcare_breathing/shared/mascot/mascot_slot.dart';

class SummaryMascot extends StatelessWidget {
  const new({super.key});

  static const _loadingMood = 50.0;
  static const _errorMood = 0.0;

  @override
  Widget build(BuildContext context) {
    final goal = context.select<BreathingSetupBloc, BreathGoal>(
      (bloc) => bloc.state.goal,
    );
    final state = context.watch<SummaryCubit>().state;
    return MascotSlot(
      mood: switch (state) {
        SummaryLoaded(:final summary) => summary.mood,
        SummaryLoading() => _loadingMood,
        SummaryError() => _errorMood,
      },
      tint: goal.colorOf(context),
    );
  }
}
