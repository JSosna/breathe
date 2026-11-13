import 'package:material_ui/material_ui.dart';

class AnimatedCount extends StatelessWidget {
  const new({required this.value, super.key});

  final int value;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: 0, end: value),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (_, current, _) => Text('$current'),
    );
  }
}
