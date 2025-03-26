// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart'; 



// class BackgroundGradients {
  
//   static const LinearGradient backgroundGradientRight = LinearGradient(
//     colors: [AppColors.backgroundgradient1, AppColors.backgroundgradient2],
//     begin: Alignment.topRight,
//     end: Alignment.bottomLeft,
//   );
//   static const LinearGradient backgroundGradientLeft = LinearGradient(
//     colors: [AppColors.backgroundgradient1, AppColors.backgroundgradient2],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomLeft,
//   );
//   static final LinearGradient oppacityGradient35 = LinearGradient(
//     colors: [
//       AppColors.backgroundOppacity1.withOpacity(0.35),
//       AppColors.backgroundOppacity2.withOpacity(0.35),
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomLeft,
//   );
//   static final LinearGradient oppacityGradient50 = LinearGradient(
//     colors: [
//       AppColors.backgroundOppacity1.withOpacity(0.50),
//       AppColors.backgroundOppacity2.withOpacity(0.50),
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomLeft,
//   );

//   static final LinearGradient oppacityGradient75 = LinearGradient(
//     colors: [
//       AppColors.backgroundOppacity1.withOpacity(0.75),
//       AppColors.backgroundOppacity2.withOpacity(0.75),
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomLeft,
//   );

//   static const LinearGradient sideMenuBackground = LinearGradient(
//     colors: [AppColors.sidebargradient1, AppColors.sidebargradient2],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   static final LinearGradient adGradient = LinearGradient(
//     colors: [
//       const Color(0xFF1D3E66).withOpacity(0.25),
//       const Color(0xFF4070A9).withOpacity(0.25)
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomLeft,
//   );
//   static const LinearGradient appBarGradient = LinearGradient(
//     colors: [AppColors.buttonGradient1, AppColors.buttonGradient2],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   static final LinearGradient loginGradient = LinearGradient(
//     colors: [
//       AppColors.buttonGradient1.withOpacity(0.75),
//       AppColors.buttonGradient2.withOpacity(0.75)
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

// }


// class AppColors {
//   static const Color light =
//       Color.fromARGB(255, 255, 255, 255); // Przykładowy kolor główny
//   static const Color dark =
//       Color.fromARGB(255, 37, 37, 37); // Przykładowy kolor główny
//         static const Color dark50 =
//       Color.fromARGB(235, 37, 37, 37);
//   static const Color primaryColor =
//       Color(0xFF123456); // Przykładowy kolor główny
//   static const Color accentColor =
//       Color(0xFF654321); // Przykładowy kolor akcentujący
//   static const Color superbee = Color.fromARGB(255, 254, 200, 7); // Przykładowy kol
//   static const Color backgroundColor = Color(0xFFF3F4F6); // Kolor tła
//   static const Color textColorDark = Color(0xFF000000); // Kolor tekstu
//   static const Color textColorLight =
//       Color.fromARGB(255, 255, 255, 255); // Kolor tekstu
//   static const Color backgroundgradient1 = Color.fromARGB(255, 38, 67, 73);
//   static const Color backgroundgradient2 = Color.fromARGB(255, 26, 28, 41);
//   static const Color backgroundOppacity1 = Color.fromARGB(50, 22, 37, 40);
//   static const Color backgroundOppacity2 = Color.fromARGB(50, 15, 16, 21);
//   static const Color sidebargradient1 = Color.fromARGB(255, 38, 67, 73);
//   static const Color sidebargradient2 = Color.fromARGB(255, 41, 45, 73);
//   static const Color buttonGradient1 = Color(0xFF1D3E66);
//   static const Color buttonGradient2 = Color(0xFF4070A9);
//   static const Color mapMarker = Color.fromARGB(255, 22, 37, 40);

//   // Definiuj więcej kolorów, które są używane w aplikacji
// }

// // Załóżmy, że kolory są zdefiniowane w osobnym pliku

// class AppTextStyles {
//   static final TextStyle houslyAiLogo = GoogleFonts.inter(
//     fontSize: 12.0,
//     fontWeight: FontWeight.w900,
//     color: AppColors
//         .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
//   );

//   static final TextStyle interBold = GoogleFonts.inter(
//     fontSize: 12.0,
//     fontWeight: FontWeight.w700,
//     color: AppColors
//         .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
//   );

//   static final TextStyle interSemiBold = GoogleFonts.inter(
//     fontSize: 12.0,
//     fontWeight: FontWeight.w600,
//     color: AppColors
//         .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
//   );


//     static final TextStyle interSemiBold18 = GoogleFonts.inter(
//     fontSize: 18.0,
//     fontWeight: FontWeight.w600,
//     color: AppColors
//         .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
//   );


//   static final TextStyle interMedium = GoogleFonts.inter(
//     fontSize: 12.0,
//     fontWeight: FontWeight.w500,
//     color: AppColors
//         .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
//   );

