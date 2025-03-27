enum RepeatEnum {
  doesNotRepeat,
  daily,
  weekdays,
  weekly,
  monthly,
  yearly,
  custom;

  String get name => switch (this) {
        doesNotRepeat => 'Does not repeat',
        daily => 'Daily',
        weekdays => 'Weekdays (Mon-Fri)',
        weekly => 'Weekly on Monday',
        monthly => 'Monthly (first Monday)',
        yearly => 'Yearly (every October 1)',
        custom => 'Custom',
      };

  String recurrenceRule(DateTime currentDate) {
    final dayBefore = currentDate.subtract(const Duration(days: 1));

    switch (this) {
      case doesNotRepeat:
        return '';
      case daily:
        return 'FREQ=DAILY';
      case weekdays:
        return 'FREQ=WEEKLY;BYDAY=MO,TU,WE,TH,FR';
      case weekly:
        return 'FREQ=WEEKLY;BYDAY=MO';
      case monthly:
        return 'FREQ=MONTHLY;BYDAY=1MO';
      case yearly:
        return 'FREQ=YEARLY;BYMONTH=${dayBefore.month};BYMONTHDAY=${dayBefore.day}';
      case custom:
        return 'Custom';
    }
  }

  static RepeatEnum fromString(String input) => RepeatEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => doesNotRepeat,
      );
}
