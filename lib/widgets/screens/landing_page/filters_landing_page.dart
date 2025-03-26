import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get/get.dart';
import 'package:hously_flutter/theme/apptheme.dart';

import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/filters_components.dart';

class FiltersLandingPage extends ConsumerStatefulWidget {
  const FiltersLandingPage({super.key});

  @override
  FilterLandingPageState createState() => FilterLandingPageState();
}

class FilterLandingPageState extends ConsumerState<FiltersLandingPage> {
  String selectedOfferType = '';

  late TextEditingController searchController;
  late TextEditingController searchRadiusController;
  late TextEditingController excludeController;
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;
  late TextEditingController minSquareFootageController;
  late TextEditingController maxSquareFootageController;
  late TextEditingController estateTypeController;
  late TextEditingController offerTypeController;
  late TextEditingController countryController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipcodeController;

  @override
  void initState() {
    super.initState();
    final filterNotifier = ref.read(filterProvider.notifier);

    searchController = TextEditingController(text: filterNotifier.searchQuery);
    searchRadiusController =
        TextEditingController(text: filterNotifier.searchQuery); //do poprawy
    excludeController =
        TextEditingController(text: filterNotifier.excludeQuery);
    minPriceController = TextEditingController(
        text: filterNotifier.filters['min_price']?.toString());
    maxPriceController = TextEditingController(
        text: filterNotifier.filters['max_price']?.toString());
    minSquareFootageController = TextEditingController(
        text: filterNotifier.filters['min_square_footage']?.toString());
    maxSquareFootageController = TextEditingController(
        text: filterNotifier.filters['max_square_footage']?.toString());
    estateTypeController =
        TextEditingController(text: filterNotifier.filters['estate_type']);
    streetController =
        TextEditingController(text: filterNotifier.filters['street']);
    cityController =
        TextEditingController(text: filterNotifier.filters['city']);
    stateController =
        TextEditingController(text: filterNotifier.filters['state']);
    zipcodeController =
        TextEditingController(text: filterNotifier.filters['zipcode']);
    offerTypeController =
        TextEditingController(text: filterNotifier.filters['offer_type']);
    countryController =
        TextEditingController(text: filterNotifier.filters['country']);
  }

  @override
  void dispose() {
    searchController.dispose();
    searchRadiusController.dispose();
    excludeController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    minSquareFootageController.dispose();
    maxSquareFootageController.dispose();
    estateTypeController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipcodeController.dispose();
    offerTypeController.dispose();
    countryController.dispose();
    super.dispose();
  }

