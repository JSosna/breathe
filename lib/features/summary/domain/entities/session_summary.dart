import 'package:equatable/equatable.dart';
import 'package:medcare_breathing/features/breathing/domain/entities/breathing_settings.dart';
import 'package:medcare_breathing/features/user/domain/entities/user_profile.dart';

enum SummaryMessage { deepCalm, relax, focus, sleep }

final class SessionSummary extends Equatable {
  const new({
    required this.profile,
    required this.age,
    required this.settings,
    required this.message,
    required this.mood,
  });

  final UserProfile profile;
  final int age;
  final BreathingSettings settings;
  final SummaryMessage message;

  final double mood;

  @override
  List<Object?> get props => [profile, age, settings, message, mood];

  int get totalBreaths => settings.totalBreaths;
}
