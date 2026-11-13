import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/app/router/app_router.dart';
import 'package:medcare_breathing/core/di/injection.dart';
import 'package:medcare_breathing/core/theme/app_theme.dart';
import 'package:medcare_breathing/i18n/translations.g.dart';
import 'package:medcare_breathing/shared/mascot/mascot_stage.dart';
import 'package:medcare_breathing/shared/rive/rive_file_cache.dart';

class BreathApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: getIt<RiveFileCache>(),
      child: MaterialApp.router(
        onGenerateTitle: (context) => context.t.appTitle,
        theme: AppTheme.light(),
        routerConfig: getIt<AppRouter>().config(),
        builder: (context, child) =>
            MascotStage(child: child ?? const SizedBox.shrink()),
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
