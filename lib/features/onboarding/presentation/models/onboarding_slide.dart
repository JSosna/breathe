import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/extensions/context_extensions.dart';
import 'package:medcare_breathing/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:medcare_breathing/features/user/domain/entities/person_name.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';

@immutable
class OnboardingSlide {
  const new({
    required this.title,
    required this.body,
    required this.mood,
    required this.tint,
  });

  factory of(BuildContext context, OnboardingState state) =>
      switch (state.page) {
        OnboardingState.namePage => OnboardingSlide._name(context, state),
        OnboardingState.birthDatePage => OnboardingSlide._birthDate(
          context,
          state,
        ),
        _ => OnboardingSlide._goals(context),
      };

  factory _name(BuildContext context, OnboardingState state) {
    final name = PersonName.normalize(state.firstName);

    return OnboardingSlide(
      title: name == null
          ? context.t.onboardingTitle1
          : context.t.onboardingGreeting(name: name),
      body: context.t.onboardingBody1,
      mood: neutralMood,
      tint: context.palette.mascot,
    );
  }

  factory _birthDate(BuildContext context, OnboardingState state) {
    final birthDate = state.birthDate;
    final today = context.read<OnboardingCubit>().today();

    return OnboardingSlide(
      title: context.t.onboardingTitle2,
      body: birthDate == null
          ? context.t.onboardingBody2
          : context.t.onboardingAgeLine(
              age: context.t.summaryAge(
                age: UserProfile.ageFrom(birthDate, today),
              ),
            ),
      mood: birthDate == null ? neutralMood : happyMood,
      tint: context.palette.focus,
    );
  }

  factory _goals(BuildContext context) => OnboardingSlide(
    title: context.t.onboardingTitle3,
    body: context.t.onboardingBody3,
    mood: sleepyMood,
    tint: context.palette.sleep,
  );

  static const neutralMood = 50.0;
  static const happyMood = 100.0;
  static const sleepyMood = 20.0;

  final String title;
  final String body;
  final double mood;
  final Color tint;
}
