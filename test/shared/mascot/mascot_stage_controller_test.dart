import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/shared/mascot/mascot_pose.dart';
import 'package:medcare_breathing/shared/mascot/mascot_stage_controller.dart';

void main() {
  const calm = MascotPose(mood: 50, tint: Color(0xFF6CC3B4));
  const happy = MascotPose(mood: 100, tint: Color(0xFFF2B860));
  const big = Rect.fromLTWH(0, 0, 300, 300);
  const corner = Rect.fromLTWH(300, 0, 76, 76);

  late MascotStageController controller;
  late int notifications;

  setUp(() {
    controller = MascotStageController(schedule: (callback) => callback());
    notifications = 0;
    controller.addListener(() => notifications++);
  });

  test('has no active slot until one is measured', () {
    controller.place('onboarding', calm, null);
    expect(controller.active, isNull);
  });

  test('follows the most recently placed measured slot', () {
    controller
      ..place('setup', calm, corner)
      ..place('summary', happy, big);

    expect(controller.active, (pose: happy, rect: big));
  });

  test('falls back to the previous slot when the top one leaves', () {
    controller
      ..place('setup', calm, corner)
      ..place('summary', happy, big)
      ..remove('summary');

    expect(controller.active, (pose: calm, rect: corner));
  });

  test('keeps the last known size when only the pose changes', () {
    controller
      ..place('setup', calm, corner)
      ..place('setup', happy, null);

    expect(controller.active, (pose: happy, rect: corner));
  });

  test('does not notify when nothing changed', () {
    controller.place('setup', calm, corner);
    final before = notifications;

    controller.place('setup', calm, corner);

    expect(notifications, before);
  });

  test('does not notify when a pose-only update repeats the same pose', () {
    controller.place('setup', calm, corner);
    final before = notifications;

    controller.place('setup', calm, null);

    expect(notifications, before);
  });

  test('counts taps as bounces', () {
    controller
      ..bounce()
      ..bounce();

    expect(controller.tapBounces, 2);
    expect(notifications, 2);
  });

  test('ignores a pending notification once disposed', () {
    final pending = <VoidCallback>[];
    MascotStageController(schedule: pending.add)
      ..place('setup', calm, corner)
      ..dispose();

    expect(pending.single, returnsNormally);
  });
}
