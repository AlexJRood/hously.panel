import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/ads_managment/filter_provider.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import '../../../utils/currency_config.dart';

// Globalna zmienna do zarządzania motywem
final excludeFavoritesProvider = StateProvider<bool>((ref) => false);
final excludeHideProvider = StateProvider<bool>((ref) => false);
final excludeDisplayedProvider = StateProvider<bool>((ref) => false);

class ViewSettingsPage extends ConsumerStatefulWidget {
  final Offset? buttonPosition;
  const ViewSettingsPage({super.key, this.buttonPosition});

  @override
  ViewSettingsPopState createState() => ViewSettingsPopState();
}

class ViewSettingsPopState extends ConsumerState<ViewSettingsPage> {
  late TextEditingController searchController;
  late TextEditingController excludeController;
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;
  bool _excludeFavorites = false;
  bool _excludeHide = false;
  bool _excludeDisplayed = false;

  @override
  void initState() {
    super.initState();
    final filterNotifier = ref.read(filterProvider.notifier);
    searchController = TextEditingController(text: filterNotifier.searchQuery);
    excludeController =
        TextEditingController(text: filterNotifier.excludeQuery);
    minPriceController = TextEditingController(
        text: filterNotifier.filters['min_price']?.toString());
    maxPriceController = TextEditingController(
        text: filterNotifier.filters['max_price']?.toString());
  }

  @override
  void dispose() {
    searchController.dispose();
    excludeController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    _excludeFavorites = ref.watch(excludeFavoritesProvider);
    _excludeHide = ref.watch(excludeHideProvider);
    _excludeDisplayed = ref.watch(excludeDisplayedProvider);

    // Watch the selected currency state
    final selectedCurrency = ref.watch(currencyProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Hero(
            tag: 'CoToMaRobic-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag 
            child: Padding(
              padding: widget.buttonPosition != null
                  ? EdgeInsets.only(
                      left: widget.buttonPosition!.dx,
                      top: widget.buttonPosition!.dy)
                  : EdgeInsets.only(
                      left: screenWidth * 0.1, top: screenHeight * 0.05),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  width: screenWidth * 0.15 - 30 >= 250 ? 250 : 250,
                  height: screenHeight * 0.3 >= 450 ? 450 : 450,
                  padding: const EdgeInsets.all(20),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Material(
                                    color: Colors.transparent,
                                    child: Text('Waluta'.tr,
                                        style: AppTextStyles.interRegular14
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color))),
                                const Spacer(),
                                DropdownButton<String>(
                                  dropdownColor:
                                      Theme.of(context).iconTheme.color,
                                  value: selectedCurrency,
                                  onChanged: (String? newValue) {
                                    ref
                                        .read(currencyProvider.notifier)
                                        .setCurrency(newValue!);
                                    ref
                                        .read(filterCacheProvider.notifier)
                                        .setSelectedCurrency(newValue);
                                    ref
                                        .read(filterProvider.notifier)
                                        .applyFiltersFromCache(
                                            ref.read(
                                                filterCacheProvider.notifier),
                                            ref);
                                  },
                                  items: <String>[
                                    'PLN',
                                    'EUR',
                                    'USD',
                                    'GBP',
                                    'CZK'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          if (isUserLoggedIn) ...[
                            Material(
                              color: Colors.transparent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Polubione'.tr,
                                      style: AppTextStyles.interRegular14),
                                  const Spacer(),
                                  Switch(
                                    value: _excludeFavorites,
                                    onChanged: (value) {
                                      ref
                                          .read(
                                              excludeFavoritesProvider.notifier)
                                          .state = value;
                                      ref
                                          .read(filterCacheProvider.notifier)
                                          .addFilter('exclude_favorites',
                                              value ? 'true' : 'false');
                                      // ref.read(filterProvider.notifier).applyFilters();
                                      ref
                                          .read(filterProvider.notifier)
                                          .applyFiltersFromCache(
                                              ref.read(
                                                  filterCacheProvider.notifier),
                                              ref);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Ukryte'.tr,
                                      style: AppTextStyles.interRegular14),
                                  const Spacer(),
                                  Switch(
                                    value: _excludeHide,
                                    onChanged: (value) {
                                      ref
                                          .read(excludeHideProvider.notifier)
                                          .state = value;
                                      ref
                                          .read(filterCacheProvider.notifier)
                                          .addFilter('exclude_hide',
                                              value ? 'true' : 'false');
                                      // ref.read(filterProvider.notifier).applyFilters();
                                      ref
                                          .read(filterProvider.notifier)
                                          .applyFiltersFromCache(
                                              ref.read(
                                                  filterCacheProvider.notifier),
                                              ref);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Wyświetlone'.tr,
                                      style: AppTextStyles.interRegular14),
                                  const Spacer(),
                                  Switch(
                                    value: _excludeDisplayed,
                                    onChanged: (value) {
                                      ref
                                          .read(
                                              excludeDisplayedProvider.notifier)
                                          .state = value;
                                      ref
                                          .read(filterCacheProvider.notifier)
                                          .addFilter('exclude_displayed',
                                              value ? 'true' : 'false');
                                      // ref.read(filterProvider.notifier).applyFilters();
                                      ref
                                          .read(filterProvider.notifier)
                                          .applyFiltersFromCache(
                                              ref.read(
                                                  filterCacheProvider.notifier),
                                              ref);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
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
