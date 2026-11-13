import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/theme/app_palette.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  AppPalette get palette => theme.extension<AppPalette>() ?? AppPalette.light;
}
