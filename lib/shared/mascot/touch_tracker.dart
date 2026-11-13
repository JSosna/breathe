import 'dart:ui';

class TouchTracker {
  final _current = <int, Offset>{};
  final _origins = <int, Offset>{};

  Offset? get focus => _current.isEmpty ? null : _current.values.last;

  void down(int pointer, Offset position) {
    _current.remove(pointer);
    _current[pointer] = position;
    _origins[pointer] = position;
  }

  void move(int pointer, Offset position) {
    if (_current.remove(pointer) == null) return;
    _current[pointer] = position;
  }

  Offset? up(int pointer) {
    _current.remove(pointer);
    return _origins.remove(pointer);
  }

  void cancel(int pointer) {
    _current.remove(pointer);
    _origins.remove(pointer);
  }
}
