enum DurationType {
  fifteen,
  thirty,
  fortyFive,
  one,
  oneAndHalf,
  two,
  custom;

  String get type => switch (this) {
        fifteen => '15 minutes',
        thirty => '30 minutes',
        fortyFive => '45 minutes',
        one => '1 hour',
        oneAndHalf => '1.5 hours',
        two => '2 hours',
        custom => 'Custom',
      };

  DurationType get calendarView => switch (this) {
        fifteen => DurationType.fifteen,
        thirty => DurationType.thirty,
        fortyFive => DurationType.fortyFive,
        one => DurationType.one,
        oneAndHalf => DurationType.oneAndHalf,
        two => DurationType.two,
        custom => DurationType.custom,
      };

  static DurationType intToEnum(int duration) => switch (duration) {
        15 => fifteen,
        30 => thirty,
        45 => fortyFive,
        60 => one,
        90 => oneAndHalf,
        120 => two,
        _ => custom,
      };

  static int enumToInt(DurationType durationType) => switch (durationType) {
        fifteen => 15,
        thirty => 30,
        fortyFive => 45,
        one => 60,
        oneAndHalf => 90,
        two => 120,
        custom => 1,
      };

  static DurationType fromString(String input) =>
      DurationType.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => fifteen,
      );
}
