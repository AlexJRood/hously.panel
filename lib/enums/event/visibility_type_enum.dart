
import 'package:hously_flutter/extensions/string_extension.dart';

enum VisibilityTypeEnum {
  defaultVisibility,
  public,
  private;

  String get type => switch (this) {
        defaultVisibility => 'Default Visibility',
        private => name.capitalize(),
        public => name.capitalize(),
      };

  VisibilityTypeEnum get calendarView => switch (this) {
        defaultVisibility => VisibilityTypeEnum.defaultVisibility,
        private => VisibilityTypeEnum.private,
        public => VisibilityTypeEnum.public,
      };

  static VisibilityTypeEnum fromString(String input) =>
      VisibilityTypeEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => defaultVisibility,
      );
}
