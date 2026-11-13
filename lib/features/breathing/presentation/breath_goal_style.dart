import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

extension BreathGoalStyle on BreathGoal {
  IconData get icon => switch (this) {
    BreathGoal.relax => Icons.spa_outlined,
    BreathGoal.focus => Icons.center_focus_strong_outlined,
    BreathGoal.sleep => Icons.bedtime_outlined,
  };

  Color colorOf(BuildContext context) => switch (this) {
    BreathGoal.relax => context.palette.relax,
    BreathGoal.focus => context.palette.focus,
    BreathGoal.sleep => context.palette.sleep,
  };

  String labelOf(BuildContext context) => switch (this) {
    BreathGoal.relax => context.t.goalRelax,
    BreathGoal.focus => context.t.goalFocus,
    BreathGoal.sleep => context.t.goalSleep,
  };
}
