import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:shared_preferences/shared_preferences.dart';

final colorSchemeProvider =
    StateProvider<FlexScheme?>((ref) => null); // Nullable provider

// Provider to manage the theme mode (light or dark)
final themeProvider = StateProvider<ThemeMode?>((ref) => null);

class ThemeColors {
  final Color bordercolor;
  final Color sideBarbackground;
  final Color deviceinfocolor;
  final Color taskHeaderColor;
  final Color filterPageColor;
  final Color textColor;
  final Color buttonTextColor;
  final Color textFieldColor;
  final Color buttonGradient;
  final Color popUpIconColor;
  final Color fillColor;
  final Color buttonBackground;
  final Color themeTextColor;
  final Color textButtonColor;
  final Color adPopBackground;
  final Color settingstile;
  final Color userTile;
  final Color togglebuttoncolor;
  final Color popupcontainercolor;
  final Color textfieldnofocus;
  final Color popupcontainertextcolor;
  final Color whitewhiteblack;
  final Color gradienttextfillcolor;
  final Color settingsButtoncolor;
  final Color clientTilecolor;
  final Color clientplaceholdercolor;
  final Color clientbackground;
  final Color clientbuttoncolor;
  final Color checkoutbackground;
  final Color mobileBackground;
  final Color mobileTextcolor;
  final Color settingsMenutile;
  const ThemeColors({
    required this.sideBarbackground,
    required this.mobileTextcolor,
    required this.settingsMenutile,
    required this.mobileBackground,
    required this.bordercolor,
    required this.checkoutbackground,
    required this.clientbackground,
    required this.clientbuttoncolor,
    required this.clientplaceholdercolor,
    required this.clientTilecolor,
    required this.adPopBackground,
    required this.gradienttextfillcolor,
    required this.whitewhiteblack,
    required this.popupcontainertextcolor,
    required this.settingstile,
    required this.userTile,
    required this.textfieldnofocus,
    required this.fillColor,
    required this.textButtonColor,
    required this.taskHeaderColor,
    required this.buttonBackground,
    required this.popUpIconColor,
    required this.buttonGradient,
    required this.textFieldColor,
    required this.themeTextColor,
    required this.filterPageColor,
    required this.textColor,
    required this.buttonTextColor,
    required this.togglebuttoncolor,
    required this.popupcontainercolor,
    required this.deviceinfocolor,
    required this.settingsButtoncolor,
  });
}

class AppTheme {
  static ThemeData dark(FlexScheme scheme, WidgetRef ref) {
    final colorScheme = FlexColorScheme.light(
      scheme: scheme,
      fontFamily: GoogleFonts.inter().fontFamily,
      subThemesData: const FlexSubThemesData(
        elevatedButtonSchemeColor: SchemeColor.onPrimary,
        interactionEffects: true,
        tintedDisabledControls: true,
        blendOnColors: true,
        useM2StyleDividerInM3: true,
        inputDecoratorIsFilled: false,
        inputDecoratorBorderType: FlexInputBorderType.outline,
      ),
    );

    return colorScheme.toTheme.copyWith(
      textTheme: _textTheme(),
      primaryTextTheme: _textTheme(),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        floatingLabelStyle: const TextStyle(color: Colors.black),
        prefixIconColor: Colors.black,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStateProperty.all(Colors.white))),
      iconTheme: const IconThemeData(
        color: Colors.white, // Sets a default icon color for this dark theme
      ),
    );
  }

  static ThemeData light(FlexScheme scheme, WidgetRef ref) {
    final colorScheme = FlexColorScheme.dark(
      fontFamily: GoogleFonts.inter().fontFamily,
      scheme: scheme,
      subThemesData: const FlexSubThemesData(
        elevatedButtonSchemeColor: SchemeColor.onPrimary,
        interactionEffects: true,
        tintedDisabledControls: true,
        blendOnColors: true,
        useM2StyleDividerInM3: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
      ),
    );

    return colorScheme.toTheme.copyWith(
      textTheme: _textTheme(),
      primaryTextTheme: _textTheme(),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        floatingLabelStyle: const TextStyle(color: Colors.white),
        prefixIconColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStateProperty.all(Colors.black))),
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
    );
  }

  static ThemeData system(BuildContext context, WidgetRef ref) {
    final currentthememode = ref.watch(themeProvider);

    return ThemeData(
      fontFamily: GoogleFonts.inter().fontFamily,
      textTheme: _textTheme(),
      primaryTextTheme: _textTheme(),
      iconTheme: IconThemeData(
          color: currentthememode == ThemeMode.system
              ? Colors.white
              : Colors.black),
      primaryColor:
          currentthememode == ThemeMode.system ? Colors.blue : Colors.purple,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: currentthememode == ThemeMode.system
              ? Colors.black
              : Colors.white,
          fontSize: 14,
        ),
        floatingLabelStyle: TextStyle(
            color: currentthememode == ThemeMode.system
                ? Colors.black
                : Colors.white),
        prefixIconColor:
            currentthememode == ThemeMode.system ? Colors.black : Colors.white,
        filled: true,
        fillColor: currentthememode == ThemeMode.system
            ? Colors.white
            : AppColors.dark, // Use dynamic fillColor here
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
              color: currentthememode == ThemeMode.system
                  ? Colors.blue
                  : Colors.purple),
        ),
      ),
    );
  }

  /// ✅ **Text Theme that applies inter to all text**
  static TextTheme _textTheme() {
    return TextTheme(
      headlineLarge: GoogleFonts.libreCaslonText(
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.libreCaslonText(),
      displayLarge: GoogleFonts.inter(),
      displayMedium: GoogleFonts.inter(),
      displaySmall: GoogleFonts.inter(),
      titleLarge: GoogleFonts.inter(),
      titleMedium: GoogleFonts.inter(),
      titleSmall: GoogleFonts.inter(),
      bodyLarge: GoogleFonts.inter(),
      bodyMedium: GoogleFonts.inter(),
      bodySmall: GoogleFonts.inter(),
      labelLarge: GoogleFonts.inter(),
      labelMedium: GoogleFonts.inter(),
      labelSmall: GoogleFonts.inter(),
    );
  }
}

