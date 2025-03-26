// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hously_flutter/const/route_constant.dart';
// import 'package:hously_flutter/data/design/design.dart';
// import 'package:hously_flutter/screens/feed/map/mobile_map_page.dart';
// import 'package:hously_flutter/state_managers/services/navigation_service.dart';
// import 'package:hously_flutter/utils/pie_menu/feed.dart';
// import 'package:intl/intl.dart';
// import 'package:pie_menu/pie_menu.dart';
//
// class AdsMobileMapPage extends ConsumerWidget {
//   final ScrollController scrollController;
//
//   const AdsMobileMapPage({super.key, required this.scrollController});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final screenWidth = MediaQuery.of(context).size.width;
//     final filteredAds = ref.watch(mapFilteredAdsProvider);
//
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
//       child: ListView.builder(
//         controller: scrollController,
//         itemCount: filteredAds.length,
//         itemBuilder: (context, index) {
//           final ad = filteredAds[index];
//           final tag = 'fullmapView${ad.id}';
//           return SizedBox(
//             child: PieMenu(
//               onPressedWithDevice: (kind) {
//                 if (kind == PointerDeviceKind.mouse ||
//                     kind == PointerDeviceKind.touch) {
//                   handleDisplayedAction(ref, ad.id, context);
//                   ref.read(navigationService).pushNamedScreen(
//                     '${Routes.feedview}/${ad.id}',
//                     data: {'tag': tag, 'ad': ad},
//                   );
//                 }
//               },
//               actions: buildPieMenuActions(ref, ad, context),
//               child: Hero(
//                 tag: tag,
//                 child: Container(
//                   margin: const EdgeInsets.only(bottom: 0),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: AspectRatio(
//                     aspectRatio: 16 / 9,
//                     child: Stack(
//                       children: [
//                         Positioned.fill(
//                           child: Image.network(
//                             ad.images.isNotEmpty
//                                 ? ad.images[0]
//                                 : 'default_image_url',
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           left: 2,
//                           bottom: 2,
//                           child: Container(
//                             padding: const EdgeInsets.only(
//                                 top: 5, bottom: 5, right: 8, left: 8),
//                             decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.25),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '${NumberFormat.decimalPattern().format(ad.price)} ${ad.currency}',
//                                   style: AppTextStyles.interBold.copyWith(
//                                     fontSize: 18,
//                                     shadows: [
//                                       Shadow(
//                                         offset: const Offset(5.0, 5.0),
//                                         blurRadius: 10.0,
//                                         color: Colors.black.withOpacity(1),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Text(
//                                   ad.title,
//                                   style: AppTextStyles.interSemiBold.copyWith(
//                                     fontSize: 14,
//                                     shadows: [
//                                       Shadow(
//                                         offset: const Offset(5.0, 5.0),
//                                         blurRadius: 10.0,
//                                         color: Colors.black.withOpacity(1),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Text(
//                                   '${ad.city}, ${ad.street}',
//                                   style: AppTextStyles.interSemiBold.copyWith(
//                                     fontSize: 14,
//                                     shadows: [
//                                       Shadow(
//                                         offset: const Offset(5.0, 5.0),
//                                         blurRadius: 10.0,
//                                         color: Colors.black.withOpacity(1),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
