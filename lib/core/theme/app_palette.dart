import 'package:material_ui/material_ui.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const new({
    required this.background,
    required this.surface,
    required this.ink,
    required this.inkMuted,
    required this.onInk,
    required this.relax,
    required this.focus,
    required this.sleep,
    required this.mascot,
  });

  static const light = AppPalette(
    background: Color(0xFFF6F4EF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF22314A),
    inkMuted: Color(0xFF6B7588),
    onInk: Color(0xFFFFFFFF),
    relax: Color(0xFF6CC3B4),
    focus: Color(0xFFF2B860),
    sleep: Color(0xFF9C8FE0),
    mascot: Color(0xFF8ED9CB),
  );

  final Color background;
  final Color surface;
  final Color ink;
  final Color inkMuted;
  final Color onInk;
  final Color relax;
  final Color focus;
  final Color sleep;
  final Color mascot;

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? ink,
    Color? inkMuted,
    Color? onInk,
    Color? relax,
    Color? focus,
    Color? sleep,
    Color? mascot,
  }) => AppPalette(
    background: background ?? this.background,
    surface: surface ?? this.surface,
    ink: ink ?? this.ink,
    inkMuted: inkMuted ?? this.inkMuted,
    onInk: onInk ?? this.onInk,
    relax: relax ?? this.relax,
    focus: focus ?? this.focus,
    sleep: sleep ?? this.sleep,
    mascot: mascot ?? this.mascot,
  );

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t)!,
      onInk: Color.lerp(onInk, other.onInk, t)!,
      relax: Color.lerp(relax, other.relax, t)!,
      focus: Color.lerp(focus, other.focus, t)!,
      sleep: Color.lerp(sleep, other.sleep, t)!,
      mascot: Color.lerp(mascot, other.mascot, t)!,
    );
  }
}
