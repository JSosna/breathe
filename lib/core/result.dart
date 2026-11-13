import 'package:equatable/equatable.dart';
import 'package:medcare_breathing/core/error/failure.dart';

sealed class Result<T> extends Equatable {
  const new();

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure failure) onFailure,
  }) => switch (this) {
    Success<T>(:final value) => onSuccess(value),
    Failed<T>(:final failure) => onFailure(failure),
  };
}

final class Success<T> extends Result<T> {
  const new(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}

final class Failed<T> extends Result<T> {
  const new(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
