import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../state_managers/data/home_page/listing_provider.dart';
import '../../../theme/apptheme.dart';
import '../../loading/loading_widgets.dart';

// Define a StateProvider to manage the selected tab
final selectedTabProvider = StateProvider<String>((ref) => 'EXCLUSIVE OFFERS');

class ExclusiveOffersWidget extends ConsumerWidget {
  final double paddingDynamic;
  const ExclusiveOffersWidget({super.key, required this.paddingDynamic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the selected tab
    final selectedTab = ref.watch(selectedTabProvider);

    // Fetch listings based on the selected tab
    final listingProvider = ref.watch(listingsProvider);
    final dynamicVerticalPadding = paddingDynamic / 6;
    final scrollController = ScrollController();

    // Define the tabs and their associated data
    final tabs = ['EXCLUSIVE OFFERS', 'NEW LISTING', 'OPEN HOUSES', 'MOST VIEWED'];

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: dynamicVerticalPadding),
      child: SizedBox(
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingDynamic),
              child: Row(
                children: tabs.map((tab) {
                  return InkWell(
                    onTap: () {
                      // Update the selected tab using Riverpod's StateProvider
                      ref.read(selectedTabProvider.notifier).state = tab;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        tab,
                        style: TextStyle(
                          color: selectedTab == tab ? Colors.black : Colors.grey,
                          fontSize: 16,
                          fontWeight:
                          selectedTab == tab ? FontWeight.bold : FontWeight.normal,
                          decoration: selectedTab == tab
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
        
            // Cards Section
            Expanded(
              child: listingProvider.when(
                data: (adsList) {
                  // Example logic for filtering based on selected tab
                  final filteredAds = adsList.where((ad) {
                    if (selectedTab == 'EXCLUSIVE OFFERS') return true;
                    if (selectedTab == 'NEW LISTING') return ad.airConditioning;
                    if (selectedTab == 'OPEN HOUSES') return ad.balcony;
                    if (selectedTab == 'MOST VIEWED') return ad.elevator;
                    return false;
                  }).toList();
        
                  return ListView.separated(
                    controller: scrollController,
                    separatorBuilder: (context, index) => const SizedBox(width: 20),
                    itemCount: filteredAds.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final indexedAd = filteredAds[index];
                      final tag = 'recentlyView1-${indexedAd.id}';

                    if (index == 0) {
                      // Pierwszy element listy - dynamiczny padding
                      return SizedBox(width: paddingDynamic);
                    }
                    final ad = adsList[index]; // Przesuwamy indeksy, żeby zgadzały się z danymi
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
                                '${Routes.homepage}/${indexedAd.id}',
                                data: {'tag': tag, 'ad': indexedAd},
                              );
                            }
                          },
                          actions: buildPieMenuActions(ref, indexedAd, context),
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
            const SizedBox(height: 30),
        
            // Footer Link
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: paddingDynamic),
                child: TextButton(
                   onPressed: () {  }, child: const Text('View more exclusive offers →',
                  style: TextStyle(
                    color: Color.fromRGBO(35, 35, 35, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String location;
  final String address;
  final String size;
  final String rooms;
  final String bath;
  final String price;
  final bool isMobile;
  final WidgetRef ref;

  const PropertyCard({
    super.key,
    required this.imageUrl,
    required this.location,
    required this.address,
    required this.size,
    required this.rooms,
    required this.bath,
    required this.price,
    this.isMobile = false,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;

    return Container(
      width: isMobile ? 276 : 386,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
              const ShimmerPlaceholder(width: 0, height: 0),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text(
                  'No Image'.tr,
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconText(icon: Icons.square_foot, text: size),
                    IconText(icon: Icons.bed, text: rooms),
                    IconText(icon: Icons.bathtub, text: bath),
                  ],
                ),
                const SizedBox(height: 6),
                const Divider(color: Colors.black),
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
                      price,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
            size: 16,
            color: Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
