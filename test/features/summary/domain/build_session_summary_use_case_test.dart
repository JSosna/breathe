import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/core/clock.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breathing_settings.dart';
import 'package:medcare_breathing/features/summary/domain/entities/session_summary.dart';
import 'package:medcare_breathing/features/summary/domain/usecases/build_session_summary_use_case.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';

class _FixedClock implements Clock {
  const new(this.value);

  final DateTime value;

  @override
  DateTime now() => value;
}

void main() {
  final profile = UserProfile(
    firstName: 'Anna',
    lastName: 'Kowalska',
    birthDate: DateTime(1991, 3, 14),
  );
  final build = BuildSessionSummaryUseCase(_FixedClock(DateTime(2026, 11, 12)));

  test('combines the profile, its age today and the chosen settings', () {
    final summary = build(profile, BreathingSettings.initial);

    expect(summary.profile, profile);
    expect(summary.age, 35);
    expect(summary.settings, BreathingSettings.initial);
    expect(summary.totalBreaths, 18);
  });

  group('message and mood follow the goal and pace', () {
    test('slow relax session is a deep calm', () {
      final summary = build(profile, BreathingSettings(breathsPerMinute: 5));
      expect(summary.message, SummaryMessage.deepCalm);
      expect(summary.mood, 100);
    });

    test('faster relax session is a regular relax', () {
      final summary = build(profile, BreathingSettings(breathsPerMinute: 9));
      expect(summary.message, SummaryMessage.relax);
      expect(summary.mood, 80);
    });

    test('focus keeps the mascot alert', () {
      final summary = build(profile, BreathingSettings(goal: BreathGoal.focus));
      expect(summary.message, SummaryMessage.focus);
      expect(summary.mood, 50);
    });

    test('sleep makes the mascot drowsy', () {
      final summary = build(profile, BreathingSettings(goal: BreathGoal.sleep));
      expect(summary.message, SummaryMessage.sleep);
      expect(summary.mood, 0);
    });
  });
}
