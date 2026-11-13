import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/shared/widgets/gaze_source.dart';

void main() {
  late ValueNotifier<Offset?> finger;
  late ValueNotifier<Offset?> caret;

  setUp(() {
    finger = ValueNotifier(null);
    caret = ValueNotifier(null);
  });

  test('prefers the finger, falls back to the caret', () {
    final source = GazeSource(finger, caret);
    expect(source.value, isNull);

    caret.value = const Offset(10, 20);
    expect(source.value, const Offset(10, 20));

    finger.value = const Offset(1, 2);
    expect(source.value, const Offset(1, 2));

    finger.value = null;
    expect(source.value, const Offset(10, 20));
  });

  test('notifies on changes of either source and unsubscribes cleanly', () {
    final source = GazeSource(finger, caret);
    var calls = 0;
    void listener() => calls++;

    source.addListener(listener);
    finger.value = Offset.zero;
    caret.value = Offset.zero;
    expect(calls, 2);

    GazeSource(finger, caret).removeListener(listener);
    finger.value = const Offset(5, 5);
    expect(calls, 2);
  });
}
