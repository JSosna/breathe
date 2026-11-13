import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/shared/mascot/mascot_layer.dart';
import 'package:medcare_breathing/shared/mascot/mascot_stage_controller.dart';
import 'package:medcare_breathing/shared/mascot/touch_tracker.dart';
import 'package:provider/provider.dart';

class MascotStage extends StatefulWidget {
  const new({required this.child, super.key});

  final Widget child;

  @override
  State<MascotStage> createState() => _MascotStageState();
}

class _MascotStageState extends State<MascotStage> {
  final _controller = MascotStageController();
  final _pointer = ValueNotifier<Offset?>(null);
  final _touches = TouchTracker();

  @override
  void dispose() {
    _controller.dispose();
    _pointer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: ColoredBox(
        color: context.palette.background,
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: _onPointerDown,
          onPointerMove: _onPointerMove,
          onPointerHover: _onPointerHover,
          onPointerUp: _onPointerUp,
          onPointerCancel: _onPointerCancel,
          child: Stack(
            fit: StackFit.expand,
            children: [
              MascotLayer(controller: _controller, pointer: _pointer),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }

  void _onPointerDown(PointerDownEvent event) {
    _touches.down(event.pointer, event.position);
    _pointer.value = _touches.focus;
  }

  void _onPointerMove(PointerMoveEvent event) {
    _touches.move(event.pointer, event.position);
    _pointer.value = _touches.focus ?? event.position;
  }

  void _onPointerHover(PointerHoverEvent event) {
    _pointer.value = _touches.focus ?? event.position;
  }

  void _onPointerUp(PointerUpEvent event) {
    final pressedAt = _touches.up(event.pointer);
    _pointer.value = _touches.focus;
    final mascot = _controller.active?.rect;
    if (pressedAt == null || mascot == null) return;
    final isTap = (event.position - pressedAt).distance < kTouchSlop;
    if (isTap && mascot.contains(event.position)) _controller.bounce();
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _touches.cancel(event.pointer);
    _pointer.value = _touches.focus;
  }
}
