import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/filterslider/filterslider.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/autocompletion.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/provider/autocompletion_provider.dart';

import '../../widgets/filters_components.dart';

class FiltersPagePopPc extends ConsumerStatefulWidget {
  const FiltersPagePopPc({super.key});

  @override
  FiltersPagePopPcState createState() => FiltersPagePopPcState();
}

class FiltersPagePopPcState extends ConsumerState<FiltersPagePopPc> {
  String selectedOfferType = ''; 

  late TextEditingController searchController;
  late TextEditingController searchRadiusController;
  late TextEditingController excludeController;
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;
  late TextEditingController minPricePerMeterController;
  late TextEditingController maxPricePerMeterController;
  late TextEditingController minRoomsController;
  late TextEditingController maxRoomsController;
  late TextEditingController minBathroomsController;
  late TextEditingController maxBathroomsController;
  late TextEditingController minSquareFootageController;
  late TextEditingController maxSquareFootageController;
  late TextEditingController minLotSizeController;
  late TextEditingController maxLotSizeController;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController currencyController;
  late TextEditingController estateTypeController;
  late TextEditingController buildingTypeController;
  late TextEditingController countryController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController zipcodeController;
  late TextEditingController propertyFormController;
  late TextEditingController marketTypeController;
  late TextEditingController offerTypeController;
  late ScrollController scrollController;


