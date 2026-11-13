import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/features/breathing/presentation/bloc/breathing_setup_bloc.dart';
import 'package:medcare_breathing/features/breathing/presentation/breath_goal_style.dart';
import 'package:medcare_breathing/features/breathing/presentation/widgets/breath_bubble_view.dart';
import 'package:medcare_breathing/features/breathing/presentation/widgets/breath_phase_label.dart';

class BreathingBubbleSection extends StatefulWidget {
  const new({super.key});

  @override
  State<BreathingBubbleSection> createState() => _BreathingBubbleSectionState();
}

class _BreathingBubbleSectionState extends State<BreathingBubbleSection> {
  bool _inhaling = true;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<BreathingSetupBloc>().state;

    return Stack(
      alignment: Alignment.center,
      children: [
        BreathBubbleView(
          breathsPerMinute: settings.breathsPerMinute,
          tint: settings.goal.colorOf(context),
          onInhalingChanged: _onInhalingChanged,
        ),
        IgnorePointer(child: BreathPhaseLabel(inhaling: _inhaling)),
      ],
    );
  }

  void _onInhalingChanged(bool inhaling) =>
      setState(() => _inhaling = inhaling);
}
