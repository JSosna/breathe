import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';
import 'package:medcare_breathing/shared/rive/bound_rive_artboard.dart';
import 'package:medcare_breathing/shared/rive/gaze.dart';
import 'package:medcare_breathing/shared/rive/mascot_binding.dart';
import 'package:medcare_breathing/shared/rive/rive_contract.dart';
import 'package:medcare_breathing/shared/widgets/position_probe.dart';
import 'package:medcare_breathing/shared/widgets/rive_placeholder.dart';

class MascotView extends StatefulWidget {
  const new({
    required this.mood,
    required this.tint,
    this.pointer,
    this.bounces = 0,
    super.key,
  });

  final double mood;
  final Color tint;
  final ValueListenable<Offset?>? pointer;
  final int bounces;

  @override
  State<MascotView> createState() => _MascotViewState();
}

class _MascotViewState extends State<MascotView> {
  static const _artboardSize = 400.0;

  MascotBinding? _binding;
  Offset? _center;
  Size _area = Size.zero;

  @override
  void initState() {
    super.initState();
    widget.pointer?.addListener(_updateGaze);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _area = MediaQuery.sizeOf(context);
  }

  @override
  void didUpdateWidget(MascotView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pointer != widget.pointer) {
      oldWidget.pointer?.removeListener(_updateGaze);
      widget.pointer?.addListener(_updateGaze);
    }
    _applyProps();
    if (widget.bounces != oldWidget.bounces) _binding?.bounce();
  }

  @override
  void dispose() {
    widget.pointer?.removeListener(_updateGaze);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: context.t.mascotLabel,
      child: PositionProbe(
        onMoved: _onMoved,
        child: FittedBox(
          child: SizedBox.square(
            dimension: _artboardSize,
            child: BoundRiveArtboard(
              artboard: RiveContract.mascotArtboard,
              onBound: (vm) => _onBound(MascotBinding(vm)),
              onUnbound: _onUnbound,
              placeholder: RivePlaceholder(color: widget.tint),
            ),
          ),
        ),
      ),
    );
  }

  void _onBound(MascotBinding binding) {
    _binding = binding;
    _applyProps();
    _updateGaze();
  }

  void _onUnbound() {
    _binding?.dispose();
    _binding = null;
  }

  void _applyProps() {
    _binding
      ?..mood = widget.mood
      ..tint = widget.tint;
  }

  void _onMoved(Rect rect) {
    _center = rect.center;
    _updateGaze();
  }

  void _updateGaze() {
    final binding = _binding;
    final center = _center;
    if (binding == null || center == null) return;
    binding.gaze = Gaze.towards(
      widget.pointer?.value,
      center: center,
      area: _area,
    );
  }
}
