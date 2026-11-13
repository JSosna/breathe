import 'package:material_ui/material_ui.dart';

abstract final class FadeThrough {
  static const _outgoing = Interval(0, 0.5, curve: Curves.easeIn);
  static const _incoming = Interval(0.5, 1, curve: Curves.easeOut);

  static Widget build(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: _incoming),
      child: FadeTransition(
        opacity: ReverseAnimation(
          CurvedAnimation(parent: secondaryAnimation, curve: _outgoing),
        ),
        child: child,
      ),
    );
  }
}
