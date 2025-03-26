import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/network_monitoring/components/cards/real_state_and_home_for_sale_card.dart';
import 'package:hously_flutter/state_managers/data/home_page/listing_provider.dart';
import 'package:hously_flutter/network_monitoring/state_managers/search_page/filters_provider.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';

class RealStateAndHomeForSaleGridView extends ConsumerWidget {
  final bool isMobile;
  const RealStateAndHomeForSaleGridView({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingProvider = ref.watch(networkMonitoringFilterProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    final scrollController = ScrollController();
    int crossAxisCount;
    if (screenWidth < 700) {
      crossAxisCount = 1;
    } else if (screenWidth < 1028) {
      crossAxisCount = 2; // Tablet
    } else if (screenWidth < 1415) {
      crossAxisCount = 3;
    } else if (screenWidth < 1745) {
      crossAxisCount = 4;
    } else {
      crossAxisCount = 5;
    }



    return Padding(
      padding: EdgeInsets.all(isMobile ? 0 : 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 0.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Real Estate & Homes For Sale',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '345 results',
                      style: TextStyle(
                          color: Color.fromRGBO(145, 145, 145, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              if (!isMobile)
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sort by:',
                      style: TextStyle(
                          color: Color.fromRGBO(145, 145, 145, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 32,
                      width: 165,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.transparent,
                          border: Border.all(
                              color: const Color.fromRGBO(200, 200, 200, 1))),
                      child: const Center(
                        child: Text(
                          'Price (Highest - Lowest)',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                )
            ],
          ),
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
                  // if (index == 0) {
                  //   // Pierwszy element listy - dynamiczny padding
                  //   return const SizedBox();
                  // }
                  final ad = data[index];
                  final tag = 'networkAd${ad.id}-${UniqueKey().toString()}';

                  return RealStateAndHomeForSaleCard(
                    ad: ad,
                    keyTag: tag,
                    isMobile: isMobile,
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
      ),
    );
  }
}
