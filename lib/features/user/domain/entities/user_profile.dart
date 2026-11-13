import 'dart:math' as math;

import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const new({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
  });

  final String firstName;
  final String lastName;
  final DateTime birthDate;

  @override
  List<Object?> get props => [firstName, lastName, birthDate];

  String get fullName => '$firstName $lastName';

  int ageAt(DateTime today) => ageFrom(birthDate, today);

  static int ageFrom(DateTime birthDate, DateTime today) {
    final todayDate = DateTime(today.year, today.month, today.day);
    final birthdayThisYear = DateTime(
      today.year,
      birthDate.month,
      birthDate.day,
    );
    var age = today.year - birthDate.year;
    if (todayDate.isBefore(birthdayThisYear)) age--;
    return math.max(age, 0);
  }
}
