import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/core/clock.dart';
import 'package:medcare_breathing/core/error/failure.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breathing_settings.dart';
import 'package:medcare_breathing/features/summary/domain/usecases/build_session_summary_use_case.dart';
import 'package:medcare_breathing/features/summary/presentation/cubit/summary_cubit.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';
import 'package:medcare_breathing/features/user/domain/usecases/get_user_profile_use_case.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetUserProfile extends Mock implements GetUserProfileUseCase;

class _FixedClock implements Clock {
  @override
  DateTime now() => DateTime(2026, 11, 12);
}

void main() {
  final profile = UserProfile(
    firstName: 'Anna',
    lastName: 'Kowalska',
    birthDate: DateTime(1991, 3, 14),
  );
  final buildSummary = BuildSessionSummaryUseCase(_FixedClock());
  final sleepSettings = BreathingSettings(goal: BreathGoal.sleep);

  late _MockGetUserProfile getUserProfile;

  setUp(() => getUserProfile = _MockGetUserProfile());

  SummaryCubit build() => SummaryCubit(getUserProfile, buildSummary);

  void stubSuccess() =>
      when(() => getUserProfile()).thenAnswer((_) async => Success(profile));

  blocTest<SummaryCubit, SummaryState>(
    'load emits the summary built from the profile and current settings',
    setUp: stubSuccess,
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => [
      SummaryLoaded(buildSummary(profile, BreathingSettings.initial)),
    ],
  );

  blocTest<SummaryCubit, SummaryState>(
    'load emits an error the user can retry from',
    setUp: () =>
        when(() => getUserProfile())
            .thenAnswer((_) async => const Failed(NetworkFailure())),
    build: build,
    act: (cubit) => cubit.load(),
    expect: () => [const SummaryError(NetworkFailure())],
  );

  blocTest<SummaryCubit, SummaryState>(
    'retrying after an error goes back to loading first',
    setUp: stubSuccess,
    build: build,
    seed: () => const SummaryError(NetworkFailure()),
    act: (cubit) => cubit.load(),
    expect: () => [
      const SummaryLoading(),
      SummaryLoaded(buildSummary(profile, BreathingSettings.initial)),
    ],
  );

  blocTest<SummaryCubit, SummaryState>(
    'settingsChanged after loading rebuilds without fetching again',
    setUp: stubSuccess,
    build: build,
    act: (cubit) async {
      await cubit.load();
      cubit.settingsChanged(sleepSettings);
    },
    expect: () => [
      SummaryLoaded(buildSummary(profile, BreathingSettings.initial)),
      SummaryLoaded(buildSummary(profile, sleepSettings)),
    ],
    verify: (_) => verify(() => getUserProfile()).called(1),
  );

  blocTest<SummaryCubit, SummaryState>(
    'settingsChanged before the profile arrives is applied once it does',
    setUp: stubSuccess,
    build: build,
    act: (cubit) async {
      cubit.settingsChanged(sleepSettings);
      await cubit.load();
    },
    expect: () => [SummaryLoaded(buildSummary(profile, sleepSettings))],
  );
}
