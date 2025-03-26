import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/network_monitoring/network_home_page/network_home_new/screens/widgets/real_state_and_home_for_sale_card.dart';
import 'package:hously_flutter/state_managers/data/home_page/listing_provider.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'dart:ui';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';




class SavedSearchGridView extends ConsumerWidget {
  final bool isMobile;
  const SavedSearchGridView({super.key,this.isMobile = false});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final listingProvider = ref.watch(listingsProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    final scrollController = ScrollController();

    int crossAxisCount;
    if (screenWidth < 1170) {
      crossAxisCount = 1; // Tablet
    } else if (screenWidth < 1500) {
      crossAxisCount = 2;
    } else if (screenWidth < 1830) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 4;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listingProvider.when(
          data: (data) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final ad = data[index];
                final tag = 'fullSize${ad.id}-${UniqueKey().toString()}';
                return AspectRatio(
                  aspectRatio: 1,
                  child: PieMenu(
                    onPressedWithDevice: (kind) {
                      if (kind == PointerDeviceKind.mouse || kind == PointerDeviceKind.touch) {
                        handleDisplayedAction(ref, ad.id, context);
                        ref.read(navigationService).pushNamedScreen(
                          '${Routes.networkMonitoring}/${ad.id}',
                          data: {'tag': tag, 'ad': ad},
                        );
                      }
                    },            
                    actions: buildPieMenuActions(ref, ad, context),
                    child: Hero(
                      tag: tag,
                      child: RealStateAndHomeForSaleCard(
                      imageUrl: ad.images.last,
                      location: ad.city,
                      address: ad.state,
                      size: ad.squareFootage.toString(),
                      rooms: ad.rooms.toString(),
                      bath: ad.bathrooms.toString(),
                      price: ad.price.toString(),
                      isMobile: isMobile,
                    ),
                  ),
                  ),
                );
              },
            );
          },
          loading: () => SizedBox(
            height: 500, // Adjust height accordingly
            child: ShimmerAdvertisementGrid(
              scrollController: scrollController,
              crossAxisCount: crossAxisCount,
              scrollPhysics: const NeverScrollableScrollPhysics(),
            ),
          ),


          error: (error, stackTrace) => Center(
            child: Text(
              'Error loading data: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
