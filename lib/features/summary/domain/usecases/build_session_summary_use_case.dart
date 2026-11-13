import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/core/clock.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breath_goal.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breathing_settings.dart';
import 'package:medcare_breathing/features/summary/domain/entities/session_summary.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';

@injectable
class BuildSessionSummaryUseCase {
  const new(this._clock);

  static const deepCalmMaxBreathsPerMinute = 6;

  final Clock _clock;

  SessionSummary call(UserProfile profile, BreathingSettings settings) {
    final message = _messageFor(settings);
    return SessionSummary(
      profile: profile,
      age: profile.ageAt(_clock.now()),
      settings: settings,
      message: message,
      mood: switch (message) {
        SummaryMessage.deepCalm => 100,
        SummaryMessage.relax => 80,
        SummaryMessage.focus => 50,
        SummaryMessage.sleep => 0,
      },
    );
  }

  SummaryMessage _messageFor(BreathingSettings settings) =>
      switch (settings.goal) {
        BreathGoal.relax
            when settings.breathsPerMinute <= deepCalmMaxBreathsPerMinute =>
          SummaryMessage.deepCalm,
        BreathGoal.relax => SummaryMessage.relax,
        BreathGoal.focus => SummaryMessage.focus,
        BreathGoal.sleep => SummaryMessage.sleep,
      };
}
