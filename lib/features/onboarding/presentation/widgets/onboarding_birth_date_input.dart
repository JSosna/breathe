import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';
import 'package:medcare_breathing/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:medcare_breathing/features/onboarding/presentation/widgets/birth_date_field.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

class OnboardingBirthDateInput extends StatelessWidget {
  const new({required this.onPicked, super.key});

  final VoidCallback onPicked;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final birthDate = context.select<OnboardingCubit, DateTime?>(
      (cubit) => cubit.state.birthDate,
    );

    return Padding(
      padding: const EdgeInsets.only(top: Spacings.sp12, bottom: Spacings.sp16),
      child: BirthDateField(
        label: context.t.onboardingBirthDateLabel,
        value: birthDate,
        today: cubit.today(),
        onChanged: (date) {
          cubit.birthDateChanged(date);
          onPicked();
        },
      ),
    );
  }
}
