import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class PositionProbe extends SingleChildRenderObjectWidget {
  const new({required this.onMoved, super.child, super.key});

  final ValueChanged<Rect> onMoved;

  @override
  RenderPositionProbe createRenderObject(BuildContext context) =>
      RenderPositionProbe(onMoved);

  @override
  void updateRenderObject(
    BuildContext context,
    RenderPositionProbe renderObject,
  ) {
    renderObject.onMoved = onMoved;
  }
}

class RenderPositionProbe extends RenderProxyBox {
  new(this.onMoved);

  ValueChanged<Rect> onMoved;
  Rect? _reported;
  bool _checkScheduled = false;

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    _scheduleCheck();
  }

  @override
  void detach() {
    _reported = null;
    super.detach();
  }

  void _scheduleCheck() {
    if (_checkScheduled) return;
    _checkScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkScheduled = false;
      if (!attached || !hasSize) return;
      final rect = localToGlobal(Offset.zero) & size;
      if (rect == _reported) return;
      _reported = rect;
      onMoved(rect);
    });
  }
}
