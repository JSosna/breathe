import 'package:flutter/scheduler.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_cycle.dart';
import 'package:medcare_breathing/shared/rive/bound_rive_artboard.dart';
import 'package:medcare_breathing/shared/rive/breath_bubble_binding.dart';
import 'package:medcare_breathing/shared/rive/rive_contract.dart';
import 'package:medcare_breathing/shared/widgets/rive_placeholder.dart';

class BreathBubbleView extends StatefulWidget {
  const new({
    required this.breathsPerMinute,
    required this.tint,
    this.onInhalingChanged,
    super.key,
  });

  final int breathsPerMinute;
  final Color tint;

  final ValueChanged<bool>? onInhalingChanged;

  @override
  State<BreathBubbleView> createState() => _BreathBubbleViewState();
}

class _BreathBubbleViewState extends State<BreathBubbleView>
    with SingleTickerProviderStateMixin {
  static const _maxFrameStep = Duration(milliseconds: 100);

  final _cycle = BreathCycle();
  late final Ticker _ticker = createTicker(_onTick);
  Duration _lastTick = Duration.zero;
  bool? _wasInhaling;
  BreathBubbleBinding? _binding;

  @override
  void initState() {
    super.initState();
    _ticker.start();
  }

  @override
  void didUpdateWidget(BreathBubbleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final binding = _binding;
    if (binding == null) return;

    binding.tint = widget.tint;

    if (oldWidget.breathsPerMinute != widget.breathsPerMinute ||
        oldWidget.tint != widget.tint) {
      binding.pulse();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BoundRiveArtboard(
      artboard: RiveContract.bubbleArtboard,
      onBound: (vm) => _binding = BreathBubbleBinding(vm)
        ..tint = widget.tint
        ..breath = _cycle.breath,
      onUnbound: () {
        _binding?.dispose();
        _binding = null;
      },
      placeholder: RivePlaceholder(color: widget.tint),
    );
  }

  void _onTick(Duration elapsed) {
    final step = elapsed - _lastTick;
    _lastTick = elapsed;
    _cycle.advance(
      step > _maxFrameStep ? _maxFrameStep : step,
      breathsPerMinute: widget.breathsPerMinute,
    );
    _binding?.breath = _cycle.breath;

    final inhaling = _cycle.isInhaling;
    if (inhaling != _wasInhaling) {
      _wasInhaling = inhaling;
      widget.onInhalingChanged?.call(inhaling);
    }
  }
}
