import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';

class StatCell extends StatelessWidget {
  const new({required this.label, required this.value, super.key});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(Spacings.sp16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle.merge(
              style: context.textTheme.headlineMedium,
              child: value,
            ),
            const SizedBox(height: Spacings.sp4),
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.palette.inkMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
