import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class NetworkFailure extends Failure {
  const new();
}

final class ParsingFailure extends Failure {
  const new();
}

final class NotFoundFailure extends Failure {
  const new();
}

final class StorageFailure extends Failure {
  const new();
}
