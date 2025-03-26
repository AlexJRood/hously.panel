import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/drad_scroll_widget.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:hously_flutter/data/design/design.dart';
import '../../../state_managers/data/home_page/listing_provider.dart';

// Define a StateProvider to manage the selected tab
final selectedTabProvider = StateProvider<String>((ref) => 'EXCLUSIVE OFFERS');

class ExclusiveOffersWidget extends ConsumerWidget {
  const ExclusiveOffersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);
    final listingProvider = ref.watch(listingsProvider);
    final tabs = [
      'EXCLUSIVE OFFERS',
      'NEW LISTING',
      'OPEN HOUSES',
      'MOST VIEWED'
    ];
    final scrollController = ScrollController();

    return SizedBox(
      height: 490,
      child: Column(
        children: [
          // Tabs Section
          SizedBox(
            height: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final tab = tabs[index];
                  return InkWell(
                    onTap: () {
                      // Update the selected tab using Riverpod's StateProvider
                      ref.read(selectedTabProvider.notifier).state = tab;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        tab,
                        style: AppTextStyles.libreCaslonHeading.copyWith(
                          color:
                              selectedTab == tab ? Colors.black : Colors.grey,
                          fontSize: selectedTab == tab ? 18 : 16,
                          fontWeight: selectedTab == tab
                              ? FontWeight.bold
                              : FontWeight.normal,
                          decoration: selectedTab == tab
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Cards Section
          Expanded(
            child: listingProvider.when(
              data: (adsList) {
                // Filter ads based on the selected tab
                final filteredAds = adsList.where((ad) {
                  if (selectedTab == 'EXCLUSIVE OFFERS') return true;
                  if (selectedTab == 'NEW LISTING') return ad.airConditioning;
                  if (selectedTab == 'OPEN HOUSES') return ad.balcony;
                  if (selectedTab == 'MOST VIEWED') return ad.jacuzzi;
                  return false;
                }).toList();

                return Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ListView.separated(
                    controller: scrollController,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: filteredAds.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final ad = filteredAds[index];
                      final tag = 'recentlyView7-${ad.id}';
                      return DragScrollView(
                        controller: scrollController,
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
                            child: BuildPropertyCard(
                              imageUrl: ad.images.last,
                              location: ad.city,
                              address: ad.state,
                              size: ad.squareFootage.toString(),
                              rooms: ad.rooms.toString(),
                              bath: ad.bathrooms.toString(),
                              price: ad.price.toString(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const SizedBox(),
              error: (error, stackTrace) => Center(
                child: Text(
                  'Error loading data: $error',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),

          // Footer Link
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  'View more exclusive offers →',
                  style: TextStyle(
                    color: Color.fromRGBO(35, 35, 35, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildPropertyCard extends StatelessWidget {
  final String imageUrl;
  final String location;
  final String address;
  final String size;
  final String rooms;
  final String bath;
  final String price;

  const BuildPropertyCard({
    super.key,
    required this.imageUrl,
    required this.location,
    required this.address,
    required this.size,
    required this.rooms,
    required this.bath,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BuildIconText(icon: Icons.square_foot, text: size),
                    BuildIconText(icon: Icons.bed, text: rooms),
                    BuildIconText(icon: Icons.bathtub, text: bath),
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

class BuildIconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const BuildIconText({
    super.key,
    required this.icon,
    required this.text,
  });

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
