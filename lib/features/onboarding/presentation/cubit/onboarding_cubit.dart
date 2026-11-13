import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/core/clock.dart';
import 'package:medcare_breathing/core/error/failure.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:medcare_breathing/features/user/domain/entities/birth_date_rules.dart';
import 'package:medcare_breathing/features/user/domain/entities/person_name.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';
import 'package:medcare_breathing/features/user/domain/usecases/save_user_profile_use_case.dart';

part 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  new(this._saveUserProfile, this._completeOnboarding, this._clock)
    : super(const OnboardingState());

  final SaveUserProfileUseCase _saveUserProfile;
  final CompleteOnboardingUseCase _completeOnboarding;
  final Clock _clock;

  DateTime today() => _clock.now();

  void firstNameChanged(String value) => emit(state.copyWith(firstName: value));

  void lastNameChanged(String value) => emit(state.copyWith(lastName: value));

  void birthDateChanged(DateTime value) {
    if (!BirthDateRules.isValid(value, _clock.now())) return;
    emit(state.copyWith(birthDate: value));
  }

  Future<void> next() async {
    if (state.isBusy || state.isLastPage || !state.canContinue) return;
    if (state.page == OnboardingState.birthDatePage) {
      await _sendProfile();
      return;
    }
    emit(state.copyWith(page: state.page + 1));
  }

  void back() {
    if (state.isBusy || state.page == 0) return;
    emit(state.copyWith(page: state.page - 1));
  }

  Future<void> finish() async {
    if (state.isBusy || !state.isLastPage) return;

    emit(state.copyWith(status: OnboardingStatus.completing));

    final result = await _completeOnboarding();
    if (isClosed) return;

    switch (result) {
      case Success():
        emit(state.copyWith(status: OnboardingStatus.completed));
      case Failed(:final failure):
        emit(
          state.copyWith(status: OnboardingStatus.editing, failure: failure),
        );
    }
  }

  Future<void> _sendProfile() async {
    emit(state.copyWith(status: OnboardingStatus.sending));

    final result = await _saveUserProfile(
      UserProfile(
        firstName: PersonName.normalize(state.firstName)!,
        lastName: PersonName.normalize(state.lastName)!,
        birthDate: state.birthDate!,
      ),
    );
    if (isClosed) return;

    switch (result) {
      case Success():
        emit(
          state.copyWith(
            status: OnboardingStatus.editing,
            page: state.page + 1,
          ),
        );
      case Failed(:final failure):
        emit(
          state.copyWith(status: OnboardingStatus.editing, failure: failure),
        );
    }
  }
}
