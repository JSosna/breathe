part of 'breathing_setup_bloc.dart';

sealed class BreathingSetupEvent {
  const new();
}

final class BreathingPaceChanged extends BreathingSetupEvent {
  const new(this.breathsPerMinute);

  final int breathsPerMinute;
}

final class BreathingDurationChanged extends BreathingSetupEvent {
  const new(this.minutes);

  final int minutes;
}

final class BreathingGoalChanged extends BreathingSetupEvent {
  const new(this.goal);

  final BreathGoal goal;
}
