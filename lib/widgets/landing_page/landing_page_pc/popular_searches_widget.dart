import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../state_managers/data/home_page/listing_provider.dart';
import 'exclusive_offers_widget.dart';

class PopularSearchesWidget extends ConsumerWidget {
  final double paddingDynamic;
  const PopularSearchesWidget({super.key, required this.paddingDynamic});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final recentlyViewedAdsAsyncValue = ref.watch(listingsProvider);
    final dynamicVerticalPadding = paddingDynamic / 3;
    final scrollController = ScrollController();

    return Container(
        color: const Color.fromRGBO(255, 255, 255, 1),
        height: 600,
        child:  Padding(
        padding: EdgeInsets.symmetric(vertical: dynamicVerticalPadding),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingDynamic),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'POPULAR SEARCHES',
                    style: TextStyle(
                      color: Color.fromRGBO(35, 35, 35, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Color.fromRGBO(35, 35, 35, 1),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 24,
                        color: Color.fromRGBO(35, 35, 35, 1),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: recentlyViewedAdsAsyncValue.when(
                data: (adsList) {
                  return ListView.separated(
                    controller: scrollController,
                      separatorBuilder: (context, index) => const SizedBox(width: 10,),
                      itemCount: adsList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                    if (index == 0) {
                      // Pierwszy element listy - dynamiczny padding
                      return SizedBox(width: paddingDynamic);
                    }
                    final ad = adsList[index - 1]; // Przesuwamy indeksy, żeby zgadzały się z danymi
                    final tag = 'recentlyViewed4-${ad.id}';

                        return GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            scrollController.jumpTo(
                              scrollController.offset - details.delta.dx,
                            );
                          },
                          child: PieMenu(
                            onPressedWithDevice: (kind) {
                              if (kind == PointerDeviceKind.mouse ||
                                  kind == PointerDeviceKind.touch) {
                                ref.read(navigationService).pushNamedScreen(
                                  '${Routes.homepage}/${ad.id}',
                                  data: {'tag': tag, 'ad': ad},
                                );
                              }
                            },
                            actions: buildPieMenuActions(ref, ad, context),
                            child: Hero(
                              tag: tag,
                              child: PropertyCard(
                                imageUrl: ad.images.last,
                                location: ad.city,
                                address: ad.state,
                                size: ad.squareFootage.toString(),
                                rooms: ad.rooms.toString(),
                                bath: ad.bathrooms.toString(),
                                price: ad.price.toString(),
                                ref: ref,
                              ),
                            ),
                          ),
                        );
                      },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Text(
                    'Error loading data: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
