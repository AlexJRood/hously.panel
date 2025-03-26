
import 'package:hously_flutter/extensions/string_extension.dart';

enum EndTypeEnum {
  never,
  onDate,
  after;

  String get type => switch (this) {
        never => name.capitalize(),
        onDate => 'On Date',
        after => name.capitalize(),
      };

  EndTypeEnum get frequenciesEnum => switch (this) {
        never => EndTypeEnum.never,
        onDate => EndTypeEnum.onDate,
        after => EndTypeEnum.after,
      };

  static EndTypeEnum fromString(String input) => EndTypeEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => never,
      );
}
