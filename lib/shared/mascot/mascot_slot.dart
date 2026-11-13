import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/shared/mascot/mascot_pose.dart';
import 'package:medcare_breathing/shared/mascot/mascot_stage_controller.dart';
import 'package:medcare_breathing/shared/widgets/position_probe.dart';

class MascotSlot extends StatefulWidget {
  const new({
    required this.mood,
    required this.tint,
    this.focus,
    this.bounces = 0,
    super.key,
  });

  final double mood;
  final Color tint;
  final ValueListenable<Offset?>? focus;
  final int bounces;

  @override
  State<MascotSlot> createState() => _MascotSlotState();
}

class _MascotSlotState extends State<MascotSlot> {
  late final MascotStageController _stage = context
      .read<MascotStageController>();
  ModalRoute<Object?>? _route;
  Rect? _rect;
  bool _leaving = false;

  @override
  void initState() {
    super.initState();
    _stage.place(this, _pose, null);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route == _route) return;
    _route?.animation?.removeStatusListener(_onRouteStatus);
    _route = route;
    route?.animation?.addStatusListener(_onRouteStatus);
  }

  @override
  void didUpdateWidget(MascotSlot oldWidget) {
    super.didUpdateWidget(oldWidget);
    _place();
  }

  @override
  void dispose() {
    _route?.animation?.removeStatusListener(_onRouteStatus);
    _stage.remove(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PositionProbe(onMoved: _onMoved, child: const SizedBox.expand());
  }

  MascotPose get _pose => MascotPose(
    mood: widget.mood,
    tint: widget.tint,
    focus: widget.focus,
    bounces: widget.bounces,
  );

  void _onMoved(Rect rect) {
    _rect = rect;
    _place();
  }

  void _onRouteStatus(AnimationStatus status) {
    final leaving = status == AnimationStatus.reverse;
    if (leaving == _leaving) return;
    _leaving = leaving;
    if (leaving) {
      _stage.remove(this);
    } else {
      _place();
    }
  }

  void _place() {
    if (!_leaving) _stage.place(this, _pose, _rect);
  }
}
