import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

@immutable
class MascotPose {
  const new({
    required this.mood,
    required this.tint,
    this.focus,
    this.bounces = 0,
  });

  final double mood;
  final Color tint;
  final ValueListenable<Offset?>? focus;
  final int bounces;

  @override
  int get hashCode => Object.hash(mood, tint, focus, bounces);

  @override
  bool operator ==(Object other) =>
      other is MascotPose &&
      other.mood == mood &&
      other.tint == tint &&
      other.focus == focus &&
      other.bounces == bounces;
}
