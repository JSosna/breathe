part of 'summary_cubit.dart';

sealed class SummaryState extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

final class SummaryLoading extends SummaryState {
  const new();
}

final class SummaryLoaded extends SummaryState {
  const new(this.summary);

  final SessionSummary summary;

  @override
  List<Object?> get props => [summary];
}

final class SummaryError extends SummaryState {
  const new(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
