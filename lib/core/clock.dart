import 'package:injectable/injectable.dart';

abstract interface class Clock {
  DateTime now();
}

@LazySingleton(as: Clock)
class SystemClock implements Clock {
  const new();

  @override
  DateTime now() => DateTime.now();
}
