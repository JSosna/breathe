import 'dart:math' as math;

class BreathCycle {
  static const inhaleShare = 0.4;

  double _phase = 0;

  double get phase => _phase;

  bool get isInhaling => _phase < inhaleShare;

  double get breath {
    if (isInhaling) {
      final t = _phase / inhaleShare;
      return (1 - math.cos(math.pi * t)) / 2;
    }
    final t = (_phase - inhaleShare) / (1 - inhaleShare);
    return (1 + math.cos(math.pi * t)) / 2;
  }

  void advance(Duration elapsed, {required int breathsPerMinute}) {
    assert(breathsPerMinute > 0, 'breathsPerMinute must be positive');
    final cycleMicros = Duration.microsecondsPerMinute / breathsPerMinute;
    _phase = (_phase + elapsed.inMicroseconds / cycleMicros) % 1;
  }

  void reset() => _phase = 0;
}
