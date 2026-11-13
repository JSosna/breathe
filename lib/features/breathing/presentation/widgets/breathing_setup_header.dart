import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';
import 'package:medcare_breathing/features/breathing/presentation/bloc/breathing_setup_bloc.dart';
import 'package:medcare_breathing/features/breathing/presentation/breath_goal_style.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';
import 'package:medcare_breathing/shared/mascot/mascot_slot.dart';

class BreathingSetupHeader extends StatelessWidget {
  const new({super.key});

  static const _mascotSize = 76.0;
  static const _watchingMood = 50.0;

  @override
  Widget build(BuildContext context) {
    final goal = context.select<BreathingSetupBloc, BreathGoal>(
      (bloc) => bloc.state.goal,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.t.setupTitle,
                style: context.textTheme.headlineMedium,
              ),
              const SizedBox(height: Spacings.sp4),
              Text(
                context.t.setupSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.palette.inkMuted,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: Spacings.sp12),
        SizedBox.square(
          dimension: _mascotSize,
          child: MascotSlot(mood: _watchingMood, tint: goal.colorOf(context)),
        ),
      ],
    );
  }
}
