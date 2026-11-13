part of 'onboarding_cubit.dart';

enum OnboardingStatus { editing, sending, completing, completed }

final class OnboardingState extends Equatable {
  const new({
    this.page = 0,
    this.status = OnboardingStatus.editing,
    this.firstName = '',
    this.lastName = '',
    this.birthDate,
    this.failure,
  });

  static const pageCount = 3;
  static const namePage = 0;
  static const birthDatePage = 1;

  final int page;
  final OnboardingStatus status;

  final String firstName;
  final String lastName;
  final DateTime? birthDate;

  final Failure? failure;

  @override
  List<Object?> get props => [
    page,
    status,
    firstName,
    lastName,
    birthDate,
    failure,
  ];

  bool get isLastPage => page == pageCount - 1;

  bool get isBusy => status != OnboardingStatus.editing;

  bool get hasValidNames =>
      PersonName.normalize(firstName) != null &&
      PersonName.normalize(lastName) != null;

  bool get canContinue => switch (page) {
    namePage => hasValidNames,
    birthDatePage => hasValidNames && birthDate != null,
    _ => true,
  };

  OnboardingState copyWith({
    int? page,
    OnboardingStatus? status,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    Failure? failure,
  }) => OnboardingState(
    page: page ?? this.page,
    status: status ?? this.status,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    birthDate: birthDate ?? this.birthDate,
    failure: failure,
  );
}
