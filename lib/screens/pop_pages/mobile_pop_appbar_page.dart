import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/screens/pop_pages/view_settings_page.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/currency_config.dart';

Set<String> _selected = {'/view'};
final selectedFeedViewMobileProvider =
    selectedFeedViewProvider; // Domyślnie ustawione na '/feedview'
final excludeFavoritesMobileProvider = excludeFavoritesProvider;
final excludeHideMobileProvider = excludeHideProvider;
final excludeDisplayedMobileProvider = excludeDisplayedProvider;

class MobilePopAppBarPage extends ConsumerStatefulWidget {
  const MobilePopAppBarPage({super.key});

  @override
  MobilePopAppBarState createState() => MobilePopAppBarState();
}

class MobilePopAppBarState extends ConsumerState<MobilePopAppBarPage> {
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

  void updateSelected(Set<String> newSelection) {
    setState(() {
      _selected = newSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenPadding = screenWidth / 430 * 15;
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    _excludeFavorites = ref.watch(excludeFavoritesProvider);
    _excludeHide = ref.watch(excludeHideProvider);
    _excludeDisplayed = ref.watch(excludeDisplayedProvider);
    final selectedCurrency = ref.watch(currencyProvider);

    // Oblicz proporcję szerokości
    // double widthRatio = screenWidth / 1920.0;

    // Oblicz szerokość dla dynamicznego SizedBox
    //  double dynamicSizedBoxWidth = screenWidth * 0.5;
    //  double dynamicSizedBoxHeight = screenHeight * 0.5;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // Ta część odpowiada za efekt rozmycia tła
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            // Obsługa dotknięcia w dowolnym miejscu aby zamknąć modal
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
            ),
            // Zawartość modalu
            Hero(
              tag: 'MobilePopAppBar',
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      EdgeInsets.only(right: screenPadding, left: screenPadding),
                  child: Column(
                    children: [
                      const Spacer(),
                       ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                        child: Container(
                          width: screenWidth - (screenPadding * 2),
                          height: screenHeight * 0.75,
                          padding: EdgeInsets.all(screenPadding),
                          child:BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                        child:  SingleChildScrollView(
                              child: _selected.contains('/view')
                                  ? const BuildSearchView()
                                  : BuildSettingsView(
                                      selectedCurrency: selectedCurrency,
                                      excludeDisplayed: _excludeDisplayed,
                                      excludeFavorites: _excludeFavorites,
                                      excludeHide: _excludeHide,
                                      isUserLoggedIn: isUserLoggedIn,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenPadding,
                      ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(13.0),
                        child: Container(
                          width: screenWidth - screenPadding * 2,
                          height: 42,
                          padding: const EdgeInsets.all(5),
                          child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SegmentedButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                          if (states
                                              .contains(MaterialState.selected)) {
                                            return Colors.white;
                                          }
                                          return AppColors.light;
                                        },
                                      ),
                                      padding: MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 0),
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith<Color>(
                                        (states) {
                                          if (states
                                              .contains(MaterialState.selected)) {
                                            return Colors.black.withOpacity(0.35);
                                          }
                                          return Colors.transparent;
                                        },
                                      ),
                                      side: MaterialStateProperty.all<BorderSide>(
                                        BorderSide.none,
                                      ),
                                    ),
                                    multiSelectionEnabled: false,
                                    selected: _selected,
                                    onSelectionChanged: updateSelected,
                                    segments: <ButtonSegment<String>>[
                                      ButtonSegment(
                                        label: Text(
                                          'Widok'.tr,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: _selected.contains('/view')
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        value: '/view',
                                        icon: Icon(
                                          Icons.check,
                                          color: _selected.contains('/view')
                                              ? Colors.white
                                              : Colors.transparent,
                                        ),
                                      ),
                                      ButtonSegment(
                                        label: Text(
                                          'Ustawienia'.tr,
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight:
                                                _selected.contains('/settings')
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        value: '/settings',
                                        icon: Icon(
                                          Icons.check,
                                          color: _selected.contains('/settings')
                                              ? Colors.white
                                              : Colors.transparent,
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
                      const Spacer(),
                    ],
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

class BuildSettingsView extends ConsumerWidget {
  const BuildSettingsView({
    super.key,
    required this.selectedCurrency,
    required this.isUserLoggedIn,
    required this.excludeFavorites,
    required this.excludeHide,
    required this.excludeDisplayed,
  });

  final String selectedCurrency;
  final bool isUserLoggedIn;
  final bool excludeFavorites;
  final bool excludeHide;
  final bool excludeDisplayed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // DropdownButton do wyboru waluty
        Material(
          color: Colors.transparent,
          child: Row(
            children: [
              Text('Waluta'.tr, style: AppTextStyles.interRegular14),
              const Spacer(),
              DropdownButton<String>(
                value: selectedCurrency,
                onChanged: (String? newValue) {
                  ref.read(currencyProvider.notifier).setCurrency(newValue!);
                  ref
                      .read(filterCacheProvider.notifier)
                      .setSelectedCurrency(newValue);
                  ref.read(filterProvider.notifier).applyFiltersFromCache(
                      ref.read(filterCacheProvider.notifier), ref);
                },
                items: <String>['PLN', 'EUR', 'USD', 'GBP', 'CZK']
                    .map<DropdownMenuItem<String>>((String value) {
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
                Text('Polubione'.tr, style: AppTextStyles.interRegular),
                const Spacer(),
                Switch(
                  value: excludeFavorites,
                  onChanged: (value) {
                    // Aktualizowanie stanu providera
                    ref.read(excludeFavoritesProvider.notifier).state = value;
                    // Zastosuj filtry z nowym stanem
                    ref.read(filterCacheProvider.notifier).addFilter(
                        'exclude_favorites', value ? 'true' : 'false');
                    ref.read(filterProvider.notifier).applyFilters(ref);
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
                Text('Ukryte'.tr, style: AppTextStyles.interRegular),
                const Spacer(),
                Switch(
                  value: excludeHide,
                  onChanged: (value) {
                    // Aktualizowanie stanu providera
                    ref.read(excludeHideProvider.notifier).state = value;

                    // Zastosuj filtry z nowym stanem
                    ref
                        .read(filterCacheProvider.notifier)
                        .addFilter('exclude_hide', value ? 'true' : 'false');
                    ref.read(filterProvider.notifier).applyFilters(ref);
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
                Text('Wyświetlone'.tr, style: AppTextStyles.interRegular),
                const Spacer(),
                Switch(
                  value: excludeDisplayed,
                  onChanged: (value) {
                    // Aktualizowanie stanu providera
                    ref.read(excludeDisplayedProvider.notifier).state = value;

                    // Zastosuj filtry z nowym stanem
                    ref.read(filterCacheProvider.notifier).addFilter(
                        'exclude_displayed', value ? 'true' : 'false');
                    ref.read(filterProvider.notifier).applyFilters(ref);
                  },
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class BuildSearchView extends ConsumerWidget {
  const BuildSearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Text(
            'Wybierz widok wyszukiwania'.tr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: buttonSearchBar,
          onPressed: () {
            ref.read(selectedFeedViewMobileProvider.notifier).state =
                Routes.mapView;
            ref.read(navigationService).pushNamedScreen(Routes.mapView);
          },
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  width: 320,
                  height: 180,
                  child: Image.asset('assets/images/map_view.webp'),
                ),
                const SizedBox(height: 10),
                Text(
                  'Mapa'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: buttonSearchBar,
          onPressed: () {
            ref.read(selectedFeedViewMobileProvider.notifier).state =
                Routes.feedView;
            ref.read(navigationService).pushNamedScreen(Routes.feedView);
          },
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  width: 320,
                  height: 180,
                  child: Image.asset('assets/images/feed_view.webp'),
                ),
                const SizedBox(
                    height:
                        10), // Dodaj trochę przestrzeni między obrazem a tekstem
                Text(
                  'Widok siatki'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: buttonSearchBar,
          onPressed: () {
            ref.read(selectedFeedViewMobileProvider.notifier).state =
                Routes.fullSize;
            ref.read(navigationService).pushNamedScreen(Routes.fullSize);
          },
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  width: 320,
                  height: 180,
                  child: Image.asset('assets/images/full_size_view.webp'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Fill size',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        ElevatedButton(
          style: buttonSearchBar,
          onPressed: () {
            ref.read(selectedFeedViewMobileProvider.notifier).state =
                Routes.fullmap;
            ref.read(navigationService).pushNamedScreen(Routes.fullmap);
          },
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  width: 320,
                  height: 180,
                  child: Image.asset('assets/images/map_view.webp'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'full mapa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: buttonSearchBar,
          onPressed: () {
            ref.read(selectedFeedViewMobileProvider.notifier).state =
                Routes.listview;
            ref.read(navigationService).pushNamedScreen(Routes.listview);
          },
          child: Material(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  width: 320,
                  height: 180,
                  child: Image.asset('assets/images/full_size_view.webp'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'List view',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
