import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:intl/intl.dart';

class FiltersLandingPageMobile extends ConsumerStatefulWidget {
  const FiltersLandingPageMobile({super.key});

  @override
  FiltersLandingPageState createState() => FiltersLandingPageState();
}

class FiltersLandingPageState extends ConsumerState<FiltersLandingPageMobile> {
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
    double filterBarWidth = (screenWidth * 0.95);
    double filterBarHeigth = math.max(screenHeight * 0.4, 275);
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    final themecolors = ref.watch(themeColorsProvider);
    final filterPageColor = themecolors.filterPageColor;
    final currentthememode = ref.watch(themeProvider);

    final cursorcolor = Theme.of(context).primaryColor;
    final buttoncolor = Theme.of(context).primaryColor;
    final buttonTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorLight
        : themecolors.buttonTextColor;

    final textFieldColor =
        currentthememode == ThemeMode.system ? Colors.black : Colors.white;
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
                        const SizedBox(
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
                // height: filterBarHeigth,
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
                  mainAxisSize: MainAxisSize.min,
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
                                  prefixIcon: SvgPicture.asset(AppIcons.search,
                                      color:
                                          inputDecorationTheme.prefixIconColor),
                                  filled: inputDecorationTheme.filled,
                                  fillColor: inputDecorationTheme.fillColor,
                                  border: inputDecorationTheme.border,
                                  focusedBorder:
                                      inputDecorationTheme.focusedBorder,
                                  labelStyle: inputDecorationTheme.labelStyle!
                                      .copyWith(fontSize: 14),
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
    final colorScheme = Theme.of(context).colorScheme;

    final selectedBackgroundColor = colorScheme.primary;

    final unselectedBackgroundColor = currentthememode == ThemeMode.system
        ? Colors.white // Default color for system theme when not selected
        : currentthememode == ThemeMode.light
            ? Colors.white // Light mode background
            : AppColors.dark; // Dark mode background

    final selectedTextColor = currentthememode == ThemeMode.system
        ? Colors.white
        : colorScheme.onPrimary;

    final unselectedTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorDark
        : currentthememode == ThemeMode.light
            ? AppColors.textColorDark
            : AppColors.textColorLight;
    return ElevatedButton(
      onPressed: () {
        if (isSelected) {
          // Jeśli przycisk jest już zaznaczony, usuwamy filtr i aktualizujemy stan przycisku
          ref
              .read(filterButtonProvider.notifier)
              .updateFilter(filterKey, null); // Usuwamy stan przycisku
          ref
              .read(filterCacheProvider.notifier)
              .removeFilter(filterKey); // Usuwamy filtr
        } else {
          // Jeśli przycisk nie jest zaznaczony, dodajemy filtr i aktualizujemy stan przycisku
          ref
              .read(filterButtonProvider.notifier)
              .updateFilter(filterKey, filterValue);
          ref
              .read(filterCacheProvider.notifier)
              .addFilter(filterKey, filterValue);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? selectedBackgroundColor : unselectedBackgroundColor,
        foregroundColor: isSelected ? selectedTextColor : unselectedTextColor,
        side: isSelected
            ? null
            : BorderSide(
                color: colorScheme.primary), // Border for unselected button
      ),
      child: Text(text,
          style: TextStyle(
              color: isSelected ? selectedTextColor : unselectedTextColor)),
    );
  }
}

class EstateTypeFilterButton extends ConsumerWidget {
  final String text;
  final String filterKey;
  final String filterValue;

