import 'package:flutter/material.dart';
import 'package:hously_flutter/utils/pie_menu/network_monitoring.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/exclusive_offers_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:intl/intl.dart';


class RealStateAndHomeForSaleCard extends ConsumerWidget { // ✅ Poprawione
  final dynamic ad;
  final String keyTag;
  final bool isMobile;

  const RealStateAndHomeForSaleCard({
    super.key,
    required this.ad,
    required this.keyTag,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) { // ✅ Teraz poprawne

    return AspectRatio(
      aspectRatio: isMobile ? 1 : 1,
      child: PieMenu(
        onPressedWithDevice: (kind) {
          if (kind == PointerDeviceKind.mouse || kind == PointerDeviceKind.touch) {
            handleDisplayedActionNM(ref, ad.id, context);
            ref.read(navigationService).pushNamedScreen(
              '${Routes.networkMonitoring}/offer/${ad.id}',
              data: {'tag': keyTag, 'ad': ad},
            );
          }
        },
        actions: buildPieMenuActionsNM(ref, ad, context),
        child: Hero(
          tag: keyTag,
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
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    ad.address?.street != null ? 'street,' : '${ad.address!.street}, ',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(200, 200, 200, 1),
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    ad.address?.city != null ? 'city,' : '${ad.address!.city}, ',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(200, 200, 200, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    ad.address?.state != null ? 'state' : ad.address!.state,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(200, 200, 200, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
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
                              const SizedBox(height: 6),
                              const Divider(color: Color.fromRGBO(90, 90, 90, 1)),
                              const SizedBox(height: 6),
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
                                    style: const TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
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
    );
  }
}
