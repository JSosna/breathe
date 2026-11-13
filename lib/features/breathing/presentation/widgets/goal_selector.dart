import 'dart:async';

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';
import 'package:medcare_breathing/features/breathing/presentation/breath_goal_style.dart';

class GoalSelector extends StatelessWidget {
  const new({required this.selected, required this.onChanged, super.key});

  static const _selectedAlpha = 0.25;

  final BreathGoal selected;
  final ValueChanged<BreathGoal> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<BreathGoal>(
      showSelectedIcon: false,
      segments: [
        for (final goal in BreathGoal.values)
          ButtonSegment(
            value: goal,
            icon: Icon(goal.icon),
            label: Text(goal.labelOf(context)),
          ),
      ],
      selected: {selected},
      onSelectionChanged: _onSelectionChanged,
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: selected
            .colorOf(context)
            .withValues(alpha: _selectedAlpha),
        selectedForegroundColor: context.palette.ink,
      ),
    );
  }

  void _onSelectionChanged(Set<BreathGoal> selection) {
    unawaited(HapticFeedback.selectionClick());
    onChanged(selection.single);
  }
}
