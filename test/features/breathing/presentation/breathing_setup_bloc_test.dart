import 'package:bloc_test/bloc_test.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breathing_settings.dart';
import 'package:medcare_breathing/features/breathing/presentation/bloc/breathing_setup_bloc.dart';

void main() {
  blocTest<BreathingSetupBloc, BreathingSettings>(
    'changes the pace',
    build: BreathingSetupBloc.new,
    act: (bloc) => bloc.add(const BreathingPaceChanged(8)),
    expect: () => [BreathingSettings.initial.copyWith(breathsPerMinute: 8)],
  );

  blocTest<BreathingSetupBloc, BreathingSettings>(
    'changes the duration',
    build: BreathingSetupBloc.new,
    act: (bloc) => bloc.add(const BreathingDurationChanged(5)),
    expect: () => [BreathingSettings.initial.copyWith(durationMinutes: 5)],
  );

  blocTest<BreathingSetupBloc, BreathingSettings>(
    'changes the goal',
    build: BreathingSetupBloc.new,
    act: (bloc) => bloc.add(const BreathingGoalChanged(BreathGoal.sleep)),
    expect: () => [BreathingSettings.initial.copyWith(goal: BreathGoal.sleep)],
  );

  blocTest<BreathingSetupBloc, BreathingSettings>(
    'clamps out-of-range input instead of emitting an invalid state',
    build: BreathingSetupBloc.new,
    act: (bloc) => bloc.add(const BreathingPaceChanged(40)),
    expect: () => [BreathingSettings.initial.copyWith(breathsPerMinute: 12)],
  );

  blocTest<BreathingSetupBloc, BreathingSettings>(
    'does not emit when nothing changes (e.g. slider jitter)',
    build: BreathingSetupBloc.new,
    act: (bloc) => bloc
      ..add(const BreathingPaceChanged(6))
      ..add(const BreathingGoalChanged(BreathGoal.relax)),
    expect: () => <BreathingSettings>[],
  );
}
