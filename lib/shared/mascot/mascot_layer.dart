import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/shared/mascot/mascot_stage_controller.dart';
import 'package:medcare_breathing/shared/mascot/mascot_view.dart';
import 'package:medcare_breathing/shared/widgets/gaze_source.dart';

class MascotLayer extends StatelessWidget {
  const new({required this.controller, required this.pointer, super.key});

  static const _flight = Duration(milliseconds: 650);

  final MascotStageController controller;
  final ValueListenable<Offset?> pointer;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final active = controller.active;
        if (active == null) return const SizedBox.shrink();
        final pose = active.pose;
        return Stack(
          children: [
            AnimatedPositioned.fromRect(
              rect: active.rect,
              duration: _flight,
              curve: Curves.easeInOutCubic,
              child: MascotView(
                mood: pose.mood,
                tint: pose.tint,
                pointer: GazeSource(pointer, pose.focus),
                bounces: pose.bounces + controller.tapBounces,
              ),
            ),
          ],
        );
      },
    );
  }
}
