import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/language/values.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/ads_managment/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/modules/landing_page/landing_page_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/modules/ads_managment/filter_provider.dart';

class HeaderWidget extends ConsumerWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);

    return InkWell(
      onTap: () {
        ref.read(isLocationVisibleProvider.notifier).state = false;
        ref.read(isPropertyVisibleProvider.notifier).state = false;
        ref.read(isPriceSelectedProvider.notifier).state = false;
        ref.read(isSelectedMeterRangeProvider.notifier).state = false;
      },
      child: Container(
        height: 1000,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/hero-section(3).jpg'),
                fit: BoxFit.cover)),
        child: InkWell(
          onTap: () {
            ref.read(isLocationVisibleProvider.notifier).state = false;
            ref.read(isPropertyVisibleProvider.notifier).state = false;
            ref.read(isPriceSelectedProvider.notifier).state = false;
            ref.read(isSelectedMeterRangeProvider.notifier).state = false;
          },
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 40),
                      child: Column(
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                              'Connecting you to the perfect property – Effortlessly!',
                              style: AppTextStyles.libreCaslonHeading.copyWith(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColorLight, //),
                              )),
                          Text(
                            'Whether you\'re buying, selling, or renting, our dedicated team is here to make the process seamless, stress-free, and tailored to your needs.',
                            style: AppTextStyles.interMedium14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: theme.adPopBackground.withOpacity(0.15),
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'BUY',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      'RENT',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      'SELL',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      'DEVELOPER OFFERS',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: locations.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final location = locations[index];

                                      // Determine the subtitle based on the title
                                      String subtitle;
                                      if (location['title'] == 'Location') {
                                        subtitle = ref
                                            .watch(selectedLocationProvider)
                                            .isEmpty
                                            ? 'All locations'
                                            : ref.watch(selectedLocationProvider);
                                      } else if (location['title'] ==
                                          'Property type') {
                                        subtitle = ref
                                            .watch(selectedPropertyProvider)
                                            .isEmpty
                                            ? 'All property types'
                                            : ref.watch(selectedPropertyProvider);
                                      } else if (location['title'] ==
                                          'Price range') {
                                        subtitle = ref
                                            .watch(selectedPriceRangeProvider)
                                            .isEmpty
                                            ? 'Choose price range'
                                            : ref.watch(selectedPriceRangeProvider);
                                      } else if (location['title'] ==
                                          'Meter range') {
                                        subtitle = ref
                                            .watch(selectedMeterRangeProvider)
                                            .isEmpty
                                            ? 'Choose meter range'
                                            : ref.watch(selectedMeterRangeProvider);
                                      } else {
                                        subtitle = location['subtitle'] ?? '';
                                      }

                                      return InkWell(
                                        onTap: () {
                                          final String title = location['title'] ?? '';
                                          final isLocation = title == 'Location';
                                          final isProperty = title == 'Property type';
                                          final isPrice = title == 'Price range';
                                          final isMeter = title == 'Meter range';

                                          final currentState = isLocation
                                              ? ref.read(isLocationVisibleProvider)
                                              : isProperty
                                              ? ref.read(isPropertyVisibleProvider)
                                              : isPrice
                                              ? ref.read(isPriceSelectedProvider)
                                              : ref.read(isSelectedMeterRangeProvider);

                                          if (currentState) {
                                            // Close if already open
                                            if (isLocation) ref.read(isLocationVisibleProvider.notifier).state = false;
                                            if (isProperty) ref.read(isPropertyVisibleProvider.notifier).state = false;
                                            if (isPrice) ref.read(isPriceSelectedProvider.notifier).state = false;
                                            if (isMeter) ref.read(isSelectedMeterRangeProvider.notifier).state = false;
                                          } else {
                                            // Close all others first
                                            ref.read(isLocationVisibleProvider.notifier).state = false;
                                            ref.read(isPropertyVisibleProvider.notifier).state = false;
                                            ref.read(isPriceSelectedProvider.notifier).state = false;
                                            ref.read(isSelectedMeterRangeProvider.notifier).state = false;

                                            // Open the selected one
                                            if (isLocation) ref.read(isLocationVisibleProvider.notifier).state = true;
                                            if (isProperty) ref.read(isPropertyVisibleProvider.notifier).state = true;
                                            if (isPrice) ref.read(isPriceSelectedProvider.notifier).state = true;
                                            if (isMeter) ref.read(isSelectedMeterRangeProvider.notifier).state = true;
                                          }
                                        },
                                        child: ListTile(
                                          title: Text(
                                            location['title'] ?? '',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            subtitle,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          trailing: location['imagePath'] != null
                                              ? Image.asset(location['imagePath']!)
                                              : const SizedBox(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          ref
                                              .read(filterProvider.notifier)
                                              .applyFiltersFromCache(
                                              ref.read(
                                                  filterCacheProvider.notifier),
                                              ref);
                                          ref
                                              .read(filterProvider.notifier)
                                              .applyFilters(ref)
                                              .whenComplete(
                                                () {
                                              final data =
                                              ref.watch(filterCacheProvider);
                                              print(data);
                                            },
                                          );
                                          String selectedFeedView = ref.read(
                                              selectedFeedViewProvider);
                                          ref
                                              .read(navigationService)
                                              .pushNamedReplacementScreen(
                                              selectedFeedView);
                                        },
                                        child: Container(
                                          height: 48,
                                          width: 103,
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(6),
                                              ),
                                              border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      200, 200, 200, 1))),
                                          child: const Center(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                ),
                                                Text(
                                                  'Filter',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      height: 48,
                                      width: 48,
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                          color: Color.fromRGBO(255, 255, 255, 1)),
                                      child: const Center(
                                        child: Icon(
                                          Icons.search,
                                          color: Color.fromRGBO(35, 35, 35, 1),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}