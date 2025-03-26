

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';

import '../../../state_managers/data/filter_provider.dart';
import '../../../state_managers/data/landing_page_provider.dart';
import 'filters_widget.dart';

import 'dart:ui' as ui;





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
        height: MediaQuery.of(context).size.height / 1.1,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/hero-section(3).jpg'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                                  
                          Container(
                            height: 194,
                            width: 1200,              
                          child: ClipRRect( 
                            borderRadius: BorderRadius.circular(16),
                               child: BackdropFilter(
                                  filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                                  child: Container(
                                    color: theme.adPopBackground.withOpacity(0.15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'BUY',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:FontWeight.bold),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        'RENT',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:FontWeight.bold),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        'SELL',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        'DEVELOPERS OFFERS',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  ref
                                                      .read(isLocationVisibleProvider
                                                          .notifier)
                                                      .state = true;
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Location',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      ref
                                                              .watch(
                                                                  selectedLocationProvider)
                                                              .isEmpty
                                                          ? 'All locations'
                                                          : ref.watch(
                                                              selectedLocationProvider),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Image.asset('assets/images/frame.png'),
                                              InkWell(
                                                onTap: () {
                                                  ref
                                                      .read(isPropertyVisibleProvider
                                                          .notifier)
                                                      .state = true;
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Property type',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      ref
                                                              .watch(
                                                                  selectedPropertyProvider)
                                                              .isEmpty
                                                          ? 'All property types'
                                                          : ref.watch(
                                                              selectedPropertyProvider),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Image.asset('assets/images/frame.png'),
                                              InkWell(
                                                onTap: () {
                                                  ref
                                                      .read(isPriceSelectedProvider
                                                          .notifier)
                                                      .state = true;
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Price range',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      ref
                                                              .watch(
                                                                  selectedPriceRangeProvider)
                                                              .isEmpty
                                                          ? 'Choose price range'
                                                          : ref.watch(
                                                              selectedPriceRangeProvider),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Image.asset('assets/images/frame.png'),
                                              InkWell(
                                                onTap: () {
                                                  ref
                                                      .read(
                                                          isSelectedMeterRangeProvider
                                                              .notifier)
                                                      .state = true;
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Meter range',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      ref
                                                              .watch(
                                                                  selectedMeterRangeProvider)
                                                              .isEmpty
                                                          ? 'Choose meter range'
                                                          : ref.watch(
                                                              selectedMeterRangeProvider),
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      ref
                                                          .read(filterProvider.notifier)
                                                          .applyFiltersFromCache(
                                                          ref.read(filterCacheProvider.notifier),ref);
                                                      ref.read(filterProvider.notifier).applyFilters(ref)
                                                      .whenComplete(() {
                                                        final data = ref.watch(filterCacheProvider);
                                                        print(data);
                                                      },);
                                                      String selectedFeedView = ref.read(
                                                          selectedFeedViewProvider); // Odczytaj wybrany widok
                                                      ref
                                                          .read(navigationService)
                                                          .pushNamedReplacementScreen(selectedFeedView);
                                                    },
                                                    child: Container(
                                                      height: 48,
                                                      width: 103,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                            Radius.circular(6),
                                                          ),
                                                          border: Border.all(
                                                              color:
                                                                  const Color.fromRGBO(
                                                                      200,
                                                                      200,
                                                                      200,
                                                                      1))),
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
                                                                  fontWeight:
                                                                      FontWeight.w500,
                                                                  color: Color.fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      1)),
                                                            ),
                                                          ],
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
                                                            BorderRadius.all(
                                                                Radius.circular(6)),
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1)),
                                                    child: const Center(
                                                      child: Icon(Icons.search,
                                                      color: Color.fromRGBO(35, 35, 35, 1),),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                                                          ),
                             ),
                            )
                        ],
                      ),
                      if (ref.watch(isLocationVisibleProvider))
                        const Positioned(
                            left: 0, child: LocationSearchWidget()),
                      if (ref.watch(isPropertyVisibleProvider))
                        const Positioned(left: 200, child: PropertyTypes()),
                      if (ref.watch(isPriceSelectedProvider))
                        const Positioned(left: 400, child: PriceRangeWidget()),
                      if (ref.watch(isSelectedMeterRangeProvider))
                        const Positioned(right: 0, child: MeterRangeWidget()),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