  @override
  void initState() {
    super.initState();
    final filterNotifier = ref.read(filterCacheProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final filterCache = ref.read(filterCacheProvider);
        if (!filterCache.containsKey('filters')) {
          print('Error: filterCache does not contain "filters".');
          return;
        }
        final filters = filterCache['filters'];
        if (filters is! Map || !filters.containsKey('estate_type')) {
          print('Error: "filters" does not contain "estate_type".');
          return;
        }
        final estateType = filters['estate_type'];
        if (estateType is! String) {
          print('Error: "estate_type" is not a String.');
          return;
        }
        final List<String> selectedValues = List<String>.from(ref
            .watch(filterButtonProvider.select((state) => state[estateType] ?? [])));
        selectedValues.add(estateType);
        ref.read(filterButtonProvider.notifier).updateFilter('estate_type', selectedValues);
        ref.read(filterCacheProvider.notifier).addFilter('estate_type', selectedValues.join(','));
      } catch (e) {
        print('error: $e');
      }
    });

    searchController = TextEditingController(text: filterNotifier.searchQuery);
    searchRadiusController =
        TextEditingController(text: filterNotifier.searchQuery); //do poprawy
    excludeController =
        TextEditingController(text: filterNotifier.excludeQuery);
    minPriceController = TextEditingController(
        text: filterNotifier.filters['min_price']?.toString());
    maxPriceController = TextEditingController(
        text: filterNotifier.filters['max_price']?.toString());
    minPricePerMeterController = TextEditingController(
        text: filterNotifier.filters['min_price_per_meter']?.toString());
    maxPricePerMeterController = TextEditingController(
        text: filterNotifier.filters['max_price_per_meter']?.toString());
    minRoomsController = TextEditingController(
        text: filterNotifier.filters['min_rooms']?.toString());
    maxRoomsController = TextEditingController(
        text: filterNotifier.filters['max_rooms']?.toString());
    minBathroomsController = TextEditingController(
        text: filterNotifier.filters['min_bathrooms']?.toString());
    maxBathroomsController = TextEditingController(
        text: filterNotifier.filters['max_bathrooms']?.toString());
    minSquareFootageController = TextEditingController(
        text: filterNotifier.filters['min_square_footage']?.toString());
    maxSquareFootageController = TextEditingController(
        text: filterNotifier.filters['max_square_footage']?.toString());
    minLotSizeController = TextEditingController(
        text: filterNotifier.filters['min_lot_size']?.toString());
    maxLotSizeController = TextEditingController(
        text: filterNotifier.filters['max_lot_size']?.toString());
    titleController =
        TextEditingController(text: filterNotifier.filters['title']);
    descriptionController =
        TextEditingController(text: filterNotifier.filters['description']);
    currencyController =
        TextEditingController(text: filterNotifier.filters['currency']);
    estateTypeController =
        TextEditingController(text: filterNotifier.filters['estate_type']);
    buildingTypeController =
        TextEditingController(text: filterNotifier.filters['building_type']);
    streetController =
        TextEditingController(text: filterNotifier.filters['street']);
    cityController =
        TextEditingController(text: filterNotifier.filters['city']);
    stateController =
        TextEditingController(text: filterNotifier.filters['state']);
    zipcodeController =
        TextEditingController(text: filterNotifier.filters['zipcode']);
    propertyFormController =
        TextEditingController(text: filterNotifier.filters['property_form']);
    marketTypeController =
        TextEditingController(text: filterNotifier.filters['market_type']);
    offerTypeController =
        TextEditingController(text: filterNotifier.filters['offer_type']);
    countryController =
        TextEditingController(text: filterNotifier.filters['country']);
    scrollController = ScrollController();

  }

  @override
  void dispose() {
    searchController.dispose();
    searchRadiusController.dispose();
    excludeController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    minPricePerMeterController.dispose();
    maxPricePerMeterController.dispose();
    minRoomsController.dispose();
    maxRoomsController.dispose();
    minBathroomsController.dispose();
    maxBathroomsController.dispose();
    minSquareFootageController.dispose();
    maxSquareFootageController.dispose();
    minLotSizeController.dispose();
    maxLotSizeController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    currencyController.dispose();
    estateTypeController.dispose();
    buildingTypeController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipcodeController.dispose();
    propertyFormController.dispose();
    marketTypeController.dispose();
    offerTypeController.dispose();
    countryController.dispose();
    scrollController.dispose();
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
    final currentCountry = ref.watch(filterButtonProvider)['country'];
    final model =
        ref.watch(myTextFieldViewModelProvider.notifier); // Watch the provider
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double dynamicBoxHeight = 20;
    double dynamicBoxHeightGroup = 12;
    double dynamicBoxHeightGroupSmall = 10;
    double dynamiSpacerBoxWidth = 15;
    double inputWidth = math.max(screenWidth * 0.25, 170);
    final colorScheme = ref.watch(colorSchemeProvider);
    final themecolors = ref.watch(themeColorsProvider);
    final iconColor = Theme.of(context).iconTheme.color;
    final currentthememode = ref.watch(themeProvider);
    final buttonTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorLight
        : themecolors.buttonTextColor;
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        // Check if the pressed key matches the stored pop key
        if (event.logicalKey == ref.read(popKeyProvider) &&
            event is KeyDownEvent) {
          if (Navigator.canPop(context)) {
            ref.read(navigationService).beamPop();
          }
        }
        KeyBoardShortcuts().handleKeyEvent(event, scrollController, 100, 100);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.85),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            GestureDetector(onTap: () {
                Navigator.of(context).pop();
              model.setLoading(false);
            }),
            Center(
              child: Hero(
                tag: 'searchBar-7',
                child: GestureDetector(
                  onTap: () {
                    model.setLoading(false);
                  },
                  child: ClipRRect(   
                    borderRadius: BorderRadius.circular(15.0),    
                    child: Container(
                      width: math.max(screenWidth * 0.6, 450),
                      height: math.max(screenHeight * 0.91, 400),
                      padding: const EdgeInsets.all(10),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                      child:  ClipRRect(
                          child: Stack(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(top: dynamiSpacerBoxWidth + 70),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ScrollbarTheme(
                                        data: ScrollbarThemeData(
                                          thumbColor: MaterialStateProperty.all(
                                              Colors.white.withOpacity(0.5)),
                                          thickness: MaterialStateProperty.all(6.0),
                                          radius: const Radius.circular(10.0),
                                        ),
                                        child: Scrollbar(
                                          controller: scrollController,
                                          thumbVisibility: true,
                                          thickness: 6.0,
                                          radius: const Radius.circular(10.0),
                                          trackVisibility: true,
                                          interactive: true,
                                          child: SingleChildScrollView(
                                            controller: scrollController,
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                children: [
                                                  Wrap(
                                                    spacing:
                                                        dynamicBoxHeightGroupSmall,
                                                    runSpacing:
                                                        dynamicBoxHeightGroupSmall,
                                                    runAlignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        children: [
                                                          Material(
                                                            color:
                                                                Colors.transparent,
                                                            child: Text(
                                                                'Typ oferty'.tr,
                                                                style: AppTextStyles
                                                                    .interSemiBold
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        color:
                                                                            buttonTextColor)),
                                                          ),
                                                        ],
                                                      ),
                                                      FilterButton(
                                                        text: 'Na sprzedaż'.tr,
                                                        filterValue: 'sell',
                                                        filterKey: 'offer_type',
                                                      ),
                                                      FilterButton(
                                                        text: 'Na wynajem'.tr,
                                                        filterValue: 'rent',
                                                        filterKey: 'offer_type',
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: dynamicBoxHeight),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        children: [
                                                          Material(
                                                            color:
                                                                Colors.transparent,
                                                            child: Text(
                                                                'Lokalizacja'.tr,
                                                                style: AppTextStyles
                                                                    .interSemiBold
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        color:
                                                                            buttonTextColor)),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              dynamicBoxHeightGroupSmall),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: BuildTextField(
                                                              controller:
                                                                  countryController,
                                                              labelText: 'Kraj'.tr,
                                                              filterKey: 'country',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  dynamiSpacerBoxWidth),
                                                          Expanded(
                                                            child: BuildTextField(
                                                              controller:
                                                                  cityController,
                                                              labelText:
                                                                  'Miasto'.tr,
                                                              filterKey: 'city',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  dynamiSpacerBoxWidth),
                                                          Expanded(
                                                            child: BuildTextField(
                                                              controller:
                                                                  stateController,
                                                              labelText:
                                                                  'Województwo'.tr,
                                                              filterKey: 'state',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              dynamicBoxHeightGroupSmall),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: BuildTextField(
                                                              controller:
                                                                  streetController,
                                                              labelText: 'Ulica'.tr,
                                                              filterKey: 'street',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  dynamiSpacerBoxWidth),
                                                          SizedBox(
                                                            width: 150,
                                                            child: BuildTextField(
                                                              controller:
                                                                  zipcodeController,
                                                              labelText:
                                                                  'Kod pocztowy'.tr,
                                                              filterKey: 'zip_code',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  dynamiSpacerBoxWidth),
                                                          SizedBox(
                                                            width: 100,
                                                            child: BuildTextField(
                                                              controller:
                                                                  searchRadiusController,
                                                              labelText: '+ 0km',
                                                              filterKey: 'city',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: dynamicBoxHeight),
                                                  Wrap(
                                                    spacing:
                                                        dynamicBoxHeightGroupSmall,
                                                    runSpacing:
                                                        dynamicBoxHeightGroupSmall,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: Text(
                                                                  'Rodzaj nieruchomości'
                                                                      .tr,
                                                                  style: AppTextStyles
                                                                      .interSemiBold
                                                                      .copyWith(
                                                                          fontSize:
                                                                              18,
                                                                          color:
                                                                              buttonTextColor))),
                                                        ],
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text: 'Mieszkanie'.tr,
                                                        filterValue: 'Flat',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text: 'Kawalerka'.tr,
                                                        filterValue: 'Studio',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      const EstateTypeFilterButton(
                                                        text: 'Apartament',
                                                        filterValue: 'Apartment',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text:
                                                            'Dom jednorodzinny'.tr,
                                                        filterValue: 'House',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text: 'Bliźniak'.tr,
                                                        filterValue: 'Twin house',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text: 'Szeregowiec'.tr,
                                                        filterValue: 'Row house',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text: 'Inwestycje'.tr,
                                                        filterValue: 'Invest',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text: 'Działki'.tr,
                                                        filterValue: 'Lot',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text: 'Lokale użytkowe'.tr,
                                                        filterValue: 'Commercial',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text: 'Hale i magazyny'.tr,
                                                        filterValue: 'Warehouse',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text: 'Pokoje'.tr,
                                                        filterValue: 'Room',
                                                        filterKey: 'estate_type',
                                                      ),
                                                      EstateTypeFilterButton(
                                                        text: 'Garaże'.tr,
                                                        filterValue: 'Garage',
                                                        filterKey: 'estate_type',
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: dynamicBoxHeight),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Material(
                                                        color: Colors.transparent,
                                                        child: Text('Filtry'.tr,
                                                            style: AppTextStyles
                                                                .interSemiBold
                                                                .copyWith(
                                                                    fontSize: 18,
                                                                    color:
                                                                        buttonTextColor)),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          dynamicBoxHeightGroupSmall),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      BuildNumberField(
                                                                    controller:
                                                                        minSquareFootageController,
                                                                    labelText:
                                                                        'Metraż od'
                                                                            .tr,
                                                                    filterKey:
                                                                        'min_square_footage',
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        dynamiSpacerBoxWidth),
                                                                Expanded(
                                                                  child:
                                                                      BuildNumberField(
                                                                    controller:
                                                                        maxSquareFootageController,
                                                                    labelText:
                                                                        'Metraż do'
                                                                            .tr,
                                                                    filterKey:
                                                                        'max_square_footage',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    dynamicBoxHeightGroup),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      BuildNumberField(
                                                                    controller:
                                                                        minPriceController,
                                                                    labelText:
                                                                        'Cena od'
                                                                            .tr,
                                                                    filterKey:
                                                                        'min_price',
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        dynamiSpacerBoxWidth),
                                                                Expanded(
                                                                  child:
                                                                      BuildNumberField(
                                                                    controller:
                                                                        maxPriceController,
                                                                    labelText:
                                                                        'Cena do'
                                                                            .tr,
                                                                    filterKey:
                                                                        'max_price',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    dynamicBoxHeightGroup),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      BuildNumberField(
                                                                    controller:
                                                                        minPricePerMeterController,
                                                                    labelText:
                                                                        'Cena za metr od'
                                                                            .tr,
                                                                    filterKey:
                                                                        'min_price_per_meter',
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        dynamiSpacerBoxWidth),
                                                                Expanded(
                                                                  child:
                                                                      BuildNumberField(
                                                                    controller:
                                                                        maxPricePerMeterController,
                                                                    labelText:
                                                                        'Cena za metr do'
                                                                            .tr,
                                                                    filterKey:
                                                                        'max_price_per_meter',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    dynamicBoxHeightGroup),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      BuildNumberField(
                                                                    controller:
                                                                        minRoomsController,
                                                                    labelText:
                                                                        'Rok budowy od'
                                                                            .tr,
                                                                    filterKey:
                                                                        'min_build_year',
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        dynamiSpacerBoxWidth),
                                                                Expanded(
                                                                  child:
                                                                      BuildNumberField(
                                                                    controller:
                                                                        maxRoomsController,
                                                                    labelText:
                                                                        'Rok budowy do'
                                                                            .tr,
                                                                    filterKey:
                                                                        'max_build_year',
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    dynamicBoxHeightGroup),
                                                            Wrap(
                                                              alignment:
                                                                  WrapAlignment
                                                                      .start,
                                                              spacing:
                                                                  dynamicBoxHeightGroupSmall,
                                                              runSpacing:
                                                                  dynamicBoxHeightGroupSmall,
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child: Text(
                                                                          'Liczba pokoi'
                                                                              .tr,
                                                                          style: AppTextStyles.interMedium.copyWith(
                                                                              color:
                                                                                  buttonTextColor,
                                                                              fontSize:
                                                                                  14)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const FilterButton(
                                                                  text: '1',
                                                                  filterValue: '1',
                                                                  filterKey:
                                                                      'rooms',
                                                                ),
                                                                const FilterButton(
                                                                  text: '2',
                                                                  filterValue: '2',
                                                                  filterKey:
                                                                      'rooms',
                                                                ),
                                                                const FilterButton(
                                                                  text: '3',
                                                                  filterValue: '3',
                                                                  filterKey:
                                                                      'rooms',
                                                                ),
                                                                const FilterButton(
                                                                  text: '4',
                                                                  filterValue: '4',
                                                                  filterKey:
                                                                      'rooms',
                                                                ),
                                                                const FilterButton(
                                                                  text: '5',
                                                                  filterValue: '5',
                                                                  filterKey:
                                                                      'rooms',
                                                                ),
                                                                const FilterButton(
                                                                  text: '6',
                                                                  filterValue: '6',
                                                                  filterKey:
                                                                      'rooms',
                                                                ),
                                                                const FilterButton(
                                                                  text: '7+',
                                                                  filterValue: '7+',
                                                                  filterKey:
                                                                      'rooms',
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    dynamicBoxHeightGroup),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Text(
                                                                      'floors',
                                                                      style: AppTextStyles
                                                                          .interMedium
                                                                          .copyWith(
                                                                              color:
                                                                                  buttonTextColor,
                                                                              fontSize:
                                                                                  14)),
                                                                ),
                                                                const FilterSlider(
                                                                    filterKey:
                                                                        'floors')
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            dynamiSpacerBoxWidth *
                                                                3,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          IntrinsicHeight(
                                                            child: Row(
                                                              children: [
                                                                FilterButton(
                                                                  text:
                                                                      'Rynek pierwotny'
                                                                          .tr,
                                                                  filterValue:
                                                                      'new',
                                                                  filterKey:
                                                                      'market_type',
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        dynamicBoxHeightGroup),
                                                                FilterButton(
                                                                  text:
                                                                      'Rynek wtórny'
                                                                          .tr,
                                                                  filterValue:
                                                                      'use',
                                                                  filterKey:
                                                                      'market_type',
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  dynamicBoxHeightGroup),
                                                          SizedBox(
                                                            width: inputWidth,
                                                            child:
                                                                BuildDropdownButtonFormField(
                                                              currentValue:
                                                                  currentCountry,
                                                              items: [
                                                                'Blok'.tr,
                                                                'Apartamentowiec'
                                                                    .tr,
                                                                'Kamienica'.tr,
                                                                'Wieżowiec'.tr,
                                                                'Loft',
                                                                'Szeregowiec'.tr,
                                                                'Plomba'.tr
                                                              ],
                                                              labelText:
                                                                  'Rodzaj zabudowy'
                                                                      .tr,
                                                              filterKey:
                                                                  'building_type',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  dynamicBoxHeightGroup),
                                                          SizedBox(
                                                            width: inputWidth,
                                                            child:
                                                                BuildDropdownButtonFormField(
                                                              currentValue:
                                                                  currentCountry,
                                                              items: [
                                                                'Gazowe'.tr,
                                                                'Elektryczne'.tr,
                                                                'Miejskie'.tr,
                                                                'Pompa ciepła'.tr,
                                                                'Olejowe'.tr,
                                                                'Nie podono informacji'
                                                                    .tr,
                                                                'Wszystkie'.tr
                                                              ],
                                                              labelText:
                                                                  'Rodzaj ogrzewania'
                                                                      .tr,
                                                              filterKey:
                                                                  'heater_type',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  dynamicBoxHeightGroup),
                                                          SizedBox(
                                                            width: inputWidth,
                                                            child:
                                                                BuildDropdownButtonFormField(
                                                              currentValue:
                                                                  currentCountry,
                                                              items: [
                                                                'Dowolna'.tr,
                                                                'Z ostatnich 24h'
                                                                    .tr,
                                                                'Z ostatnich 3 dni'
                                                                    .tr,
                                                                'Z ostatnich 7 dni'
                                                                    .tr,
                                                                'Z ostatnich 14 dni'
                                                                    .tr,
                                                                'Z ostatnich 30 dni'
                                                                    .tr,
                                                              ],
                                                              labelText:
                                                                  'Aktualność oferty'
                                                                      .tr,
                                                              filterKey:
                                                                  'aktualnosc_oferty',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  dynamicBoxHeightGroup),
                                                          SizedBox(
                                                            width: inputWidth,
                                                            child:
                                                                BuildDropdownButtonFormField(
                                                              currentValue:
                                                                  currentCountry,
                                                              items: [
                                                                'Dowolna'.tr,
                                                                'Cegła'.tr,
                                                                'Wielka płyta'.tr,
                                                                'Drewno'.tr,
                                                                'Pustak'.tr,
                                                                'Keramzyt'.tr,
                                                                'Beton'.tr,
                                                                'Silikat'.tr,
                                                                'Beton komórkowy'
                                                                    .tr,
                                                                'Żelbet'.tr,
                                                              ],
                                                              labelText:
                                                                  'Materiał budnku'
                                                                      .tr,
                                                              filterKey:
                                                                  'building_material',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  dynamicBoxHeightGroup),
                                                          SizedBox(
                                                            width: inputWidth,
                                                            child:
                                                                BuildDropdownButtonFormField(
                                                              currentValue:
                                                                  currentCountry,
                                                              items: [
                                                                'Agent nieruchomości'
                                                                    .tr,
                                                                'Deweloper'.tr,
                                                                'osoba prywatna'.tr,
                                                                'Dowolna'.tr,
                                                              ],
                                                              labelText:
                                                                  'Ogłoszeniodawca'
                                                                      .tr,
                                                              filterKey:
                                                                  'building_material',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Material(
                                                            color:
                                                                Colors.transparent,
                                                            child: Text(
                                                                'Dodatkowe informacje'
                                                                    .tr,
                                                                style: AppTextStyles
                                                                    .interSemiBold
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        color:
                                                                            buttonTextColor)),
                                                          ),
                                                        ],
                                                      ),
                                                      Wrap(
                                                        alignment:
                                                            WrapAlignment.start,
                                                        spacing:
                                                            dynamicBoxHeightGroup,
                                                        runSpacing:
                                                            dynamicBoxHeightGroupSmall,
                                                        children: [
                                                          AdditionalInfoFilterButton(
                                                              text: 'Balkon'.tr,
                                                              filterKey: 'balcony'),
                                                          AdditionalInfoFilterButton(
                                                              text: 'Taras'.tr,
                                                              filterKey: 'terrace'),
                                                          AdditionalInfoFilterButton(
                                                              text: 'Piwnica'.tr,
                                                              filterKey:
                                                                  'basement'),
                                                          AdditionalInfoFilterButton(
                                                              text: 'Winda'.tr,
                                                              filterKey:
                                                                  'elevator'),
                                                          AdditionalInfoFilterButton(
                                                              text: 'Ogród'.tr,
                                                              filterKey: 'garden'),
                                                          AdditionalInfoFilterButton(
                                                              text:
                                                                  'Klimatyzacja'.tr,
                                                              filterKey:
                                                                  'air_conditioning'),
                                                          AdditionalInfoFilterButton(
                                                              text: 'Garaż'.tr,
                                                              filterKey: 'garage'),
                                                          AdditionalInfoFilterButton(
                                                              text:
                                                                  'Miejsce postojowe'
                                                                      .tr,
                                                              filterKey:
                                                                  'parking_space'),
                                                          const AdditionalInfoFilterButton(
                                                              text: 'Jacuzzi',
                                                              filterKey: 'jacuzzi'),
                                                          const AdditionalInfoFilterButton(
                                                              text: 'Sauna',
                                                              filterKey: 'sauna'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            ref
                                                .read(filterCacheProvider.notifier)
                                                .clearFilters();
                                            ref
                                                .read(filterButtonProvider.notifier)
                                                .clearUiFilters();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: Text('Wyczyść filtry'.tr,
                                              style: AppTextStyles.interMedium
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: buttonTextColor)),
                                        ),
                                        const Spacer(),
                                        ElevatedButton(
                                          onPressed: () {
                                            ref
                                                .read(filterProvider.notifier)
                                                .applyFiltersFromCache(ref.read(
                                                    filterCacheProvider.notifier),ref);
                                            Navigator.of(context).pop();

                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            foregroundColor: buttonTextColor,
                                            padding: const EdgeInsets.only(
                                                left: 30,
                                                right: 30,
                                                top: 10,
                                                bottom: 10),
                                            textStyle:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          child: Text('Zastosuj filtry'.tr,
                                              style: TextStyle(
                                                  color: buttonTextColor)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Mytextfield(),
                              SizedBox(width: dynamiSpacerBoxWidth),
                              Positioned(
                                top: 30,
                                right: 20,
                                child: MaterialButton(
                                  onPressed: () {
                                    // Akcja po naciśnięciu przycisku
                                  },
                                  child: Row(
                                    children: [
                                      Material(
                                        color: Colors.transparent,
                                        child: Text('Zapisz wyszukiwanie'.tr,
                                            style:
                                                TextStyle(color: buttonTextColor)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.save, color: iconColor),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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