  const EstateTypeFilterButton({
    super.key,
    required this.text,
    required this.filterKey,
    required this.filterValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Pobieranie listy wybranych wartości dla danego klucza
    final List<String> selectedValues = List<String>.from(ref
        .watch(filterButtonProvider.select((state) => state[filterKey] ?? [])));
    final currentthememode = ref.watch(themeProvider); // Get current theme mode
    final isSelected = ref.watch(
      filterButtonProvider.select((state) => state[filterKey] == filterValue),
    );

    // Color scheme based on the selected Flex color scheme or default colors for system theme
    final colorScheme = Theme.of(context).colorScheme;

    final selectedBackgroundColor = currentthememode == ThemeMode.system
        ? Colors.blue // Default color for system theme when selected
        : currentthememode == ThemeMode.light
            ? colorScheme.primary // Flex color scheme for light mode
            : colorScheme.primary; // Flex color scheme for dark mode

    final unselectedBackgroundColor = currentthememode == ThemeMode.system
        ? Colors.white // Default color for system theme when not selected
        : currentthememode == ThemeMode.light
            ? Colors.white // Light mode background
            : AppColors.dark; // Dark mode background

    final selectedTextColor = currentthememode == ThemeMode.system
        ? Colors.white
        : colorScheme.onPrimary;

    final unselectedTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorDark
        : currentthememode == ThemeMode.light
            ? AppColors.textColorDark
            : AppColors.textColorLight;

    return ElevatedButton(
      onPressed: () {
        if (isSelected) {
          // Usuwamy wartość z listy, jeśli jest już zaznaczona
          selectedValues.remove(filterValue);
        } else {
          // Dodajemy wartość do listy, jeśli nie jest zaznaczona
          selectedValues.add(filterValue);
        }
        // Aktualizujemy stan przycisku filtrowania
        ref
            .read(filterButtonProvider.notifier)
            .updateFilter(filterKey, selectedValues);

        // Aktualizujemy zapytanie do serwera, przekazując listę jako ciąg wartości oddzielonych przecinkami
        ref
            .read(filterCacheProvider.notifier)
            .addFilter(filterKey, selectedValues.join(','));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? selectedBackgroundColor : unselectedBackgroundColor,
        foregroundColor: isSelected ? selectedTextColor : unselectedTextColor,
        side: isSelected
            ? null
            : BorderSide(
                color: colorScheme.outline), // Border for unselected button
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isSelected ? selectedTextColor : unselectedTextColor),
      ),
    );
  }
}

class AdditionalInfoFilterButton extends ConsumerWidget {
  final String text;
  final String filterKey;

  const AdditionalInfoFilterButton({
    super.key,
    required this.text,
    required this.filterKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Monitorujemy stan każdego przycisku filtrowania
    final isSelected = ref.watch(
        filterButtonProvider.select((state) => state[filterKey] ?? false));

    return ElevatedButton(
      onPressed: () {
        // Używamy ref.watch() lub ref.read() do pobrania aktualnego stanu i następnie go modyfikujemy
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        final currentState =
            ref.read(filterButtonProvider.notifier).state[filterKey] ?? false;
        final newState = !currentState;
        ref
            .read(filterButtonProvider.notifier)
            .updateFilter(filterKey, newState);

        // Jeśli przycisk jest zaznaczony (true), dodajemy filtr, w przeciwnym razie go usuwamy
        if (newState) {
          ref.read(filterCacheProvider.notifier).addFilter(filterKey, 'true');
        } else {
          ref.read(filterCacheProvider.notifier).removeFilter(filterKey);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        side: isSelected ? null : const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      child: Text(text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
    );
  }
}

class BuildTextField extends ConsumerWidget {
  const BuildTextField({
    required this.controller,
    required this.labelText,
    required this.filterKey,
    super.key,
  });
  final TextEditingController controller;
  final String labelText;
  final String filterKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    final themecolors = ref.watch(themeColorsProvider);
    ;
    final currentthememode = ref.watch(themeProvider);
    final textFieldColor =
        currentthememode == ThemeMode.system ? Colors.black : Colors.white;
    final cursorcolor = Theme.of(context).primaryColor;

    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 2, // Lekkie uniesienie dla efektu cienia
      child: SizedBox(
        height: 35.0, // Ustawienie wysokości na 35px
        child: TextField(
            controller: controller,
            onChanged: (value) {
              // Aktualizacja wartości w filterProvider
              ref
                  .read(filterCacheProvider.notifier)
                  .addFilter(filterKey, value);
            },
            style: AppTextStyles.interMedium.copyWith(
                fontSize: 14, color: textFieldColor), // Styl tekstu wpisywanego
            cursorColor: currentthememode == ThemeMode.system
                ? Colors.black
                : cursorcolor,
            decoration: InputDecoration(
              labelText: labelText,
              filled: inputDecorationTheme.filled,
              fillColor: inputDecorationTheme.fillColor,
              border: inputDecorationTheme.border,
              focusedBorder: inputDecorationTheme.focusedBorder,
              labelStyle:
                  inputDecorationTheme.labelStyle!.copyWith(fontSize: 14),
              floatingLabelStyle: inputDecorationTheme.floatingLabelStyle,
            )),
      ),
    );
  }
}

class BuildNumberField extends ConsumerWidget {
  const BuildNumberField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.filterKey,
  });

  final TextEditingController controller;
  final String labelText;
  final String filterKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = NumberFormat('#,###');

final themecolors=ref.watch(themeColorsProvider);
    final currentthememode = ref.watch(themeProvider);
    final textFieldColor = themecolors.textFieldColor;