//   static final TextStyle interMedium14 = GoogleFonts.inter(
//     fontSize: 14.0,
//     fontWeight: FontWeight.w500,
//     color: AppColors
//         .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
//   );

//     static final TextStyle interMedium14dark = GoogleFonts.inter(
//     fontSize: 14.0,
//     fontWeight: FontWeight.w500,
//     color: AppColors
//         .textColorDark, // Upewnij się, że kolor jest zdefiniowany w AppColors
//   );

//   static final TextStyle interRegular = GoogleFonts.inter(
//     fontSize: 12.0,
//     fontWeight: FontWeight.w400,
//     color: AppColors
//         .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
//   );


//     static final TextStyle interRegular14 = GoogleFonts.inter(
//     fontSize: 14.0,
//     fontWeight: FontWeight.w400,
//     color: AppColors
//         .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
//   );


//   static final TextStyle interLight = GoogleFonts.inter(
//     fontSize: 12.0,
//     fontWeight: FontWeight.w300,
//     color: AppColors
//         .textColorLight, // Upewnij się, że kolor jest zdefiniowany w AppColors
//   );

//   // Definiuj więcej stylów tekstu, które są używane w aplikacji
// }




// class CrmGradients {
//   static const LinearGradient crmGradientRight = LinearGradient(
//     colors: [CrmColors.crmGradient1, CrmColors.crmGradient2, CrmColors.crmGradient1],
//     stops: [0.0, 0.5, 1.0],
//     begin: Alignment.topRight,
//     end: Alignment.bottomLeft,
//   );
//   static const LinearGradient crmGradientLeft = LinearGradient(
//     colors: [CrmColors.crmGradient1, CrmColors.crmGradient2],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomLeft,
//   );
//   static final LinearGradient oppacityGradient35 = LinearGradient(
//     colors: [
//       CrmColors.backgroundOppacity1.withOpacity(0.35),
//       CrmColors.backgroundOppacity2.withOpacity(0.35),
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomLeft,
//   );

//   static final LinearGradient oppacityGradient75 = LinearGradient(
//     colors: [
//       CrmColors.backgroundOppacity1.withOpacity(0.75),
//       CrmColors.backgroundOppacity2.withOpacity(0.75),
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomLeft,
//   );

//   static const LinearGradient crmSideMenu = LinearGradient(
//     colors: [CrmColors.crmGradient1, CrmColors.crmGradient2, CrmColors.crmGradient1],
//     stops: [0.0, 0.5, 1.0],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   static final LinearGradient adGradient = LinearGradient(
//     colors: [
//       const Color(0xFF1D3E66).withOpacity(0.25),
//       const Color(0xFF4070A9).withOpacity(0.25)
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomLeft,
//   );
//   static const LinearGradient appBarGradient = LinearGradient(
//     colors: [CrmColors.buttonGradient1, CrmColors.buttonGradient2],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   static final LinearGradient loginGradient = LinearGradient(
//     colors: [
//       CrmColors.buttonGradient1.withOpacity(0.75),
//       CrmColors.buttonGradient2.withOpacity(0.75)
//     ],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
// }

// class CrmColors {
//   static const Color light =
//       Color.fromARGB(255, 255, 255, 255); // Przykładowy kolor główny
//   static const Color dark =
//       Color.fromARGB(255, 37, 37, 37); // Przykładowy kolor główny
//         static const Color dark50 =
//       Color.fromARGB(235, 37, 37, 37);
//   static const Color primaryColor =
//       Color(0xFF123456); // Przykładowy kolor główny
//   static const Color accentColor =
//       Color(0xFF654321); // Przykładowy kolor akcentujący
//   static const Color superbee = Color.fromARGB(255, 254, 200, 7); // Przykładowy kol
//   static const Color backgroundColor = Color(0xFFF3F4F6); // Kolor tła
//   static const Color textColorDark = Color(0xFF000000); // Kolor tekstu
//   static const Color textColorLight =
//       Color.fromARGB(255, 255, 255, 255); // Kolor tekstu
//   static const Color crmGradient1 = Color.fromARGB(255, 26, 26, 29);
//   static const Color crmGradient2 = Color.fromARGB(255, 33, 33, 58);
//   static const Color backgroundOppacity1 = Color.fromARGB(50, 22, 37, 40);
//   static const Color backgroundOppacity2 = Color.fromARGB(50, 15, 16, 21);
//   static const Color sidebargradient1 = Color.fromARGB(255, 22, 37, 40);
//   static const Color sidebargradient2 = Color.fromARGB(255, 15, 16, 21);
//   static const Color buttonGradient1 = Color(0xFF1D3E66);
//   static const Color buttonGradient2 = Color(0xFF4070A9);
//   static const Color mapMarker = Color.fromARGB(255, 22, 37, 40);

//   // Definiuj więcej kolorów, które są używane w aplikacji
// }

