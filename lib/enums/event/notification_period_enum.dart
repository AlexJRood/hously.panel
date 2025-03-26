enum NotificationPeriodEnum {
  minutes,
  hours,
  days,
  weeks;

  NotificationPeriodEnum get notificationEnum => switch (this) {
        minutes => NotificationPeriodEnum.minutes,
        hours => NotificationPeriodEnum.hours,
        days => NotificationPeriodEnum.days,
        weeks => NotificationPeriodEnum.weeks,
      };

  static NotificationPeriodEnum fromString(String input) =>
      NotificationPeriodEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => minutes,
      );
}
