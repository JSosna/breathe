import 'dart:async';

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';

class LabeledSlider extends StatelessWidget {
  const new({
    required this.label,
    required this.value,
    required this.current,
    required this.min,
    required this.max,
    required this.onChanged,
    this.caption,
    super.key,
  });

  final String label;
  final String value;
  final String? caption;
  final int current;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final caption = this.caption;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(label, style: context.textTheme.titleMedium),
            const Spacer(),
            Text(value, style: context.textTheme.bodyMedium),
          ],
        ),
        if (caption != null)
          Text(
            caption,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.palette.inkMuted,
            ),
          ),
        Slider(
          value: current.toDouble(),
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: max - min,
          semanticFormatterCallback: (_) => value,
          onChanged: _onSliderChanged,
        ),
      ],
    );
  }

  void _onSliderChanged(double raw) {
    final next = raw.round();
    if (next == current) return;
    unawaited(HapticFeedback.selectionClick());
    onChanged(next);
  }
}
