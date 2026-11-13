import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/breathing/presentation/breath_goal_style.dart';
import 'package:medcare_breathing/features/summary/domain/entities/session_summary.dart';
import 'package:medcare_breathing/features/summary/presentation/widgets/summary_message_card.dart';
import 'package:medcare_breathing/features/summary/presentation/widgets/summary_stats_card.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class SummaryContent extends StatelessWidget {
  const new({required this.summary, super.key});

  final SessionSummary summary;

  @override
  Widget build(BuildContext context) {
    final goal = summary.settings.goal;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.t.summaryGreeting(name: summary.profile.firstName),
          style: context.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacings.sp4),
        Text(
          summary.profile.fullName,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.palette.inkMuted,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacings.sp16),
        SummaryMessageCard(summary: summary),
        const SizedBox(height: Spacings.sp16),
        SummaryStatsCard(summary: summary),
        const SizedBox(height: Spacings.sp16),
        OutlinedButton.icon(
          onPressed: () => context.router.maybePop(),
          icon: Icon(goal.icon),
          label: Text(context.t.summaryEdit),
        ),
      ],
    );
  }
}
