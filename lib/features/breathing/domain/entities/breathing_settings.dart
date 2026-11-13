import 'package:equatable/equatable.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';

final class BreathingSettings extends Equatable {
  factory({
    int breathsPerMinute = 6,
    int durationMinutes = 3,
    BreathGoal goal = BreathGoal.relax,
  }) => BreathingSettings._(
    breathsPerMinute.clamp(minBreathsPerMinute, maxBreathsPerMinute),
    durationMinutes.clamp(minDurationMinutes, maxDurationMinutes),
    goal,
  );

  const new _(this.breathsPerMinute, this.durationMinutes, this.goal);

  static const minBreathsPerMinute = 4;
  static const maxBreathsPerMinute = 12;
  static const minDurationMinutes = 1;
  static const maxDurationMinutes = 10;

  static const initial = BreathingSettings._(6, 3, BreathGoal.relax);

  final int breathsPerMinute;
  final int durationMinutes;
  final BreathGoal goal;

  @override
  List<Object?> get props => [breathsPerMinute, durationMinutes, goal];

  int get totalBreaths => breathsPerMinute * durationMinutes;

  Duration get cycle => Duration(
    microseconds: Duration.microsecondsPerMinute ~/ breathsPerMinute,
  );

  BreathingSettings copyWith({
    int? breathsPerMinute,
    int? durationMinutes,
    BreathGoal? goal,
  }) => BreathingSettings(
    breathsPerMinute: breathsPerMinute ?? this.breathsPerMinute,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    goal: goal ?? this.goal,
  );
}