  void setSelectedOfferType(String value) {
    setState(() {
      selectedOfferType = value;
      offerTypeController.text = value; // Aktualizacja kontrolera tekstu
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double dynamicBoxHeight = 15;
    double dynamicBoxHeightGroup = 12;
    double dynamicBoxHeightGroupSmall = 10;
    double dynamiSpacerBoxWidth = 10;
    double filterBarWidth = math.max(screenWidth * 0.5, 350);
    double filterBarHeigth = math.max(screenHeight * 0.25, 300);

    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    final themecolors = ref.watch(themeColorsProvider);
    final filterPageColor = themecolors.filterPageColor;
    final currentthememode = ref.watch(themeProvider);
    final cursorcolor = Theme.of(context).primaryColor;
    final buttoncolor = Theme.of(context).primaryColor;
    final buttonTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorLight
        : themecolors.buttonTextColor;

    final textFieldColor = currentthememode == ThemeMode.system
        ? Colors.black
        : currentthememode == ThemeMode.light
            ? Colors.black
            : Colors.white;
    return Column(
      children: [
        SizedBox(
          width: filterBarWidth,
          child: Row(
            children: [
              ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 10, sigmaY: 10), // Adjust the blur intensity
                  child: Container(
                    padding: const EdgeInsets.only(
                        bottom: 10, top: 15, left: 25, right: 25),
                    decoration: BoxDecoration(
                      color: filterPageColor,
                      //  gradient: BackgroundGradients.oppacityGradient50,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child:  Row(
                      children: [
                        FilterButton(
                          text: 'Na sprzedaż'.tr,
                          filterValue: 'sell',
                          filterKey: 'offer_type',
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FilterButton(
                          text: 'Na wynajem'.tr,
                          filterValue: 'rent',
                          filterKey: 'offer_type',
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
        Center(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 10, sigmaY: 10), // Adjust the blur intensity
              child: Container(
                width: filterBarWidth,
                height: filterBarHeigth,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: filterPageColor,
                  // gradient: BackgroundGradients.oppacityGradient50,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          // Rozszerzony TextField z białym tłem i zaokrąglonymi rogami
                          child: Material(
                            borderRadius: BorderRadius.circular(
                                30.0), // Zaokrąglenie rogów
                            elevation: 2, // Lekkie uniesienie dla efektu cienia
                            child: SizedBox(
                              height:
                                  35.0, // Ograniczenie wysokości do 35 pikseli
                              child: TextField(
                                controller: searchController,
                                style: AppTextStyles.interMedium14dark
                                    .copyWith(color: textFieldColor),
                                cursorColor:
                                    currentthememode == ThemeMode.system
                                        ? Colors.black
                                        : cursorcolor,
                                decoration: InputDecoration(
                                  labelText: 'Wyszukaj'.tr,
                                  prefixIcon: Icon(Icons.search,
                                      color:
                                          inputDecorationTheme.prefixIconColor),
                                  filled: inputDecorationTheme.filled,
                                  fillColor: inputDecorationTheme.fillColor,
                                  border: inputDecorationTheme.border,
                                  focusedBorder:
                                      inputDecorationTheme.focusedBorder,
                                  labelStyle: inputDecorationTheme.labelStyle,
                                  floatingLabelStyle:
                                      inputDecorationTheme.floatingLabelStyle,
                                ),
                                onChanged: (value) => ref
                                    .read(filterCacheProvider.notifier)
                                    .setSearchQuery(value),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: dynamicBoxHeightGroupSmall),
                         Expanded(
                          child: SizedBox(
                            child: BuildDropdownButtonFormField(
                              currentValue: null,
                              items:  [
                                'Mieszkanie'.tr,
                                'Kawalerka'.tr,
                                'Apartament',
                                'Dom jednorodzinny'.tr,
                                'Bliźniak'.tr,
                                'Szeregowiec'.tr,
                                'Inwestycje'.tr,
                                'Działki'.tr,
                                'Lokale użytkowe'.tr,
                                'Hale i magazyny'.tr,
                                'Pokoje'.tr,
                                'Garaże'.tr,
                              ],
                              labelText: 'Rodzaj nieruchomości'.tr,
                              filterKey: 'estate_type',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: dynamicBoxHeightGroupSmall),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: BuildTextField(
                                controller: countryController,
                                labelText: 'Kraj'.tr,
                                filterKey: 'country',
                              ),
                            ),
                            SizedBox(width: dynamiSpacerBoxWidth),
                            Expanded(
                              child: BuildTextField(
                                controller: cityController,
                                labelText: 'Miasto'.tr,
                                filterKey: 'city',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: dynamicBoxHeightGroupSmall),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: BuildNumberField(
                                  controller: minSquareFootageController,
                                  labelText: 'Metraż od'.tr,
                                  filterKey: 'min_square_footage',
                                ),
                              ),
                              SizedBox(width: dynamiSpacerBoxWidth),
                              Expanded(
                                child: BuildNumberField(
                                  controller: maxSquareFootageController,
                                  labelText: 'Metraż do'.tr,
                                  filterKey:
                                      'max_square_footage', // Klucz używany do aktualizacji wartości w filterProvider
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: dynamicBoxHeightGroup),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: BuildNumberField(
                                  controller: minPriceController,
                                  labelText: 'Cena od'.tr,
                                  filterKey:
                                      'min_price', // Klucz używany do aktualizacji wartości w filterProvider
                                ),
                              ),
                              SizedBox(
                                  width:
                                      dynamiSpacerBoxWidth), // Odstęp pomiędzy polami
                              Expanded(
                                child: BuildNumberField(
                                  controller: maxPriceController,
                                  labelText: 'Cena do'.tr,
                                  filterKey:
                                      'max_price', // Klucz używany do aktualizacji wartości w filterProvider
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: dynamicBoxHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .read(filterProvider.notifier)
                                .applyFiltersFromCache(
                                    ref.read(filterCacheProvider.notifier),ref);
                            ref.read(filterProvider.notifier).applyFilters(ref);
                            String selectedFeedView = ref.read(
                                selectedFeedViewProvider); // Odczytaj wybrany widok
                            ref
                                .read(navigationService)
                                .pushNamedReplacementScreen(selectedFeedView);
                          },
                         
                          
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttoncolor,
                              foregroundColor:
                                  Colors.white, // Kolor tekstu przycisku
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 10, bottom: 10),
                              textStyle: const TextStyle(fontSize: 18),
                            ),
                            child: Text(
                              'Zastosuj filtry'.tr,
                              style: TextStyle(
                                color: buttonTextColor,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final filterButtonProvider =
    StateNotifierProvider<FilterButtonNotifier, Map<String, dynamic>>((ref) {
  return FilterButtonNotifier();
});

class FilterButtonNotifier extends StateNotifier<Map<String, dynamic>> {
  FilterButtonNotifier() : super({});
  void updateFilter(String key, dynamic value) {
    state = {...state, key: value};
  }

  void updateRangeFilter(String key, RangeValues values) {
    state = {...state, key: values};
  }

  void clearUiFilters() {
    state = {};
  }
}

class FilterButton extends ConsumerWidget {
  final String text;
  final String filterKey;
  final String filterValue;

  const FilterButton({
    super.key,
    required this.text,
    required this.filterKey,
    required this.filterValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentthememode = ref.watch(themeProvider); // Get current theme mode
    final isSelected = ref.watch(
      filterButtonProvider.select((state) => state[filterKey] == filterValue),
    );

    // Color scheme based on the selected Flex color scheme or default colors for system theme
    final colorScheme = Theme.of(context).primaryColor;

    final unselectedBackgroundColor = currentthememode == ThemeMode.system
        ? Colors.white // Default color for system theme when not selected
        : currentthememode == ThemeMode.light
            ? Colors.white // Light mode background
            : AppColors.dark; // Dark mode background

    final selectedTextColor = currentthememode == ThemeMode.system
        ? Colors.white
        : currentthememode == ThemeMode.light
            ? AppColors.textColorLight
            : AppColors.textColorDark;

    final unselectedTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorDark
        : currentthememode == ThemeMode.light
            ? AppColors.textColorDark
            : AppColors.textColorLight;

    return ElevatedButton(
      onPressed: () {
        if (isSelected) {
          ref.read(filterButtonProvider.notifier).updateFilter(filterKey, null);
          ref.read(filterCacheProvider.notifier).removeFilter(filterKey);
        } else {
          ref
              .read(filterButtonProvider.notifier)
              .updateFilter(filterKey, filterValue);
          ref
              .read(filterCacheProvider.notifier)
              .addFilter(filterKey, filterValue);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? colorScheme : unselectedBackgroundColor,
        foregroundColor: isSelected ? selectedTextColor : unselectedTextColor,
        side: isSelected
            ? null
            : BorderSide(color: colorScheme), // Border for unselected button
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isSelected ? selectedTextColor : unselectedTextColor),
      ),
    );
  }
}
