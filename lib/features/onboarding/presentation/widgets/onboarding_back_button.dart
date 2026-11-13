import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class OnboardingBackButton extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OnboardingCubit>().state;
    final isFirstPage = state.page == 0;

    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedOpacity(
        opacity: isFirstPage ? 0 : 1,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          tooltip: context.t.onboardingBack,
          onPressed: isFirstPage || state.isBusy
              ? null
              : context.read<OnboardingCubit>().back,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
    );
  }
}
