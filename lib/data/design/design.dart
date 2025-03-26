import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackgroundGradients {
  static const backgroundGradientRight = LinearGradient(
    colors: [AppColors.backgroundgradient1, AppColors.backgroundgradient2],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
  static final backgroundGradientRight35 = LinearGradient(
    colors: [
      AppColors.backgroundgradient1.withOpacity(0.5),
      AppColors.backgroundgradient2.withOpacity(0.5),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
  static const backgroundGradientLeft = LinearGradient(
    colors: [AppColors.backgroundgradient1, AppColors.backgroundgradient2],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );
  static final oppacityGradient35 = LinearGradient(
    colors: [
      AppColors.backgroundOppacity1.withOpacity(0.35),
      AppColors.backgroundOppacity2.withOpacity(0.35),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );
  static final oppacityGradient50 = LinearGradient(
    colors: [
      AppColors.backgroundOppacity1.withOpacity(0.50),
      AppColors.backgroundOppacity2.withOpacity(0.50),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );

  static final oppacityGradient75 = LinearGradient(
    colors: [
      AppColors.backgroundOppacity1.withOpacity(0.75),
      AppColors.backgroundOppacity2.withOpacity(0.75),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );

  static const sideMenuBackground = LinearGradient(
    colors: [AppColors.sidebargradient1, AppColors.sidebargradient2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final adGradient = LinearGradient(
    colors: [
      const Color(0xFF1D3E66).withOpacity(0.25),
      const Color(0xFF4070A9).withOpacity(0.25)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );

  static final adGradient55 = LinearGradient(
    colors: [
      const Color(0xFF1D3E66).withOpacity(0.55),
      const Color(0xFF4070A9).withOpacity(0.55)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );

  static const adGradient100 = LinearGradient(
    colors: [Color(0xFF1D3E66), Color(0xFF4070A9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );

  static const appBarGradient = LinearGradient(
    colors: [AppColors.buttonGradient1, AppColors.buttonGradient2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final loginGradient = LinearGradient(
    colors: [
      AppColors.buttonGradient1.withOpacity(0.75),
      AppColors.buttonGradient2.withOpacity(0.75)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const textfieldborderGradient = LinearGradient(colors: [
    Color(0XFF4F3592),
    Color(0XFFA6E3B8),
  ], begin: Alignment.centerLeft, end: Alignment.centerRight);
}

class AppColors {
  static const light =
      Color.fromARGB(255, 255, 255, 255); // Przykładowy kolor główny
  static const light50 =
      Color.fromARGB(125, 255, 255, 255); // Przykładowy kolor główny
  static const light25 =
      Color.fromARGB(60, 255, 255, 255); // Przykładowy kolor główny
  static const light15 =
      Color.fromARGB(30, 255, 255, 255); // Przykładowy kolor główny
  static const light5 =
      Color.fromARGB(15, 255, 255, 255); // Przykładowy kolor główny
  static const dark =
      Color.fromARGB(255, 37, 37, 37); // Przykładowy kolor główny
  static const dark75 = Color.fromARGB(191, 37, 37, 37);
  static const dark50 = Color.fromARGB(125, 37, 37, 37);
  static const dark25 = Color.fromARGB(60, 37, 37, 37);
  static const primaryColor = Color(0xFF123456); // Przykładowy kolor główny
  static const accentColor = Color(0xFF654321); // Przykładowy kolor akcentujący
  static const superbee = Color.fromARGB(255, 254, 200, 7); // Przykładowy kol
  static const backgroundColor = Color(0xFFF3F4F6); // Kolor tła
  static const textbuttonBackgroundColor = Color(0xFFE9ECF1);
  static const textColorDark = Color(0xFF000000); // Kolor tekstu
  static const textColorLight = Color.fromARGB(255, 255, 255, 255); // Kolor tekstu

  static const textColorLight50 =
      Color.fromARGB(125, 255, 255, 255); // Przykładowy kolor główny

  static const backgroundgradient1 = Color.fromARGB(255, 38, 67, 73);
  static const backgroundgradient2 = Color.fromARGB(255, 26, 28, 41);
  static const backgroundgradient1Light = Color.fromARGB(
      255, 99, 138, 151); // Lighter version of backgroundgradient1
  static const backgroundgradient2Light =
      Color.fromARGB(255, 53, 54, 73); // Lighter version of backgroundgradient2
  static const backgroundOppacity1 = Color.fromARGB(50, 22, 37, 40);
  static const backgroundOppacity2 = Color.fromARGB(50, 15, 16, 21);
  static const sidebargradient1 = Color.fromARGB(255, 38, 67, 73);
  static const sidebargradient2 = Color.fromARGB(255, 41, 45, 73);
  static const sidebargradient1Light =
      Color.fromARGB(255, 100, 140, 150); // Lighter
  static const sidebargradient2Light =
      Color.fromARGB(255, 100, 110, 150); // Lighter
  static const buttonGradient1 = Color(0xFF1D3E66);
  static const buttonGradient2 = Color(0xFF4070A9);
  static const mapMarker = Color.fromARGB(255, 22, 37, 40);
  static const littleRed = Color.fromARGB(255, 255, 220, 220);
  static const hardRed = Color.fromARGB(255, 187, 56, 56);
  static const expensesRed = Color.fromARGB(255, 204, 71, 71);
  static const revenueGreen = Color.fromARGB(255, 60, 170, 84);
  static const settingstile = Color(0xFF363639);
  static const usertile = Color(0xFF2f2d2d);
  static const settingstileLightMode = Color(0xFFB0AFAF);
  static const usertileLightMode = Color(0xFF8C8A8A);
  static const settingstileDarkMode = Color.fromARGB(255, 76, 74, 74);
  static const usertileDarkMode = Color(0xFF2B2929);
  static const togglebuttoncolor = Color(0xFFa6e3b8);
  static const togglebuttoncolorlight = Color(0xFFD4F2DD);
  static const togglebuttoncolordark = Color.fromARGB(255, 9, 59, 29);
  static const bordercolor = Color(0xFFA1ECE6);
  static const darkerBorderColor = Color.fromARGB(255, 113, 17, 120);
  static const lighterBorderColor = Color.fromARGB(255, 106, 250, 128);
  static const deviceinfocolor = Colors.lightBlueAccent;
  static const darkerLightBlueAccent = Color.fromARGB(255, 0, 39, 71);
  static const lighterLightBlueAccent = Color.fromARGB(255, 53, 111, 153);
  static const textfieldpopupcolor = Color(0xFF323232);
  static const settingsButtoncolor = Color(0XFF142132);
  static const darkSettingsButtoncolor = Color(0xFF0E1928);
  static const lightSettingsButtoncolor = Color(0xFF1F3147);
}

// Załóżmy, że kolory są zdefiniowane w osobnym pliku

class AppTextStyles {
  static final houslyAiLogo = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w900,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final houslyAiLogo24 = GoogleFonts.inter(
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final houslyAiLogo30 = GoogleFonts.inter(
    fontSize: 30.0,
    fontWeight: FontWeight.w900,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interBold = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interSemiBold = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interSemiBold14 = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

    static final interSemiBold14Light50 = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: AppColors
        .textColorLight50, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interSemiBold16 = GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interSemiBold18 = GoogleFonts.inter(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium10 = GoogleFonts.inter(
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium12dark = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .textColorDark, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium14 = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium14_50 = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .light50, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium16 = GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium14dark = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .textColorDark, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium16dark = GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .textColorDark, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium18dark = GoogleFonts.inter(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .textColorDark, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium18 = GoogleFonts.inter(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interMedium22 = GoogleFonts.inter(
    fontSize: 22.0,
    fontWeight: FontWeight.w500,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interRegular = GoogleFonts.inter(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interRegular10 = GoogleFonts.inter(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interRegular12 = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interRegular14 = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interRegular16 = GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interRegular14dark = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: AppColors
        .textColorDark, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interRegular16dark = GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    color: AppColors
        .textColorDark, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interLight10 = GoogleFonts.inter(
    fontSize: 10.0,
    fontWeight: FontWeight.w300,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interLight = GoogleFonts.inter(
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );
  static final interLight14 = GoogleFonts.inter(
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );
  static final interLight16 = GoogleFonts.inter(
    fontSize: 16.0,
    fontWeight: FontWeight.w300,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  static final interLight18 = GoogleFonts.inter(
    fontSize: 18.0,
    fontWeight: FontWeight.w300,
    color: AppColors
        .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
  );

  // Definiuj więcej stylów tekstu, które są używane w aplikacji
}

class CrmGradients {
  static const crmGradientRight = LinearGradient(
    colors: [
      CrmColors.crmGradient1,
      CrmColors.crmGradient2,
      CrmColors.crmGradient1
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const whiteGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 153, 153, 153),
      CrmColors.crmGradient1
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static const crmGradientLeft = LinearGradient(
    colors: [CrmColors.crmGradient1, CrmColors.crmGradient2],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );
  static final oppacityGradient35 = LinearGradient(
    colors: [
      CrmColors.backgroundOppacity1.withOpacity(0.35),
      CrmColors.backgroundOppacity2.withOpacity(0.35),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );

  static final oppacityGradient75 = LinearGradient(
    colors: [
      CrmColors.backgroundOppacity1.withOpacity(0.75),
      CrmColors.backgroundOppacity2.withOpacity(0.75),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );

  static const crmSideMenu = LinearGradient(
    colors: [
      CrmColors.crmGradient1,
      CrmColors.crmGradient2,
      CrmColors.crmGradient1
    ],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final adGradient = LinearGradient(
    colors: [
      const Color(0xFF1D3E66).withOpacity(0.25),
      const Color(0xFF4070A9).withOpacity(0.25)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
  );
  static const appBarGradient = LinearGradient(
    colors: [CrmColors.buttonGradient1, CrmColors.buttonGradient2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final loginGradient = LinearGradient(
    colors: [
      CrmColors.buttonGradient1.withOpacity(0.75),
      CrmColors.buttonGradient2.withOpacity(0.75)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class CrmColors {
  static const light =
      Color.fromARGB(255, 255, 255, 255); // Przykładowy kolor główny
  static const dark =
      Color.fromARGB(255, 37, 37, 37); // Przykładowy kolor główny
  static const dark50 = Color.fromARGB(235, 37, 37, 37);
  static const primaryColor = Color(0xFF123456); // Przykładowy kolor główny
  static const accentColor = Color(0xFF654321); // Przykładowy kolor akcentujący
  static const superbee = Color.fromARGB(255, 254, 200, 7); // Przykładowy kol
  static const backgroundColor = Color(0xFFF3F4F6); // Kolor tła
  static const textbuttonBackgroundColor = Color(0xFFF2F5FF);
  static const textColorDark = Color(0xFF000000); // Kolor tekstu
  static const textColorLight =
      Color.fromARGB(255, 255, 255, 255); // Kolor tekstu
  static const crmGradient1 = Color.fromARGB(255, 26, 26, 29);
  static const crmGradient2 = Color.fromARGB(255, 33, 33, 58);
  static const backgroundOppacity1 = Color.fromARGB(50, 22, 37, 40);
  static const backgroundOppacity2 = Color.fromARGB(50, 15, 16, 21);
  static const sidebargradient1 = Color.fromARGB(255, 22, 37, 40);
  static const sidebargradient2 = Color.fromARGB(255, 15, 16, 21);
  static const buttonGradient1 = Color(0xFF1D3E66);
  static const buttonGradient2 = Color(0xFF4070A9);
  static const mapMarker = Color.fromARGB(255, 22, 37, 40);

  // Definiuj więcej kolorów, które są używane w aplikacji
}
