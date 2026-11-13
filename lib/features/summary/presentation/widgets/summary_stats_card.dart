import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/features/summary/domain/entities/session_summary.dart';
import 'package:medcare_breathing/features/summary/presentation/widgets/animated_count.dart';
import 'package:medcare_breathing/features/summary/presentation/widgets/stat_cell.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class SummaryStatsCard extends StatelessWidget {
  const new({required this.summary, super.key});

  final SessionSummary summary;

  @override
  Widget build(BuildContext context) {
    final settings = summary.settings;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                StatCell(
                  label: context.t.summaryBreathsLabel,
                  value: AnimatedCount(value: summary.totalBreaths),
                ),
                const VerticalDivider(width: 1),
                StatCell(
                  label: context.t.summaryPaceLabel,
                  value: Text('${settings.breathsPerMinute}'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          IntrinsicHeight(
            child: Row(
              children: [
                StatCell(
                  label: context.t.summaryDurationLabel,
                  value: Text('${settings.durationMinutes}'),
                ),
                const VerticalDivider(width: 1),
                StatCell(
                  label: context.t.summaryAgeLabel,
                  value: Text('${summary.age}'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
