import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/core/theme/radius.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/breathing/presentation/breath_goal_style.dart';
import 'package:medcare_breathing/features/summary/domain/entities/session_summary.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class SummaryMessageCard extends StatelessWidget {
  const new({required this.summary, super.key});

  static const _backgroundAlpha = 0.18;
  static const _lineHeight = 1.45;

  final SessionSummary summary;

  @override
  Widget build(BuildContext context) {
    final accent = summary.settings.goal.colorOf(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.all(Spacings.sp20),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: _backgroundAlpha),
        borderRadius: BorderRadius.circular(Radius.r16),
      ),
      child: Text(switch (summary.message) {
        SummaryMessage.deepCalm => context.t.summaryMessageDeepCalm,
        SummaryMessage.relax => context.t.summaryMessageRelax,
        SummaryMessage.focus => context.t.summaryMessageFocus,
        SummaryMessage.sleep => context.t.summaryMessageSleep,
      }, style: context.textTheme.bodyLarge?.copyWith(height: _lineHeight)),
    );
  }
}
