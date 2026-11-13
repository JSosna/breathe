import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class BreathPhaseLabel extends StatelessWidget {
  const new({required this.inhaling, super.key});

  static const _letterSpacing = 1.2;

  final bool inhaling;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        inhaling ? context.t.inhale : context.t.exhale,
        key: ValueKey(inhaling),
        style: context.textTheme.titleMedium?.copyWith(
          color: context.palette.onInk,
          letterSpacing: _letterSpacing,
        ),
      ),
    );
  }
}
