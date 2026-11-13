abstract final class BirthDateRules {
  static const maxAgeYears = 120;

  static DateTime earliest(DateTime today) =>
      DateTime(today.year - maxAgeYears, today.month, today.day);

  static bool isValid(DateTime birthDate, DateTime today) {
    final date = DateTime(birthDate.year, birthDate.month, birthDate.day);
    final todayDate = DateTime(today.year, today.month, today.day);
    return !date.isAfter(todayDate) && !date.isBefore(earliest(today));
  }
}
