import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:medcare_breathing/features/onboarding/presentation/widgets/name_field.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class OnboardingNameInputs extends StatelessWidget {
  const new({
    required this.firstNameCaret,
    required this.lastNameCaret,
    required this.onSubmitted,
    super.key,
  });

  final ValueNotifier<Offset?> firstNameCaret;
  final ValueNotifier<Offset?> lastNameCaret;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Padding(
      padding: const EdgeInsets.only(top: Spacings.sp12, bottom: Spacings.sp16),
      child: Column(
        children: [
          NameField(
            label: context.t.onboardingFirstNameLabel,
            autofillHint: AutofillHints.givenName,
            textInputAction: TextInputAction.next,
            onChanged: cubit.firstNameChanged,
            onCaretMoved: (caret) => firstNameCaret.value = caret,
          ),
          const SizedBox(height: Spacings.sp12),
          NameField(
            label: context.t.onboardingLastNameLabel,
            autofillHint: AutofillHints.familyName,
            onChanged: cubit.lastNameChanged,
            onCaretMoved: (caret) => lastNameCaret.value = caret,
            onSubmitted: (_) {
              if (cubit.state.hasValidNames) onSubmitted();
            },
          ),
        ],
      ),
    );
  }
}
