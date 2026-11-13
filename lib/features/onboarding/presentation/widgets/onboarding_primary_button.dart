import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class OnboardingPrimaryButton extends StatelessWidget {
  const new({super.key});

  static const _spinnerSize = 18.0;
  static const _spinnerStroke = 2.0;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OnboardingCubit>().state;

    return FilledButton(
      onPressed: state.isBusy || !state.canContinue
          ? null
          : () => _onPressed(context, state),
      child: state.status == OnboardingStatus.sending
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: _spinnerSize,
                  child: CircularProgressIndicator(
                    strokeWidth: _spinnerStroke,
                    color: context.palette.inkMuted,
                  ),
                ),
                const SizedBox(width: Spacings.sp12),
                Text(context.t.onboardingSending),
              ],
            )
          : Text(
              state.isLastPage
                  ? context.t.onboardingStart
                  : context.t.onboardingNext,
            ),
    );
  }

  void _onPressed(BuildContext context, OnboardingState state) {
    FocusScope.of(context).unfocus();
    final cubit = context.read<OnboardingCubit>();
    unawaited(state.isLastPage ? cubit.finish() : cubit.next());
  }
}
