import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_cycle.dart';

void main() {
  group('BreathCycle', () {
    // 6 breaths per minute => 10 s cycle: 4 s inhale, 6 s exhale.
    const bpm = 6;

    test('starts fully exhaled', () {
      expect(BreathCycle().breath, 0);
    });

    test('reaches a full inhale after 40% of the cycle', () {
      final cycle = BreathCycle()
        ..advance(const Duration(seconds: 4), breathsPerMinute: bpm);
      expect(cycle.breath, closeTo(1, 1e-9));
    });

    test('is half-way through the inhale after 2 s', () {
      final cycle = BreathCycle()
        ..advance(const Duration(seconds: 2), breathsPerMinute: bpm);
      expect(cycle.breath, closeTo(0.5, 1e-9));
    });

    test('is back to empty lungs after a full cycle and wraps around', () {
      final cycle = BreathCycle()
        ..advance(const Duration(seconds: 10), breathsPerMinute: bpm);
      expect(cycle.breath, closeTo(0, 1e-9));

      cycle.advance(const Duration(seconds: 4), breathsPerMinute: bpm);
      expect(cycle.breath, closeTo(1, 1e-9));
    });

    test('stays continuous when the pace changes mid-breath', () {
      final cycle = BreathCycle()
        ..advance(const Duration(seconds: 3), breathsPerMinute: bpm);
      final before = cycle.breath;

      cycle.advance(const Duration(milliseconds: 16), breathsPerMinute: 12);

      expect((cycle.breath - before).abs(), lessThan(0.02));
    });

    test('isInhaling follows the phase', () {
      final cycle = BreathCycle()
        ..advance(const Duration(seconds: 1), breathsPerMinute: bpm);
      expect(cycle.isInhaling, isTrue);

      cycle.advance(const Duration(seconds: 4), breathsPerMinute: bpm);
      expect(cycle.isInhaling, isFalse);
    });
  });
}
