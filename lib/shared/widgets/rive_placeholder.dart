import 'package:material_ui/material_ui.dart';

class RivePlaceholder extends StatelessWidget {
  const new({required this.color, super.key});

  static const _widthFactor = 0.55;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: _widthFactor,
        child: AspectRatio(
          aspectRatio: 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}