final isDefaultDarkSystemProvider = Provider<bool>((ref) {
  final colorSchemecheck = ref.watch(colorSchemeProvider);
  final currentthemeMode = ref.watch(themeProvider);

  return colorSchemecheck == null &&
      (currentthemeMode == ThemeMode.system ||
          currentthemeMode == ThemeMode.dark);
});

final themeColorsProvider = Provider<ThemeColors>((ref) {
  final currentthememode = ref.watch(themeProvider);

  if (currentthememode == ThemeMode.system) {
    return ThemeColors(
      mobileTextcolor: Colors.white,
      settingsMenutile: const Color(0xff212020),
      mobileBackground: const Color(0xff131313),
      clientbuttoncolor: const Color(0xff373636),
      clientplaceholdercolor: const Color(0xff292929),
      clientbackground: Colors.black,
      clientTilecolor: const Color(0xff212020),
      checkoutbackground: const Color(0xff131313),
      sideBarbackground: AppColors.dark,
      settingsButtoncolor: AppColors.settingsButtoncolor,
      deviceinfocolor: AppColors.deviceinfocolor,
      bordercolor: AppColors.bordercolor,
      gradienttextfillcolor: Colors.black,
      whitewhiteblack: Colors.white,
      popupcontainertextcolor: Colors.grey,
      textfieldnofocus: const Color(0XFF282828),
      togglebuttoncolor: AppColors.togglebuttoncolor,
      popupcontainercolor: AppColors.textfieldpopupcolor,
      adPopBackground: Colors.black,
      settingstile: AppColors.settingstile,
      userTile: AppColors.usertile,
      textButtonColor: AppColors.textbuttonBackgroundColor,
      fillColor: AppColors.light,
      taskHeaderColor: AppColors.primaryColor.withOpacity(0.8),
      buttonBackground: Colors.grey.withOpacity(0.3),
      popUpIconColor: Colors.grey.withOpacity(0.95),
      buttonGradient: AppColors.buttonGradient2,
      textFieldColor: AppColors.textColorDark,
      filterPageColor: AppColors.light.withOpacity(0.5),
      textColor: AppColors.textColorLight,
      buttonTextColor: AppColors.dark,
      themeTextColor: AppColors.textColorLight, // Text color for light theme
    );
  } else if (currentthememode == ThemeMode.light) {
    return ThemeColors(
      sideBarbackground: AppColors.dark,
      mobileTextcolor: Colors.white,
      settingsMenutile: AppColors.dark,
      mobileBackground: Colors.black,
      clientbuttoncolor: AppColors.dark50,
      clientbackground: const Color.fromARGB(255, 56, 55, 55),
      clientTilecolor: Colors.black,
      clientplaceholdercolor: const Color(0xff212121),
      checkoutbackground: AppColors.dark,
      settingsButtoncolor: AppColors.lightSettingsButtoncolor,
      deviceinfocolor: AppColors.darkerLightBlueAccent,
      bordercolor: AppColors.lighterBorderColor,
      textfieldnofocus: const Color(0xFF404040),
      gradienttextfillcolor: Colors.white,
      whitewhiteblack: Colors.black,
      popupcontainertextcolor: Colors.black,
      togglebuttoncolor: AppColors.togglebuttoncolorlight,
      popupcontainercolor: Colors.white,
      settingstile: AppColors.settingstileDarkMode,
      userTile: AppColors.usertileLightMode,
      adPopBackground: Colors.white,
      textButtonColor: Colors.grey,
      fillColor: AppColors.light,
      buttonBackground: Colors.grey.withOpacity(0.3),
      taskHeaderColor: Colors.black,
      popUpIconColor: Colors.black,
      buttonGradient: AppColors.light,
      textFieldColor: AppColors.textColorDark,
      filterPageColor: AppColors.light,
      textColor: AppColors.textColorDark,
      buttonTextColor: AppColors.light,
      themeTextColor: AppColors.textColorLight,
    );
  } else {
    return ThemeColors(
      sideBarbackground: AppColors.light,
      mobileTextcolor: Colors.black,
      settingsMenutile: AppColors.usertileLightMode,
      mobileBackground: AppColors.settingstileLightMode,
      clientbuttoncolor: Colors.grey,
      checkoutbackground: Colors.grey[500]!,
      clientTilecolor: const Color.fromARGB(255, 208, 207, 207),
      clientbackground: const Color.fromARGB(255, 49, 49, 49),
      clientplaceholdercolor: const Color.fromARGB(255, 130, 130, 130),
      settingsButtoncolor: AppColors.darkSettingsButtoncolor,
      deviceinfocolor: AppColors.lighterLightBlueAccent,
      bordercolor: AppColors.darkerBorderColor,
      textfieldnofocus: const Color(0xFF202020),
      gradienttextfillcolor: AppColors.dark,
      popupcontainertextcolor: Colors.white,
      togglebuttoncolor: AppColors.togglebuttoncolordark,
      popupcontainercolor: Colors.black,
      settingstile: AppColors.settingstileDarkMode,
      userTile: AppColors.usertileDarkMode,
      adPopBackground: AppColors.dark50,
      textButtonColor: Colors.black26,
      fillColor: AppColors.dark,
      taskHeaderColor: Colors.white,
      buttonBackground: Colors.black26,
      popUpIconColor: Colors.white,
      buttonGradient: AppColors.dark,
      textFieldColor: AppColors.textColorLight,
      filterPageColor: AppColors.dark.withOpacity(0.5),
      textColor: AppColors.textColorDark,
      buttonTextColor: Colors.black,
      themeTextColor: AppColors.textColorDark,
      whitewhiteblack: Colors.white,
    );
  }
});
ThemeData resolveAppTheme({
  required BuildContext context,
  required WidgetRef ref,
  required ThemeMode currentThemeMode,
  required FlexScheme? colorScheme,
}) {
  if (currentThemeMode == ThemeMode.system && colorScheme == null) {
    return AppTheme.system(context, ref);
  } else if (currentThemeMode == ThemeMode.light && colorScheme != null) {
    return AppTheme.dark(colorScheme, ref);
  } else {
    return AppTheme.system(context, ref);
  }
}

ThemeData getDarkTheme({
  required BuildContext context,
  required WidgetRef ref,
  required ThemeMode currentThemeMode,
  required FlexScheme? colorScheme,
}) {
  if (currentThemeMode == ThemeMode.system && colorScheme == null) {
    return AppTheme.system(context, ref);
  } else if (currentThemeMode == ThemeMode.dark && colorScheme != null) {
    return AppTheme.light(colorScheme, ref);
  } else {
    return AppTheme.system(context, ref);
  }
}

Future<FlexScheme?> loadColorScheme() async {
  final prefs = await SharedPreferences.getInstance();
  final savedScheme = prefs.getString('colorScheme');
  if (savedScheme != null) {
    return FlexScheme.values.firstWhere(
      (scheme) => scheme.name == savedScheme,
    );
  }
  return null; // Use system theme if no saved color scheme
}

Future<ThemeMode> loadSavedThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final themeModeString = prefs.getString('currentheme');

  if (themeModeString != null) {
    // Parse the saved string to a ThemeMode
    switch (themeModeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  return ThemeMode.system; // Default value if nothing is saved
}
