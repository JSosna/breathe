import 'dart:ui';

import 'package:medcare_breathing/shared/rive/rive_contract.dart';
import 'package:rive/rive.dart' as rive;

class BreathBubbleBinding {
  new(rive.ViewModelInstance vm)
    : _breath = vm.number(RiveContract.bubbleBreath),
      _tint = vm.color(RiveContract.bubbleTint),
      _pulse = vm.trigger(RiveContract.bubblePulse);

  final rive.ViewModelInstanceNumber? _breath;
  final rive.ViewModelInstanceColor? _tint;
  final rive.ViewModelInstanceTrigger? _pulse;

  double get breath => _breath?.value ?? 0;

  set breath(double value) => _breath?.value = value;

  Color? get tint => _tint?.value;

  set tint(Color? color) {
    if (color != null) _tint?.value = color;
  }

  void pulse() => _pulse?.trigger();

  void dispose() {
    _breath?.dispose();
    _tint?.dispose();
    _pulse?.dispose();
  }
}
