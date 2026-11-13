import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

@immutable
class GazeSource implements ValueListenable<Offset?> {
  const new(this.primary, this.fallback);

  final ValueListenable<Offset?> primary;
  final ValueListenable<Offset?>? fallback;

  @override
  int get hashCode => Object.hash(primary, fallback);

  @override
  Offset? get value => primary.value ?? fallback?.value;

  @override
  bool operator ==(Object other) =>
      other is GazeSource &&
      other.primary == primary &&
      other.fallback == fallback;

  @override
  void addListener(VoidCallback listener) {
    primary.addListener(listener);
    fallback?.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    primary.removeListener(listener);
    fallback?.removeListener(listener);
  }
}
