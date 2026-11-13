import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/summary/presentation/widgets/summary_body.dart';
import 'package:medcare_breathing/features/summary/presentation/widgets/summary_mascot.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

@RoutePage()
class SummaryPage extends StatelessWidget {
  const new({super.key});

  static const _mascotHeight = 220.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.t.summaryTitle)),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: _mascotHeight, child: SummaryMascot()),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  Spacings.sp24,
                  Spacings.sp8,
                  Spacings.sp24,
                  Spacings.sp24,
                ),
                children: const [SummaryBody()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