    final cursorcolor = Theme.of(context).primaryColor;
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 2, // Lekkie uniesienie dla efektu cienia
      child: SizedBox(
        height: 35.0, // Ustawienie wysokości na 35px
        child: TextField(
          controller: controller,
          keyboardType:
              TextInputType.number, // Ustawienie klawiatury na numeryczną
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Dopuszcza tylko cyfry
            TextInputFormatter.withFunction((oldValue, newValue) {
              if (newValue.text.isEmpty) {
                return newValue.copyWith(text: '');
              }
              final int value = int.parse(newValue.text.replaceAll(',', ''));
              final String newText = formatter.format(value);
              return newValue.copyWith(
                text: newText,
                selection: TextSelection.collapsed(offset: newText.length),
              );
            }),
          ],
          style: AppTextStyles.interMedium.copyWith(
              fontSize: 14, color: textFieldColor), // Styl tekstu wpisywanego
          cursorColor:
              currentthememode == ThemeMode.system ? Colors.black : cursorcolor,
          decoration: InputDecoration(
            labelText: labelText,
            filled: inputDecorationTheme.filled,
            fillColor: inputDecorationTheme.fillColor,
            border: inputDecorationTheme.border,
            focusedBorder: inputDecorationTheme.focusedBorder,
            labelStyle: inputDecorationTheme.labelStyle!.copyWith(fontSize: 14),
            floatingLabelStyle: inputDecorationTheme.floatingLabelStyle,
          ),
          onChanged: (value) {
            // Usunięcie separatorów przed przekazaniem wartości
            final unformattedValue = value.replaceAll(',', '');
            ref
                .read(filterCacheProvider.notifier)
                .addFilter(filterKey, unformattedValue);
          },
        ),
      ),
    );
  }
}

class BuildDropdownButtonFormField extends ConsumerWidget {
  const BuildDropdownButtonFormField({
    super.key,
    this.currentValue,
    required this.items,
    required this.filterKey,
    required this.labelText,
  });
  final String? currentValue;
  final List<String> items;
  final String filterKey;
  final String labelText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentthememode = ref.watch(themeProvider);
    final textFieldColor =
        currentthememode == ThemeMode.system ? Colors.black : Colors.white;
    final colorScheme = Theme.of(context).colorScheme;
    final colorSchemecheck = ref.watch(colorSchemeProvider);

    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 2,
      child: SizedBox(
        height: 35.0,
        child: DropdownButtonFormField<String>(
          value: currentValue,
          style: TextStyle(
            color: currentthememode == ThemeMode.system
                ? AppColors.light
                : currentthememode == ThemeMode.light
                    ? AppColors.light
                    : AppColors.light,
          ),
          dropdownColor: currentthememode == ThemeMode.system
              ? AppColors.light
              : currentthememode == ThemeMode.light
                  ? AppColors.light
                  : AppColors.dark,
          focusColor: currentthememode == ThemeMode.system
              ? AppColors.light
              : currentthememode == ThemeMode.light
                  ? colorScheme.primary
                  : colorScheme.primary,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: AppTextStyles.interMedium14dark.copyWith(
                    color: currentthememode == ThemeMode.system
                        ? AppColors.textColorDark
                        : currentthememode == ThemeMode.light
                            ? AppColors.textColorDark
                            : AppColors.textColorLight,
                  )),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Aktualizacja stanu lokalnego za pomocą filterButtonProvider
            ref
                .read(filterButtonProvider.notifier)
                .updateFilter(filterKey, newValue);
            // Możliwe, że będziesz także chciał aktualizować filtry w FiltersLogicNotifier, jeśli jest używany
            ref
                .read(filterCacheProvider.notifier)
                .addFilter(filterKey, newValue);
          },
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: AppTextStyles.interMedium.copyWith(
              fontSize: 14,
              color: currentthememode == ThemeMode.system
                  ? AppColors.textColorDark
                  : currentthememode == ThemeMode.light
                      ? AppColors.textColorDark
                      : AppColors.textColorLight,
            ),
            floatingLabelStyle: TextStyle(
              color: colorSchemecheck == null &&
                      (currentthememode == ThemeMode.system ||
                          currentthememode == ThemeMode.dark)
                  ? textFieldColor
                  : colorScheme.primary,
            ),
            contentPadding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
            fillColor: currentthememode == ThemeMode.system
                ? AppColors.light
                : currentthememode == ThemeMode.light
                    ? AppColors.light
                    : AppColors.dark,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.black),
            ),
          ),
          isExpanded: true,
          iconSize: 24.0,
        ),
      ),
    );
  }
}
