enum MonthlyOptionEnum {
  dayBefore,
  secondWednesday;

  String get type => switch (this) {
        dayBefore => 'Day before today',
        secondWednesday => 'Second weekday of the month',
      };

  MonthlyOptionEnum get frequenciesEnum => switch (this) {
        dayBefore => MonthlyOptionEnum.dayBefore,
        secondWednesday => MonthlyOptionEnum.secondWednesday,
      };

  static MonthlyOptionEnum fromString(String input) =>
      MonthlyOptionEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => dayBefore,
      );
}
