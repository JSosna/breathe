import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breathing_settings.dart';

void main() {
  group('BreathingSettings', () {
    test('defaults to a calm 6 breaths/min, 3 minute relax session', () {
      const initial = BreathingSettings.initial;
      expect(initial.breathsPerMinute, 6);
      expect(initial.durationMinutes, 3);
      expect(initial.goal, BreathGoal.relax);
      expect(BreathingSettings(), initial);
    });

    test('totalBreaths multiplies pace by duration', () {
      expect(BreathingSettings.initial.totalBreaths, 18);
      expect(
        BreathingSettings(
          breathsPerMinute: 12,
          durationMinutes: 10,
        ).totalBreaths,
        120,
      );
    });

    test('cycle is one breath long', () {
      expect(BreathingSettings.initial.cycle, const Duration(seconds: 10));
      expect(
        BreathingSettings(breathsPerMinute: 4).cycle,
        const Duration(seconds: 15),
      );
    });

    test('clamps values outside the supported ranges', () {
      final low = BreathingSettings(breathsPerMinute: 0, durationMinutes: -5);
      expect(low.breathsPerMinute, BreathingSettings.minBreathsPerMinute);
      expect(low.durationMinutes, BreathingSettings.minDurationMinutes);

      final high = BreathingSettings(breathsPerMinute: 99, durationMinutes: 99);
      expect(high.breathsPerMinute, BreathingSettings.maxBreathsPerMinute);
      expect(high.durationMinutes, BreathingSettings.maxDurationMinutes);
    });

    test('copyWith keeps untouched fields and clamps the new ones', () {
      final updated = BreathingSettings.initial.copyWith(breathsPerMinute: 1);
      expect(updated.breathsPerMinute, 4);
      expect(updated.durationMinutes, 3);
      expect(updated.goal, BreathGoal.relax);
    });
  });
}
