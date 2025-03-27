
import 'package:hously_flutter/utils/extensions/string_extension.dart';

enum BusinessTypeEnum {
  free,
  busy;

  String get type => switch (this) {
        free => name.capitalize(),
        busy => name.capitalize(),
      };

  BusinessTypeEnum get calendarView => switch (this) {
        busy => BusinessTypeEnum.busy,
        free => BusinessTypeEnum.free,
      };

  static BusinessTypeEnum fromString(String input) =>
      BusinessTypeEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => free,
      );
}
