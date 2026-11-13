import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medcare_breathing/core/theme/app_palette.dart';
import 'package:medcare_breathing/core/theme/radius.dart';
import 'package:medcare_breathing/core/theme/spacings.dart';

abstract final class AppTheme {
  static const _buttonHeight = 56.0;
  static const _sliderTrackHeight = 6.0;
  static const _inactiveTrackAlpha = 0.13;
  static const _focusedBorderWidth = 1.5;
  static const _dividerAlpha = 0.08;

  static const inputPadding = EdgeInsets.symmetric(
    horizontal: Spacings.sp20,
    vertical: Spacings.sp16,
  );

  static ThemeData light() {
    const palette = AppPalette.light;
    final text = GoogleFonts.manropeTextTheme().apply(
      bodyColor: palette.ink,
      displayColor: palette.ink,
    );
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.relax,
        surface: palette.background,
        onSurface: palette.ink,
      ),
      extensions: const [palette],
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: text.copyWith(
        headlineMedium: text.headlineMedium?.copyWith(
          fontWeight: FontWeight.w800,
        ),
        titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: palette.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: palette.ink,
          foregroundColor: palette.onInk,
          minimumSize: const Size.fromHeight(_buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Radius.r12),
          ),
          textStyle: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: palette.ink,
        thumbColor: palette.ink,
        inactiveTrackColor: palette.ink.withValues(alpha: _inactiveTrackAlpha),
        trackHeight: _sliderTrackHeight,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.surface,
        contentPadding: inputPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radius.r12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radius.r12),
          borderSide: BorderSide(
            color: palette.ink,
            width: _focusedBorderWidth,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: palette.ink.withValues(alpha: _dividerAlpha),
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardThemeData(
        color: palette.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radius.r16),
        ),
      ),
    );
  }
}
