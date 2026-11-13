import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breathing_settings.dart';

part 'breathing_setup_event.dart';

@injectable
class BreathingSetupBloc extends Bloc<BreathingSetupEvent, BreathingSettings> {
  new() : super(BreathingSettings.initial) {
    on<BreathingPaceChanged>(
      (event, emit) => _update(
        emit,
        state.copyWith(breathsPerMinute: event.breathsPerMinute),
      ),
    );
    on<BreathingDurationChanged>(
      (event, emit) =>
          _update(emit, state.copyWith(durationMinutes: event.minutes)),
    );
    on<BreathingGoalChanged>(
      (event, emit) => _update(emit, state.copyWith(goal: event.goal)),
    );
  }

  void _update(Emitter<BreathingSettings> emit, BreathingSettings next) {
    if (next != state) emit(next);
  }
}
