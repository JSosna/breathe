import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/onboarding/presentation/models/onboarding_slide.dart';

class OnboardingSlideText extends StatelessWidget {
  const new({required this.slide, required this.showBody, super.key});

  static const _lineHeight = 1.45;

  final OnboardingSlide slide;
  final bool showBody;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            slide.title,
            style: context.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          if (showBody) ...[
            const SizedBox(height: Spacings.sp12),
            Text(
              slide.body,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.palette.inkMuted,
                height: _lineHeight,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
