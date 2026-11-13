import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/core/clock.dart';
import 'package:medcare_breathing/core/error/failure.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:medcare_breathing/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';
import 'package:medcare_breathing/features/user/domain/usecases/save_user_profile_use_case.dart';
import 'package:mocktail/mocktail.dart';

class _MockCompleteOnboarding extends Mock implements CompleteOnboardingUseCase;

class _MockSaveUserProfile extends Mock implements SaveUserProfileUseCase;

class _FixedClock implements Clock {
  @override
  DateTime now() => DateTime(2026, 11, 12);
}

void main() {
  final birthDate = DateTime(2001, 2, 3);
  final profile = UserProfile(
    firstName: 'Jan',
    lastName: 'Nowak',
    birthDate: birthDate,
  );

  late _MockCompleteOnboarding completeOnboarding;
  late _MockSaveUserProfile saveUserProfile;

  setUpAll(() => registerFallbackValue(profile));

  setUp(() {
    completeOnboarding = _MockCompleteOnboarding();
    saveUserProfile = _MockSaveUserProfile();
    when(() => completeOnboarding())
        .thenAnswer((_) async => const Success(null));
    when(() => saveUserProfile(any()))
        .thenAnswer((_) async => const Success(null));
  });

  OnboardingCubit build() =>
      OnboardingCubit(saveUserProfile, completeOnboarding, _FixedClock());

  const namesFilled = OnboardingState(firstName: ' Jan ', lastName: 'Nowak');

  group('name page', () {
    test('needs both names, blanks do not count', () {
      expect(
        const OnboardingState(firstName: 'Jan', lastName: '  ').canContinue,
        isFalse,
      );
      expect(namesFilled.canContinue, isTrue);
    });

    blocTest<OnboardingCubit, OnboardingState>(
      'keeps what the user types',
      build: build,
      act: (cubit) => cubit
        ..firstNameChanged('Jan')
        ..lastNameChanged('Nowak'),
      expect: () => [
        const OnboardingState(firstName: 'Jan'),
        const OnboardingState(firstName: 'Jan', lastName: 'Nowak'),
      ],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'next moves to the birth date page once both names are given',
      build: build,
      seed: () => namesFilled,
      act: (cubit) => cubit.next(),
      expect: () => [namesFilled.copyWith(page: 1)],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'next does nothing while a name is missing',
      build: build,
      seed: () => const OnboardingState(firstName: 'Jan'),
      act: (cubit) => cubit.next(),
      expect: () => <OnboardingState>[],
    );
  });

  group('birth date page', () {
    final onBirthDatePage = namesFilled.copyWith(page: 1);

    blocTest<OnboardingCubit, OnboardingState>(
      'accepts a plausible date of birth',
      build: build,
      seed: () => onBirthDatePage,
      act: (cubit) => cubit.birthDateChanged(birthDate),
      expect: () => [onBirthDatePage.copyWith(birthDate: birthDate)],
      verify: (cubit) => expect(cubit.state.canContinue, isTrue),
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'ignores a date in the future',
      build: build,
      seed: () => onBirthDatePage,
      act: (cubit) => cubit.birthDateChanged(DateTime(2027)),
      expect: () => <OnboardingState>[],
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'next sends the normalised profile to the backend, then moves on',
      build: build,
      seed: () => onBirthDatePage.copyWith(birthDate: birthDate),
      act: (cubit) => cubit.next(),
      expect: () {
        final filled = onBirthDatePage.copyWith(birthDate: birthDate);
        return [
          filled.copyWith(status: OnboardingStatus.sending),
          filled.copyWith(page: 2),
        ];
      },
      verify: (_) => verify(() => saveUserProfile(profile)).called(1),
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'stays on the page with the failure when sending fails',
      setUp: () =>
          when(() => saveUserProfile(any()))
              .thenAnswer((_) async => const Failed(NetworkFailure())),
      build: build,
      seed: () => onBirthDatePage.copyWith(birthDate: birthDate),
      act: (cubit) => cubit.next(),
      expect: () {
        final filled = onBirthDatePage.copyWith(birthDate: birthDate);
        return [
          filled.copyWith(status: OnboardingStatus.sending),
          filled.copyWith(failure: const NetworkFailure()),
        ];
      },
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'back returns to the name page',
      build: build,
      seed: () => onBirthDatePage,
      act: (cubit) => cubit.back(),
      expect: () => [namesFilled],
    );
  });

  blocTest<OnboardingCubit, OnboardingState>(
    'back does nothing on the first page',
    build: build,
    act: (cubit) => cubit.back(),
    expect: () => <OnboardingState>[],
  );

  blocTest<OnboardingCubit, OnboardingState>(
    'finish on the last page marks onboarding as completed',
    build: build,
    seed: () => const OnboardingState(page: 2),
    act: (cubit) => cubit.finish(),
    expect: () => [
      const OnboardingState(page: 2, status: OnboardingStatus.completing),
      const OnboardingState(page: 2, status: OnboardingStatus.completed),
    ],
    verify: (_) => verify(() => completeOnboarding()).called(1),
  );

  blocTest<OnboardingCubit, OnboardingState>(
    'finish stays on the last page and reports a storage failure',
    build: build,
    setUp: () =>
        when(() => completeOnboarding())
            .thenAnswer((_) async => const Failed(StorageFailure())),
    seed: () => const OnboardingState(page: 2),
    act: (cubit) => cubit.finish(),
    expect: () => [
      const OnboardingState(page: 2, status: OnboardingStatus.completing),
      const OnboardingState(page: 2, failure: StorageFailure()),
    ],
  );

  blocTest<OnboardingCubit, OnboardingState>(
    'finish is ignored before the profile was sent',
    build: build,
    seed: () => namesFilled,
    act: (cubit) => cubit.finish(),
    expect: () => <OnboardingState>[],
  );
}
