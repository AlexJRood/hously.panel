enum WeekdaysEnum {
  mo,
  tu,
  we,
  th,
  fr,
  sa,
  su;

  String get type => switch (this) {
        mo => name.toUpperCase(),
        tu => name.toUpperCase(),
        we => name.toUpperCase(),
        th => name.toUpperCase(),
        fr => name.toUpperCase(),
        sa => name.toUpperCase(),
        su => name.toUpperCase(),
      };

  WeekdaysEnum get frequenciesEnum => switch (this) {
        mo => WeekdaysEnum.mo,
        tu => WeekdaysEnum.tu,
        we => WeekdaysEnum.we,
        th => WeekdaysEnum.th,
        fr => WeekdaysEnum.fr,
        sa => WeekdaysEnum.sa,
        su => WeekdaysEnum.su,
      };

  static WeekdaysEnum fromString(String input) =>
      WeekdaysEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => mo,
      );
}
