import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/utils/middle_mouse_gesture.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/modules/ads_managment/utils/pie_menu.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:flutter/gestures.dart';


class VictoriaCardWidget extends ConsumerWidget {
  /// Model ogłoszenia – dostosuj do własnej klasy.
  final dynamic ad;

  /// Hero tag – unikatowe ID (np. 'ad-123').
  final String tag;

  /// Główny obrazek do wyświetlenia (URL).
  final String mainImageUrl;

  /// Czy ogłoszenie jest typu „Pro”.
  final bool isPro;

  /// Czy systemowe tło jest ciemne (np. theme brightness).
  final bool isDefaultDarkSystem;

  /// Kolor tła (np. jasne tło w trybie light).
  final Color color;

  /// Kolor tekstu w danym trybie (jasne/ciemne).
  final Color textColor;

  /// Kolor pola tekstowego (używany przy ciemnym motywie).
  final Color textFieldColor;

  /// Placeholder używany przez CachedNetworkImage w trakcie ładowania.
  /// Możesz tu przekazać np. dowolny widget shimmer.
  final Widget buildShimmerPlaceholder;

  /// Funkcja budująca listę akcji w PieMenu.
  /// Przykład: `buildPieMenuActions(ref, ad, context)`.
  final buildPieMenuActions;

  final double aspectRatio;
  final bool isMobile;

  const VictoriaCardWidget({
    Key? key,
    required this.ad,
    required this.tag,
    required this.mainImageUrl,
    required this.isPro,
    required this.isDefaultDarkSystem,
    required this.color,
    required this.textColor,
    required this.textFieldColor,
    required this.buildShimmerPlaceholder,
    required this.buildPieMenuActions,
    required this.aspectRatio,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = ref.read(navigationService).currentPath;

    return AspectRatio(
      aspectRatio: aspectRatio,
      child: MiddleClickDetector(
        onMiddleClick: () {
          debugPrint('Middle click detected!');
          // Wywołaj akcję dodania do browse list, tylko przy prawdziwym middle-clicku.
        },
        child: PieMenu(
          onPressedWithDevice: (kind) {
            if (kind == PointerDeviceKind.mouse || kind == PointerDeviceKind.touch) {
              ref.read(navigationService).pushNamedScreen(
                '$currentPath/${ad.id}',
                data: {'tag': tag, 'ad': ad},
              );
            }
          },
          actions: buildPieMenuActions,
          child: Hero(
            tag: tag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(isMobile ? 0 : 6),
                      color: const Color.fromRGBO(41, 41, 41, 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(isMobile ? 0 : 6)),
                            child: Image.network(
                              ad.images.first,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex:2,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${ad.street},',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(200, 200, 200, 1),
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${ad.city},',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(200, 200, 200, 1),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${ad.state}',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(200, 200, 200, 1),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${ad.title},',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (ad.squareFootage != null && ad.squareFootage.toString().trim().isNotEmpty) ...[
                                      IconText(icon: Icons.square_foot, text: '${ad.squareFootage} ㎡'),    
                                    ], 
        
                                    if (ad.rooms != null && ad.rooms.toString().trim().isNotEmpty) ...[
                                      const Text('  |  ', 
                                          style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      IconText(icon: Icons.bed, text: '${ad.rooms} Rooms'),
                                    ],
                                    
                                    if (ad.bathrooms != null && ad.bathrooms.toString().trim().isNotEmpty) ...[
                                      const Text('  |  ', 
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      IconText(icon: Icons.bathtub, text: '${ad.bathrooms} Bath'),
                                    ],
        
                                  ],
                                ),
                                const Divider(color: Color.fromRGBO(90, 90, 90, 1)),
                                const SizedBox(height: 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'FOR SALE',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                    '${NumberFormat.decimalPattern('fr').format(ad.price)} ${ad.currency}',
                                      style: AppTextStyles.interMedium22,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconText({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
