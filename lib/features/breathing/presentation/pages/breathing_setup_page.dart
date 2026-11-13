import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/app/router/app_router.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/breathing/presentation/widgets/breathing_bubble_section.dart';
import 'package:medcare_breathing/features/breathing/presentation/widgets/breathing_settings_card.dart';
import 'package:medcare_breathing/features/breathing/presentation/widgets/breathing_setup_header.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

@RoutePage()
class BreathingSetupPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Spacings.sp24,
            Spacings.sp16,
            Spacings.sp24,
            Spacings.sp24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const BreathingSetupHeader(),
              const Expanded(child: BreathingBubbleSection()),
              const BreathingSettingsCard(),
              const SizedBox(height: Spacings.sp16),
              FilledButton(
                onPressed: () => context.router.push(const SummaryRoute()),
                child: Text(context.t.showSummary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
