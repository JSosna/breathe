import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class SummaryLoadingView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Spacings.sp24),
        CircularProgressIndicator(color: context.palette.ink),
        const SizedBox(height: Spacings.sp16),
        Text(context.t.summaryLoading),
      ],
    );
  }
}
