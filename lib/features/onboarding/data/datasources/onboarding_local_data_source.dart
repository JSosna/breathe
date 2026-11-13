import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class OnboardingLocalDataSource {
  const new(this._preferences);

  static const completedKey = 'onboarding_completed';

  final SharedPreferences _preferences;

  bool readCompleted() => _preferences.getBool(completedKey) ?? false;

  Future<void> writeCompleted() async {
    final saved = await _preferences.setBool(completedKey, true);
    if (!saved) throw StateError('Could not persist $completedKey');
  }
}
