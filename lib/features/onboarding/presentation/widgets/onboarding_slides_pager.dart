import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:medcare_breathing/features/onboarding/presentation/models/onboarding_slide.dart';
import 'package:medcare_breathing/features/onboarding/presentation/widgets/onboarding_slide_text.dart';

class OnboardingSlidesPager extends StatelessWidget {
  const new({required this.controller, required this.showBody, super.key});

  final PageController controller;
  final bool showBody;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OnboardingCubit>().state;

    return PageView.builder(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: OnboardingState.pageCount,
      itemBuilder: (context, index) => OnboardingSlideText(
        slide: OnboardingSlide.of(context, state.copyWith(page: index)),
        showBody: showBody,
      ),
    );
  }
}
