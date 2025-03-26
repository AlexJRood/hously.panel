// import 'dart:ui' as ui;
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:feedback/feedback.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:hously_flutter/error/custom_error_handler.dart';
// import 'package:hously_flutter/theme/apptheme.dart';
// import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
// import 'package:hously_flutter/const/route_constant.dart';
//
// import 'package:hously_flutter/data/design/design.dart';
// import 'package:hously_flutter/screens/feed/second_adview/pdf_generator.dart';
//
// import 'package:hously_flutter/state_managers/data/user_provider.dart';
// import 'package:hously_flutter/state_managers/services/navigation_service.dart';
// import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
// import 'package:hously_flutter/widgets/screens/chat/chat_pc.dart';
// import 'package:hously_flutter/widgets/screens/home_page/nearby_ads.dart';
// import 'package:hously_flutter/widgets/screens/home_page/similar_ads.dart';
// import 'package:intl/intl.dart';
//
// void copyToClipboard(BuildContext context, String listingUrl) {
//   Clipboard.setData(ClipboardData(text: listingUrl)).then((_) {
//   final snackBar = Customsnackbar().showSnackBar("Success",
//         "Link skopiowany do schowka!".tr, "success", () {
//       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     });
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   });
// }
//
// class SecondFeedPopFull extends ConsumerStatefulWidget {
//   final dynamic adFeedPop;
//   final String tagFeedPop;
//
//   const SecondFeedPopFull(
//       {super.key, required this.adFeedPop, required this.tagFeedPop});
//
//   @override
//   SecondFeedPopFullState createState() => SecondFeedPopFullState();
// }
//
// class SecondFeedPopFullState extends ConsumerState<SecondFeedPopFull> {
//   late String mainImageUrl;
//
//   final images = [];
//   var imgurls = [];
//   bool _isMapActivated = false; // Stan aktywacji mapy
//   LogicalKeyboardKey? pdfkey;
//   void _activateMap() {
//     if (!_isMapActivated) {
//       setState(() {
//         _isMapActivated =
//             true; // Zmienia stan na aktywny, co pozwala na interakcje z mapą
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     mainImageUrl =
//         widget.adFeedPop.images.isNotEmpty ? widget.adFeedPop.images[0] : '';
//     pdfkey = ref.watch(pedfKeyProvider);
//     _loadimg();
//   }
//
//   Future<void> _loadimg() async {
//     imgurls = widget.adFeedPop.images.whereType<String>().toList();
//     setState(() {
//       imgurls = imgurls;
//     });
//
//     print(imgurls);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final userAsyncValue = ref.watch(userProvider);
//     final isLoading = ref.watch(pdfGeneratorProvider);
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     double mainImageWidth = screenWidth * 0.525;
//     double mainImageHeight = mainImageWidth * (600 / 1200);
//     double pricePerSquareMeter =
//         widget.adFeedPop.price / widget.adFeedPop.squareFootage;
//     // Ustawienie maksymalnej i minimalnej szerokości ekranu
//     const double maxWidth = 1920;
//     const double minWidth = 480;
//     // Ustawienie maksymalnego i minimalnego rozmiaru czcionki
//     const double maxLogoSize = 30;
//     const double minLogoSize = 16;
//     // Obliczenie odpowiedniego rozmiaru czcionki
//     double logoSize = (screenWidth - minWidth) /
//             (maxWidth - minWidth) *
//             (maxLogoSize - minLogoSize) +
//         minLogoSize;
//     // Ograniczenie rozmiaru czcionki do zdefiniowanych minimum i maksimum
//     logoSize = logoSize.clamp(minLogoSize, maxLogoSize);
//
//     final customFormat = NumberFormat.decimalPattern('fr');
//     final formattedPrice = customFormat.format(widget.adFeedPop.price);
//     final theme = ref.watch(themeColorsProvider);
//     ScrollController _scrollcontroller = ScrollController();
//     return userAsyncValue.when(
//       data: (user) {
//         // String userId = user?.userId ?? '';
//         return KeyboardListener(
//           focusNode: FocusNode()..requestFocus(),
//           onKeyEvent: (KeyEvent event) {
//             // Handling Up and Down Arrow keys for scrolling
//             KeyBoardShortcuts()
//                 .handleKeyEvent(event, _scrollcontroller, 80, 100);
//             if (event.logicalKey == pdfkey && event is KeyDownEvent) {
//               ref
//                   .read(pdfGeneratorProvider.notifier)
//                   .generatePdf(widget.adFeedPop);
//             }
//           },
//           child: GestureDetector(
//             onVerticalDragUpdate: (details) {
//               // Check if the drag is downward
//               if (details.primaryDelta != null && details.primaryDelta! > 15) {
//                 ref.read(navigationService).beamPop();
//               }
//             },
//             child: Scaffold(
//               backgroundColor: Colors.transparent,
//               body: Stack(
//                 children: [
//                   // Ta część odpowiada za efekt rozmycia tła
//                   BackdropFilter(
//                     filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                     child: Container(
//                       color: theme.adPopBackground.withOpacity(0.85),
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                   ),
//                   // Obsługa dotknięcia w dowolnym miejscu aby zamknąć modal
//                   GestureDetector(
//                     onTap: () => ref.read(navigationService).beamPop(),
//                   ),
//                   // // Zawartość modalu
//                   Positioned(
//                     top: 20,
//                     left: 20,
//                     child: SizedBox(
//                       width: 150,
//                       height: screenHeight - 40,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.arrow_back_ios_rounded,
//                                 color: theme.popUpIconColor),
//                             onPressed: () =>
//                                 ref.read(navigationService).beamPop(),
//                           ),
//                           const Spacer(),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   Positioned(
//                     top: screenWidth * 0.035,
//                     left: screenWidth * 0.09,
//                     child: SizedBox(
//                       width: screenWidth * 0.9,
//                       height: screenHeight * 0.9,
//                       child: SingleChildScrollView(
//                         controller: _scrollcontroller,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     const SizedBox(height: 75),
//                                     Row(
//                                       children: [
//                                         Hero(
//                                           tag: widget.tagFeedPop,
//                                           child: GestureDetector(
//                                               onTap: () {
//                                                 ref
//                                                     .read(navigationService)
//                                                     .pushNamedScreen(
//                                                   Routes.fullImage,
//                                                   data: {
//                                                     'tag': widget.tagFeedPop,
//                                                     'images':
//                                                         widget.adFeedPop.images,
//                                                     'initialPage': widget
//                                                         .adFeedPop.images
//                                                         .indexOf(mainImageUrl),
//                                                   },
//                                                 );
//                                               },
//                                               child: ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 child: CachedNetworkImage(
//                                                   imageUrl: mainImageUrl,
//                                                   width: mainImageWidth,
//                                                   height: mainImageHeight,
//                                                   fit: BoxFit.cover,
//                                                   placeholder: (context, url) =>
//                                                       ShimmerPlaceholder(
//                                                           width: mainImageWidth,
//                                                           height:
//                                                               mainImageHeight),
//                                                   errorWidget:
//                                                       (context, url, error) =>
//                                                           Stack(
//                                                     children: [
//                                                       ShimmerPlaceholder(
//                                                           width: mainImageWidth,
//                                                           height:
//                                                               mainImageHeight),
//                                                       const Center(
//                                                         child: Material(
//                                                           color: Colors
//                                                               .transparent,
//                                                           child: Text(
//                                                             'no image found',
//                                                             style: TextStyle(
//                                                                 color:
//                                                                     Colors.red),
//                                                           ),
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               )),
//                                         ),
//                                       ],
//                                     ),
//                                     const SizedBox(height: 20),
//                                     SizedBox(
//                                       width: mainImageWidth,
//                                       height:
//                                           120, // Ensure the height is sufficient for both ListView scenarios
//                                       child: widget.adFeedPop.images.isNotEmpty
//                                           ? ListView.builder(
//                                               scrollDirection: Axis.horizontal,
//                                               itemCount: widget
//                                                   .adFeedPop.images.length,
//                                               itemBuilder: (context, index) {
//                                                 String imageUrl = widget
//                                                     .adFeedPop.images[index];
//                                                 return GestureDetector(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       mainImageUrl =
//                                                           imageUrl; // Update the main image on click
//                                                     });
//                                                   },
//                                                   child: Padding(
//                                                     padding: EdgeInsets.only(
//                                                       left: index == 0
//                                                           ? 0
//                                                           : 10.0, // No padding for the first image
//                                                       right: index ==
//                                                               widget
//                                                                       .adFeedPop
//                                                                       .images
//                                                                       .length -
//                                                                   1
//                                                           ? 0
//                                                           : 10.0, // No padding for the last image
//                                                     ),
//                                                     child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15), // Rounded edges
//                                                       child: CachedNetworkImage(
//                                                         imageUrl: imageUrl,
//                                                         width: 120,
//                                                         height: 120,
//                                                         fit: BoxFit.cover,
//                                                         placeholder: (context,
//                                                                 url) =>
//                                                             const ShimmerPlaceholder(
//                                                           width: 120,
//                                                           height: 120,
//                                                         ),
//                                                         errorWidget: (context,
//                                                                 url, error) =>
//                                                             Stack(
//                                                           children: [
//                                                             ClipRRect(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           15), // Rounded edges for shimmer
//                                                               child:
//                                                                   const ShimmerPlaceholder(
//                                                                 width: 120,
//                                                                 height: 120,
//                                                               ),
//                                                             ),
//                                                             const Center(
//                                                               child: Material(
//                                                                 color: Colors
//                                                                     .transparent,
//                                                                 child: Icon(
//                                                                     Icons.error,
//                                                                     color: Colors
//                                                                         .red),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             )
//                                           : ListView.builder(
//                                               scrollDirection: Axis.horizontal,
//                                               itemCount:
//                                                   10, // Show 10 placeholder items
//                                               itemBuilder: (context, index) {
//                                                 return Padding(
//                                                   padding: EdgeInsets.only(
//                                                     left: index == 0
//                                                         ? 0
//                                                         : 10.0, // No padding for the first item
//                                                     right: index == 9
//                                                         ? 0
//                                                         : 10.0, // No padding for the last item
//                                                   ),
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             15), // Rounded edges for placeholders
//                                                     child: const Stack(
//                                                       children: [
//                                                         ShimmerPlaceholder(
//                                                             width: 120,
//                                                             height: 120),
//                                                         Padding(
//                                                           padding:
//                                                               EdgeInsets.all(
//                                                                   50),
//                                                           child: Icon(
//                                                               Icons.error,
//                                                               color:
//                                                                   Colors.red),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                             ),
//                                     ),
//                                     const SizedBox(height: 20),
//                                   ],
//                                 ),
//                                 const SizedBox(width: 15),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       padding: EdgeInsets.only(
//                                           top: screenWidth * 0.08, bottom: 10),
//                                       height: mainImageWidth * 0.68,
//                                       width: screenWidth * 0.2,
//                                       child: SingleChildScrollView(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               '$formattedPrice ${widget.adFeedPop.currency}',
//                                               style: AppTextStyles.interBold
//                                                   .copyWith(
//                                                       fontSize: 18,
//                                                       color:
//                                                           theme.popUpIconColor),
//                                             ),
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                             Text(
//                                                 '${widget.adFeedPop.country}, ${widget.adFeedPop.city}, ${widget.adFeedPop.state}',
//                                                 style: AppTextStyles
//                                                     .interRegular
//                                                     .copyWith(
//                                                         fontSize: 16,
//                                                         color: theme
//                                                             .popUpIconColor)),
//                                             Text('${widget.adFeedPop.title}',
//                                                 style: AppTextStyles
//                                                     .interRegular
//                                                     .copyWith(
//                                                         fontSize: 16,
//                                                         color: theme
//                                                             .popUpIconColor)),
//                                             Text(
//                                                 'Opis: ${widget.adFeedPop.description}'
//                                                     .tr,
//                                                 style: AppTextStyles
//                                                     .interRegular
//                                                     .copyWith(
//                                                         fontSize: 16,
//                                                         color: theme
//                                                             .popUpIconColor)),
//                                             Text(
//                                                 'Powierzchnia: ${widget.adFeedPop.squareFootage} m²'
//                                                     .tr,
//                                                 style: AppTextStyles
//                                                     .interRegular
//                                                     .copyWith(
//                                                         fontSize: 16,
//                                                         color: theme
//                                                             .popUpIconColor)),
//                                             Text(
//                                                 'Liczba łazienek: ${widget.adFeedPop.bathrooms}'
//                                                     .tr,
//                                                 style: AppTextStyles
//                                                     .interRegular
//                                                     .copyWith(
//                                                         fontSize: 16,
//                                                         color: theme
//                                                             .popUpIconColor)),
//                                             Text(
//                                                 'Liczba pokoi: ${widget.adFeedPop.rooms}'
//                                                     .tr,
//                                                 style: AppTextStyles
//                                                     .interRegular
//                                                     .copyWith(
//                                                         fontSize: 16,
//                                                         color: theme
//                                                             .popUpIconColor)),
//                                             Text(
//                                                 'Piętro: ${widget.adFeedPop.floor}/${widget.adFeedPop.totalFloors}'
//                                                     .tr,
//                                                 style: AppTextStyles
//                                                     .interRegular
//                                                     .copyWith(
//                                                         fontSize: 16,
//                                                         color: theme
//                                                             .popUpIconColor)),
//                                             Text(
//                                                 'Forma własności: ${widget.adFeedPop.marketType}'
//                                                     .tr,
//                                                 style: AppTextStyles
//                                                     .interRegular
//                                                     .copyWith(
//                                                         fontSize: 16,
//                                                         color: theme
//                                                             .popUpIconColor)),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Center(
//                                       child: ElevatedButton.icon(
//                                         style: ButtonStyle(
//                                           backgroundColor:
//                                               MaterialStateProperty.all(
//                                                   Theme.of(context)
//                                                       .primaryColor),
//                                         ),
//                                         icon: Icon(
//                                           Icons.save,
//                                           color:
//                                               Theme.of(context).iconTheme.color,
//                                         ),
//                                         onPressed: () => ref
//                                             .read(pdfGeneratorProvider.notifier)
//                                             .generatePdf(widget.adFeedPop),
//                                         label: Text(
//                                           'Generate PDF',
//                                           style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .iconTheme
//                                                   .color),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 50,
//                             ),
//                             // Blue container
//                             Padding(
//                               padding: const EdgeInsets.only(right: 100),
//                               child: SimilarAds(
//                                 offerid: widget.adFeedPop.id.toString(),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 100,
//                             ),
//                             if (widget.adFeedPop.latitude != null ||
//                                 widget.adFeedPop.longitude != null) ...[
//                               NearbyAds(
//                                 offerId: widget.adFeedPop.id.toString(),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Positioned(
//                     top: 20,
//                     right: 20,
//                     child: SizedBox(
//                       width: 300,
//                       height: screenHeight - 40,
//                       child: Stack(
//                         children: [
//                           Column(
//                             children: [
//                               Align(
//                                 alignment: Alignment.topRight,
//                                 child: TextButton(
//                                   onPressed: () {
//                                     BetterFeedback.of(context).show(
//                                       (feedback) async {
//                                         // upload to server, share whatever
//                                         // for example purposes just show it to the user
//                                         // alertFeedbackFunction(
//                                         // context,
//                                         // feedback,
//                                         // );
//                                       },
//                                     );
//                                   },
//                                   child: Text(
//                                     'HOUSLY.AI',
//                                     style: AppTextStyles.houslyAiLogo.copyWith(
//                                         fontSize: logoSize,
//                                         color: theme.popUpIconColor),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 60,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Center(
//                       child: isLoading
//                           ? Dialog(
//                               backgroundColor: Theme.of(context).primaryColor,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     CircularProgressIndicator(
//                                       color: theme.popUpIconColor,
//                                     ),
//                                     const SizedBox(width: 20),
//                                     Text(
//                                       "Generating PDF...",
//                                       style: TextStyle(
//                                           color: Theme.of(context)
//                                               .iconTheme
//                                               .color),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : const SizedBox()),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//       loading: () => const CircularProgressIndicator(),
//       error: (error, stack) => Text('Błąd: $error'.tr),
//     );
//   }
// }
//
// extension ContextExtension on BuildContext {
//   void showSnackBar(String message) {
//     ScaffoldMessenger.of(this).removeCurrentSnackBar();
//     ScaffoldMessenger.of(this).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
// }
