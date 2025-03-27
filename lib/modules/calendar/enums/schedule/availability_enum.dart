enum AvailabilityEnum {
  doesNotRepeat,
  repeatWeekly,
  custom;

  String get type => switch (this) {
        doesNotRepeat => 'Does not repeat',
        repeatWeekly => 'Repeat weekly',
        custom => 'Custom',
      };

  AvailabilityEnum get calendarView => switch (this) {
        doesNotRepeat => AvailabilityEnum.doesNotRepeat,
        repeatWeekly => AvailabilityEnum.repeatWeekly,
        custom => AvailabilityEnum.custom,
      };

  static AvailabilityEnum fromString(String input) =>
      AvailabilityEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => doesNotRepeat,
      );
}
