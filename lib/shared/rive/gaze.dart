import 'dart:ui';

abstract final class Gaze {
  static Offset towards(
    Offset? pointer, {
    required Offset center,
    required Size area,
  }) {
    if (pointer == null || area.isEmpty) return Offset.zero;
    final delta = pointer - center;
    return Offset(
      (delta.dx / (area.width / 2)).clamp(-1, 1),
      (delta.dy / (area.height / 2)).clamp(-1, 1),
    );
  }
}
