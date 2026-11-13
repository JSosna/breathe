import 'package:flutter_test/flutter_test.dart';
import 'package:medcare_breathing/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<OnboardingLocalDataSource> build(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues(values);
    return OnboardingLocalDataSource(await SharedPreferences.getInstance());
  }

  test('reports not completed on the very first launch', () async {
    final source = await build({});
    expect(source.readCompleted(), isFalse);
  });

  test('persists the completed flag', () async {
    final source = await build({});
    await source.writeCompleted();

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool(OnboardingLocalDataSource.completedKey), isTrue);
    expect(source.readCompleted(), isTrue);
  });

  test('reads a flag stored by a previous launch', () async {
    final source = await build({OnboardingLocalDataSource.completedKey: true});
    expect(source.readCompleted(), isTrue);
  });
}
