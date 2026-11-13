import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/core/theme/radius.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';

class PageDots extends StatelessWidget {
  const new({required this.count, required this.active, super.key});

  static const _dotSize = 8.0;
  static const _activeDotWidth = 24.0;
  static const _inactiveAlpha = 0.2;

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    final ink = context.palette.ink;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: Spacings.sp4),
            width: i == active ? _activeDotWidth : _dotSize,
            height: _dotSize,
            decoration: BoxDecoration(
              color: i == active ? ink : ink.withValues(alpha: _inactiveAlpha),
              borderRadius: BorderRadius.circular(Radius.r4),
            ),
          ),
      ],
    );
  }
}
