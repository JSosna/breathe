import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:medcare_breathing/shared/mascot/mascot_pose.dart';

class MascotStageController extends ChangeNotifier {
  new({void Function(VoidCallback)? schedule})
    : _schedule = schedule ?? _afterFrame;

  final void Function(VoidCallback) _schedule;
  final _slots = <Object, ({MascotPose pose, Rect? rect})>{};
  int _tapBounces = 0;
  bool _notifyScheduled = false;
  bool _disposed = false;

  ({MascotPose pose, Rect rect})? get active {
    for (final slot in _slots.values.toList().reversed) {
      final rect = slot.rect;
      if (rect != null) return (pose: slot.pose, rect: rect);
    }
    return null;
  }

  int get tapBounces => _tapBounces;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  void place(Object slot, MascotPose pose, Rect? rect) {
    final previous = _slots[slot];
    final nextRect = rect ?? previous?.rect;
    if (previous != null &&
        previous.pose == pose &&
        previous.rect == nextRect) {
      return;
    }
    _slots[slot] = (pose: pose, rect: nextRect);
    _scheduleNotify();
  }

  void remove(Object slot) {
    if (_slots.remove(slot) != null) _scheduleNotify();
  }

  void bounce() {
    _tapBounces++;
    notifyListeners();
  }

  static void _afterFrame(VoidCallback callback) {
    SchedulerBinding.instance
      ..addPostFrameCallback((_) => callback())
      ..ensureVisualUpdate();
  }

  void _scheduleNotify() {
    if (_notifyScheduled) return;
    _notifyScheduled = true;
    _schedule(() {
      _notifyScheduled = false;
      if (!_disposed) notifyListeners();
    });
  }
}
