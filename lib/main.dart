import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/app/app.dart';
import 'package:medcare_breathing/core/di/injection.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';
import 'package:rive/rive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleSettings.useDeviceLocale();
  await RiveNative.init();
  await configureDependencies();
  runApp(TranslationProvider(child: const BreathApp()));
}
