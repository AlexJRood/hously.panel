import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/design.dart';

class CustomBackgroundGradients {
  static LinearGradient getSideMenuBackgroundcustom(
      BuildContext context, WidgetRef ref) {
    final currentScheme = ref.watch(colorSchemeProvider);
    final currentthememode = ref.watch(themeProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.surfaceBright,
          colorScheme.primary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.onSurface,
          colorScheme.primary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.sidebargradient1Light,
          AppColors.sidebargradient2Light,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return BackgroundGradients.sideMenuBackground;
  }

  static LinearGradient textFieldGradient(BuildContext context, WidgetRef ref) {
    final currentScheme = ref.watch(colorSchemeProvider);
    final currentthememode = ref.watch(themeProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.primary,
          colorScheme.secondary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.primary,
          colorScheme.secondary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.sidebargradient1Light,
          AppColors.sidebargradient2Light,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return BackgroundGradients.sideMenuBackground;
  }

  static LinearGradient textFieldGradient2(
      BuildContext context, WidgetRef ref) {
    final currentScheme = ref.watch(colorSchemeProvider);
    final currentthememode = ref.watch(themeProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.primary.withOpacity(0.5),
          colorScheme.secondary.withOpacity(0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.primary.withOpacity(0.5),
          colorScheme.secondary.withOpacity(0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.backgroundgradient1Light,
          AppColors.backgroundgradient2Light
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      );
    }

    return BackgroundGradients.backgroundGradientRight;
  }

  static LinearGradient textfieldBorder(BuildContext context, WidgetRef ref) {
    final currentScheme = ref.watch(colorSchemeProvider);
    final currentthememode = ref.watch(themeProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.surfaceBright,
          colorScheme.primary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.onSurface,
          colorScheme.primary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.backgroundgradient1Light,
          AppColors.backgroundgradient2Light
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      );
    }

    return BackgroundGradients.textfieldborderGradient;
  }

  static LinearGradient customcrmSideMenu(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentScheme = ref.watch(colorSchemeProvider);

    final colorScheme = theme.colorScheme;
    final currentthememode = ref.watch(themeProvider);

    if (currentScheme != null && currentthememode == ThemeMode.light) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          colorScheme.onPrimaryContainer,
          colorScheme.primary,
          colorScheme.onPrimaryContainer
        ],
      );
    } else if (currentScheme != null && currentthememode == ThemeMode.dark) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          colorScheme.onInverseSurface,
          colorScheme.primary,
          colorScheme.onInverseSurface
        ],
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          Color.fromARGB(255, 87, 87, 97),
          Color.fromARGB(255, 79, 79, 168),
          Color.fromARGB(255, 87, 87, 97),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      );
    }

    return CrmGradients.crmSideMenu;
  }

  static LinearGradient customcrmright(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentScheme = ref.watch(colorSchemeProvider);
    final colorScheme = theme.colorScheme;
    final currentthememode = ref.watch(themeProvider);

    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [colorScheme.surface, colorScheme.primary, colorScheme.surface],
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          colorScheme.onPrimaryContainer,
          colorScheme.primary,
          colorScheme.onPrimaryContainer
        ],
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          Color.fromARGB(255, 87, 87, 97),
          Color.fromARGB(255, 79, 79, 168),
          Color.fromARGB(255, 87, 87, 97),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      );
    }

    return CrmGradients.crmGradientRight;
  }

  static LinearGradient backgroundGradientRight1(
      BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentthememode = ref.watch(themeProvider);
    final colorScheme = theme.colorScheme;
    final currentScheme = ref.watch(colorSchemeProvider);
    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.surfaceBright.withOpacity(0.9),
          colorScheme.primary.withOpacity(0.9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.onSurface.withOpacity(0.9),
          colorScheme.primary.withOpacity(0.9),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.sidebargradient1Light,
          AppColors.sidebargradient2Light,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
    return BackgroundGradients.backgroundGradientRight;
  }

  static LinearGradient backgroundGradientRight35(
      BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentthememode = ref.watch(themeProvider);
    final colorScheme = theme.colorScheme;
    final currentScheme = ref.watch(colorSchemeProvider);
    if (currentScheme != null) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          colorScheme.primary
              .withOpacity(0.5), // Light theme onSurface variant color
          colorScheme.primaryContainer
              .withOpacity(0.5), // Light theme surface variant color
        ],
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.sidebargradient1Light,
          AppColors.sidebargradient2Light,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    // Default to system theme gradient
    return BackgroundGradients.backgroundGradientRight35;
  }

  static LinearGradient crmadgradient(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentScheme = ref.watch(colorSchemeProvider);
    final colorScheme = theme.colorScheme;
    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.primaryContainer.withOpacity(0.25),
          colorScheme.primaryContainer.withOpacity(0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.secondaryContainer.withOpacity(0.25),
          colorScheme.secondaryContainer.withOpacity(0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return BackgroundGradients.adGradient;
  }

  static LinearGradient adGradient1(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentthememode = ref.watch(themeProvider);
    final currentScheme = ref.watch(colorSchemeProvider);
    final colorScheme = theme.colorScheme;
    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomLeft,
        colors: [
          colorScheme.primary.withOpacity(0.25),
          colorScheme.onSurface.withOpacity(0.25),
        ],
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          colorScheme.primary.withOpacity(0.25),
          colorScheme.surfaceTint.withOpacity(0.25),
        ],
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return LinearGradient(
        colors: [
          AppColors.sidebargradient1Light.withOpacity(0.25),
          AppColors.sidebargradient2Light.withOpacity(0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return BackgroundGradients.adGradient;
  }

  static LinearGradient logingradient(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentScheme = ref.watch(colorSchemeProvider);
    final colorScheme = theme.colorScheme;
    final currentthememode = ref.watch(themeProvider);
    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomLeft,
        colors: [
          colorScheme.primary.withOpacity(0.25),
          colorScheme.onSurface.withOpacity(0.25),
        ],
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          colorScheme.primary.withOpacity(0.75),
          colorScheme.surfaceTint.withOpacity(0.75),
        ],
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.sidebargradient1Light,
          AppColors.sidebargradient2Light,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return BackgroundGradients.loginGradient;
  }

  static LinearGradient getbuttonGradient1(
      BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentScheme = ref.watch(colorSchemeProvider);
    final currentthememode = ref.watch(themeProvider);
    if (currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.secondary
              .withOpacity(0.5), // Light theme onSurface variant color
          colorScheme.primary
              .withOpacity(0.5), // Light theme surface variant color
        ],
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.sidebargradient1Light,
          AppColors.sidebargradient2Light,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return BackgroundGradients.appBarGradient;
  }

  static LinearGradient appBarGradientcustom(
      BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentScheme = ref.watch(colorSchemeProvider);
    final currentthememode = ref.watch(themeProvider);
    if (currentScheme != null) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          colorScheme.primary
              .withOpacity(1), // Light theme onSurface variant color
          colorScheme.primary
              .withOpacity(1), // Light theme surface variant color
        ],
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.sidebargradient2Light,
          AppColors.sidebargradient2Light,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return BackgroundGradients.appBarGradient;
  }

  static LinearGradient supprtfield(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentScheme = ref.watch(colorSchemeProvider);
    final currentthememode = ref.watch(themeProvider);
    if (currentScheme != null) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          colorScheme.primary
              .withOpacity(1), // Light theme onSurface variant color
          colorScheme.primary
              .withOpacity(1), // Light theme surface variant color
        ],
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.sidebargradient2Light,
          AppColors.sidebargradient2Light,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return LinearGradient(
      colors: [
        Colors.red,
        Colors.blue,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  static LinearGradient getMainMenuBackground(
      BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentScheme = ref.watch(colorSchemeProvider);
    final colorScheme = theme.colorScheme;
    final currentthememode = ref.watch(themeProvider);

    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.surfaceBright,
          colorScheme.primary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.onSurface,
          colorScheme.primary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.backgroundgradient1Light,
          AppColors.backgroundgradient2Light
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      );
    }

    return BackgroundGradients.backgroundGradientRight;
  }

  static LinearGradient proContainerGradient(
      BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentScheme = ref.watch(colorSchemeProvider);
    final colorScheme = theme.colorScheme;
    final currentthememode = ref.watch(themeProvider);

    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.primary,
          colorScheme.secondary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.primary,
          colorScheme.secondary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          Color.fromARGB(255, 101, 152, 235),
          Color.fromARGB(255, 170, 121, 255)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
    }

    return const LinearGradient(
      colors: [Color(0xFF3B82F6), Color(0xFF7C3AED)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

  static LinearGradient getaddpagebackground(
      BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentScheme = ref.watch(colorSchemeProvider);
    final colorScheme = theme.colorScheme;
    final currentthememode = ref.watch(themeProvider);
    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.surfaceBright,
          colorScheme.primary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.onSurface,
          colorScheme.primary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          AppColors.sidebargradient1Light,
          AppColors.sidebargradient2Light,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return BackgroundGradients.adGradient;
  }

  static LinearGradient getSideMenuBackgroundwithopacity(
      BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentScheme = ref.watch(colorSchemeProvider);
    final currentthememode = ref.watch(themeProvider);
    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.surfaceBright.withOpacity(0.1),
          colorScheme.primary.withOpacity(0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.onSurface.withOpacity(0.1),
          colorScheme.primary.withOpacity(0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return LinearGradient(
        colors: [
          AppColors.sidebargradient1Light.withOpacity(0.1),
          AppColors.sidebargradient2Light.withOpacity(0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }

    return BackgroundGradients.oppacityGradient75;
  }

  static LinearGradient getSideMenuBackgroundmobile(
      BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentScheme = ref.watch(colorSchemeProvider);
    final currentthememode = ref.watch(themeProvider);
    if (theme.brightness == Brightness.dark && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.surfaceBright,
          colorScheme.primary,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    } else if (theme.brightness == Brightness.light && currentScheme != null) {
      return LinearGradient(
        colors: [
          colorScheme.onSurface,
          colorScheme.primary,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    } else if (currentthememode == ThemeMode.dark && currentScheme == null) {
      return const LinearGradient(
        colors: [
          Color.fromARGB(255, 86, 123, 133),
          Color.fromARGB(255, 70, 81, 126),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
    }

    return BackgroundGradients.sideMenuBackground;
  }
}
