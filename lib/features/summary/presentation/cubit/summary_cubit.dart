import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/core/error/failure.dart';
import 'package:medcare_breathing/core/result.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breathing_settings.dart';
import 'package:medcare_breathing/features/summary/domain/entities/session_summary.dart';
import 'package:medcare_breathing/features/summary/domain/usecases/build_session_summary_use_case.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';
import 'package:medcare_breathing/features/user/domain/usecases/get_user_profile_use_case.dart';

part 'summary_state.dart';

@injectable
class SummaryCubit extends Cubit<SummaryState> {
  new(this._getUserProfile, this._composeSummary)
    : super(const SummaryLoading());

  final GetUserProfileUseCase _getUserProfile;
  final BuildSessionSummaryUseCase _composeSummary;

  BreathingSettings _settings = BreathingSettings.initial;
  UserProfile? _profile;

  Future<void> load() async {
    if (state is! SummaryLoading) emit(const SummaryLoading());
    final result = await _getUserProfile();
    if (isClosed) return;
    switch (result) {
      case Success(:final value):
        _profile = value;
        emit(SummaryLoaded(_summaryFor(value)));
      case Failed(:final failure):
        emit(SummaryError(failure));
    }
  }

  void settingsChanged(BreathingSettings settings) {
    _settings = settings;
    final profile = _profile;
    if (profile != null) emit(SummaryLoaded(_summaryFor(profile)));
  }

  SessionSummary _summaryFor(UserProfile profile) =>
      _composeSummary(profile, _settings);
}
