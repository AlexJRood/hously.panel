// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import 'package:hously_flutter/theme/apptheme.dart';
// import 'package:hously_flutter/const/backgroundgradient.dart';
// import 'package:hously_flutter/data/design/design.dart';
// import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
// import 'package:hously_flutter/screens/feed/map/ads_mobile_map_page.dart';
// import 'package:hously_flutter/screens/feed/map/map_page.dart';
// import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
// import 'package:hously_flutter/widgets/screens/feed/map/mobile_map_view_navigation.dart';
// import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
//
// final mapFilteredAdsProvider = StateProvider<List<AdsListViewModel>>((ref) {
//   return [];
// });
//
// class MobileMapPage extends ConsumerStatefulWidget {
//   const MobileMapPage({super.key});
//
//   @override
//   MobileMapviewState createState() => MobileMapviewState();
// }
//
// class MobileMapviewState extends ConsumerState<MobileMapPage>
//     with AutomaticKeepAliveClientMixin {
//   void updateFilteredAds(List<AdsListViewModel> ads) {
//     ref.read(mapFilteredAdsProvider.notifier).state = ads;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(
//         context); // Important to call super.build(context) for AutomaticKeepAliveClientMixin
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Mapa
//           SizedBox(
//             width: double.infinity,
//             height: screenHeight,
//             child: MapPage(
//               onFilteredAdsListViewsChanged: updateFilteredAds,
//             ),
//           ),
//           // Górny pasek aplikacji
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: ShaderMask(
//               shaderCallback: (bounds) =>
//                   BackgroundGradients.appBarGradient.createShader(bounds),
//               child: const AppBarMobile(),
//             ),
//           ),
//           // Pasek nawigacyjny mapy
//           Positioned(
//             bottom: screenHeight * 0.085,
//             right: 0,
//             child: const NavigationBarMapMobile(),
//           ),
//           // Rozwijana szuflada z ogłoszeniami
//           DraggableScrollableSheet(
//             initialChildSize: 0.065,
//             minChildSize: 0.065,
//             maxChildSize: 0.9,
//             builder: (context, scrollController) {
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: CustomBackgroundGradients.getMainMenuBackground(context,ref),
//                   borderRadius:
//                       const BorderRadius.vertical(top: Radius.circular(15)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       spreadRadius: 5,
//                       blurRadius: 7,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: screenWidth / 3,
//                       height: 5,
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         color: Colors.white,
//                       ),
//                     ),
//                     Expanded(
//                       child:
//                           AdsMobileMapPage(scrollController: scrollController),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       bottomNavigationBar: const BottomBarMobile(),
//     );
//   }
//
//   @override
//   bool get wantKeepAlive => true; // Utrzymuj stan aktywny
// }
