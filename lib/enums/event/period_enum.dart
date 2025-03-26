
import 'package:hously_flutter/extensions/string_extension.dart';

enum PeriodEnum {
  day,
  week,
  month,
  year;

  String get type => switch (this) {
        day => name.capitalize(),
        week => name.capitalize(),
        month => name.capitalize(),
        year => name.capitalize(),
      };

  static PeriodEnum fromString(String input) => PeriodEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => day,
      );
}
