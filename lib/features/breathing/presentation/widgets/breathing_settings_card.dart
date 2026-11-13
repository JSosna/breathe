import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_cycle.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breathing_settings.dart';
import 'package:medcare_breathing/features/breathing/presentation/bloc/breathing_setup_bloc.dart';
import 'package:medcare_breathing/features/breathing/presentation/widgets/goal_selector.dart';
import 'package:medcare_breathing/features/breathing/presentation/widgets/labeled_slider.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class BreathingSettingsCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BreathingSetupBloc>();
    final settings = context.watch<BreathingSetupBloc>().state;
    final seconds = NumberFormat(
      '0.#',
      Localizations.localeOf(context).languageCode,
    );
    final cycleSeconds = settings.cycle.inMilliseconds / 1000;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Spacings.sp20,
          Spacings.sp16,
          Spacings.sp20,
          Spacings.sp20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LabeledSlider(
              label: context.t.paceLabel,
              value: context.t.paceValue(count: settings.breathsPerMinute),
              caption: context.t.rhythmValue(
                inhale: seconds.format(cycleSeconds * BreathCycle.inhaleShare),
                exhale: seconds.format(
                  cycleSeconds * (1 - BreathCycle.inhaleShare),
                ),
              ),
              current: settings.breathsPerMinute,
              min: BreathingSettings.minBreathsPerMinute,
              max: BreathingSettings.maxBreathsPerMinute,
              onChanged: (value) => bloc.add(BreathingPaceChanged(value)),
            ),
            const SizedBox(height: Spacings.sp8),
            LabeledSlider(
              label: context.t.durationLabel,
              value: context.t.durationValue(minutes: settings.durationMinutes),
              current: settings.durationMinutes,
              min: BreathingSettings.minDurationMinutes,
              max: BreathingSettings.maxDurationMinutes,
              onChanged: (value) => bloc.add(BreathingDurationChanged(value)),
            ),
            const SizedBox(height: Spacings.sp12),
            GoalSelector(
              selected: settings.goal,
              onChanged: (goal) => bloc.add(BreathingGoalChanged(goal)),
            ),
          ],
        ),
      ),
    );
  }
}
