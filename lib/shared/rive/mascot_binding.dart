import 'dart:ui';

import 'package:medcare_breathing/shared/rive/rive_contract.dart';
import 'package:rive/rive.dart' as rive;

class MascotBinding {
  new(rive.ViewModelInstance vm)
    : _lookX = vm.number(RiveContract.mascotLookX),
      _lookY = vm.number(RiveContract.mascotLookY),
      _mood = vm.number(RiveContract.mascotMood),
      _tint = vm.color(RiveContract.mascotTint),
      _tap = vm.trigger(RiveContract.mascotTap);

  final rive.ViewModelInstanceNumber? _lookX;
  final rive.ViewModelInstanceNumber? _lookY;
  final rive.ViewModelInstanceNumber? _mood;
  final rive.ViewModelInstanceColor? _tint;
  final rive.ViewModelInstanceTrigger? _tap;

  Offset get gaze => Offset(_lookX?.value ?? 0, _lookY?.value ?? 0);

  set gaze(Offset gaze) {
    _lookX?.value = gaze.dx;
    _lookY?.value = gaze.dy;
  }

  double get mood => _mood?.value ?? 0;

  set mood(double mood) => _mood?.value = mood;

  Color? get tint => _tint?.value;

  set tint(Color? color) {
    if (color != null) _tint?.value = color;
  }

  void bounce() => _tap?.trigger();

  void dispose() {
    _lookX?.dispose();
    _lookY?.dispose();
    _mood?.dispose();
    _tint?.dispose();
    _tap?.dispose();
  }
}
