import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/shared/mascot/touch_tracker.dart';

void main() {
  late TouchTracker touches;

  setUp(() => touches = TouchTracker());

  test('follows the finger that moved last', () {
    touches
      ..down(1, const Offset(10, 10))
      ..down(2, const Offset(50, 50))
      ..move(1, const Offset(20, 20));

    expect(touches.focus, const Offset(20, 20));
  });

  test('keeps following a finger that is still down after another lifts', () {
    touches
      ..down(1, const Offset(10, 10))
      ..down(2, const Offset(50, 50))
      ..up(2);

    expect(touches.focus, const Offset(10, 10));
  });

  test('has no focus once every finger is lifted or cancelled', () {
    touches
      ..down(1, const Offset(10, 10))
      ..down(2, const Offset(50, 50))
      ..up(1)
      ..cancel(2);

    expect(touches.focus, isNull);
  });

  test('up returns where that finger went down', () {
    touches
      ..down(1, const Offset(10, 10))
      ..down(2, const Offset(50, 50))
      ..move(1, const Offset(12, 10));

    expect(touches.up(1), const Offset(10, 10));
    expect(touches.up(2), const Offset(50, 50));
  });

  test('ignores moves and lifts of fingers it never saw go down', () {
    touches.move(7, const Offset(1, 1));

    expect(touches.focus, isNull);
    expect(touches.up(7), isNull);
  });
}
