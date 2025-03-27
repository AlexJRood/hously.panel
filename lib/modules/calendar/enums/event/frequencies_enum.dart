enum FrequenciesEnum {
  daily,
  weekly,
  monthly,
  yearly;

  String get type => switch (this) {
        daily => name.toUpperCase(),
        weekly => name.toUpperCase(),
        monthly => name.toUpperCase(),
        yearly => name.toUpperCase(),
      };

  FrequenciesEnum get frequenciesEnum => switch (this) {
        daily => FrequenciesEnum.daily,
        weekly => FrequenciesEnum.weekly,
        monthly => FrequenciesEnum.monthly,
        yearly => FrequenciesEnum.yearly,
      };

  static FrequenciesEnum fromString(String input) =>
      FrequenciesEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => daily,
      );
}
