// // ignore_for_file: avoid_unnecessary_containers

// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hously_flutter/const/values.dart';

// import 'package:hously_flutter/const/backgroundgradient.dart';
// import 'package:hously_flutter/data/design/design.dart';
// import 'package:hously_flutter/widgets/installpopup/install_popup.dart';

// import 'package:hously_flutter/widgets/appbar/hously/mobile/apptour_appbar_mobile.dart';
// import 'package:hously_flutter/widgets/article_module.dart';
// import 'package:hously_flutter/widgets/bottom_bar_mobile/apptour_bottom_bar.dart';

// import 'package:hously_flutter/widgets/screens/home_page/best_in.dart';
// import 'package:hously_flutter/widgets/screens/home_page/best_in2.dart';
// import 'package:hously_flutter/widgets/screens/home_page/best_in_stettin.dart';
// import 'package:hously_flutter/widgets/screens/home_page/bottom_feet_mobile.dart';
// import 'package:hously_flutter/widgets/screens/home_page/hot_carousel.dart';
// import 'package:hously_flutter/widgets/screens/home_page/recomended_for_you.dart';
// import 'package:hously_flutter/widgets/screens/home_page/recomended_for_you2.dart';
// import 'package:hously_flutter/widgets/screens/home_page/why_us.dart';
// import 'package:hously_flutter/widgets/screens/landing_page/filters_landing_page_mobile.dart';
// import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
// import 'package:pie_menu/pie_menu.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:showcaseview/showcaseview.dart';
// import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';



// class LandingMobilePage extends ConsumerStatefulWidget {
//   const LandingMobilePage({super.key});

//   @override
//   ConsumerState<LandingMobilePage> createState() => _LandingMobilePageState();
// }

// class _LandingMobilePageState extends ConsumerState<LandingMobilePage> {
//   late GlobalKey oneKey;
//   late GlobalKey twoKey;
//   late GlobalKey threeKey;
//   late GlobalKey fourKey;

//   @override
//   void initState() {
       

//     super.initState();
//     oneKey = ref.read(home1);
//     twoKey = ref.read(home2);
//     threeKey = ref.read(home3);
//     fourKey = ref.read(home4);
//     _checkAndStartShowCase();
    
//   }
//   final sideMenuKey = GlobalKey<SideMenuState>();

//   Future<void> _checkAndStartShowCase() async {
//     final prefs = await SharedPreferences.getInstance();
//     //prefs.clear();
//     final isShowCaseDisplayed = prefs.getBool('onetime') ?? false;

//     if (!isShowCaseDisplayed) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         ShowCaseWidget.of(context).startShowCase([
//           oneKey,
//           twoKey,
//           threeKey,
//           fourKey,
//         ]);
//       });

//       // Mark showcase as displayed
//       await prefs.setBool('onetime', true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     const double maxWidth = 1920;
//     const double minWidth = 350;
//     const double maxDynamicPadding = 40;
//     const double minDynamicPadding = 5;
//     double dynamicPadding = (screenWidth - minWidth) / (maxWidth - minWidth) * (maxDynamicPadding - minDynamicPadding) + minDynamicPadding;
//     dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);

//     return PieCanvas(
//       theme: const PieTheme(
//         rightClickShowsMenu: true,
//         leftClickShowsMenu: false,
//         buttonTheme: PieButtonTheme(
//           backgroundColor: AppColors.buttonGradient1,
//           iconColor: Colors.white,
//         ),
//         buttonThemeHovered: PieButtonTheme(
//           backgroundColor: Color.fromARGB(96, 58, 58, 58),
//           iconColor: Colors.white,
//         ),
//       ),
//       child: PopupListener(
//         child: SafeArea(
//           child: Scaffold(
//             body: SideMenuManager.sideMenuSettings(
//               menuKey: sideMenuKey,
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: double.infinity,
//                       decoration: BoxDecoration(
//                         gradient: CustomBackgroundGradients.getMainMenuBackground(
//                             context, ref),
//                       ),
//                       child: Stack(
//                         children: [
//                           SingleChildScrollView(
//                             child: Stack(
//                               children: [
//                                 Stack(
//                                   children: [
//                                     Container(
//                                       height: screenHeight * 0.75,
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   height: screenHeight * 0.75,
//                                   decoration: const BoxDecoration(
//                                     image: DecorationImage(
//                                       image: AssetImage(
//                                           "assets/images/landingpage2.webp"),
//                                       fit: BoxFit.cover,
//                                     ),
//                                     // Adding rounded corners to the bottom
//                                     borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(
//                                           20), // Adjust the radius to your preference
//                                       bottomRight: Radius.circular(20),
//                                     ),
//                                   ),
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(height: 0.0),
//                                     SizedBox(height: screenHeight * 0.6),
//                                     const FiltersLandingPageMobile(),
//                                     const SizedBox(
//                                       height: 50,
//                                     ),
//                                     const HotCarousel(),
//                                     const SizedBox(
//                                       height: 50,
//                                     ),
//                                     const ArticlesHomepage(),
//                                     const SizedBox(height: 50.0),
//                                     const RecomendedForYou(),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     const RecomendedForYou2(),
//                                     const SizedBox(
//                                       height: 50,
//                                     ),
//                                     const WhyUs(),
//                                     const SizedBox(height: 50.0),
//                                     const BestIn(),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     const BestIn2(),
//                                     const SizedBox(height: 50.0),
//                                     const BestInStettin(),
//                                     const SizedBox(height: 50.0),
//                                     const BottomFeetMobile(),
//                                     const SizedBox(height: 0),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             top: 0,
//                             left: 0,
//                             right: 0,
//                             child: ClipRRect(
//                               child: BackdropFilter(
//                                 filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
//                                 child: Container(
//                                   child: ApptourAppbarMobile(sideMenuKey: sideMenuKey,),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const NewBottomBar()
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }