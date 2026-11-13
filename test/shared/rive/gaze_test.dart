import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/shared/rive/gaze.dart';

void main() {
  const center = Offset(200, 300);
  const area = Size(400, 800);

  test('looks straight ahead when there is no pointer', () {
    expect(Gaze.towards(null, center: center, area: area), Offset.zero);
  });

  test('looks straight ahead when the pointer is on the eyes', () {
    expect(Gaze.towards(center, center: center, area: area), Offset.zero);
  });

  test('normalises by half of the area', () {
    expect(
      Gaze.towards(const Offset(300, 100), center: center, area: area),
      const Offset(0.5, -0.5),
    );
  });

  test('clamps pointers far outside the area', () {
    expect(
      Gaze.towards(const Offset(-5000, 9000), center: center, area: area),
      const Offset(-1, 1),
    );
  });

  test('ignores an empty area instead of dividing by zero', () {
    expect(
      Gaze.towards(const Offset(10, 10), center: center, area: Size.zero),
      Offset.zero,
    );
  });
}
