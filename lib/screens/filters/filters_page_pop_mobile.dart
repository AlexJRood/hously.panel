import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/autocompletion.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/provider/autocompletion_provider.dart';

import '../../widgets/filters_components.dart';

class FiltersPagePopMobile extends ConsumerStatefulWidget {
  const FiltersPagePopMobile({super.key});

  @override
  FiltersPagePopMobileState createState() => FiltersPagePopMobileState();
}

class FiltersPagePopMobileState extends ConsumerState<FiltersPagePopMobile> {
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
        final filterCache = ref.watch(filterCacheProvider);
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
        final List<String> selectedValues = List<String>.from(ref.watch(
            filterButtonProvider.select((state) => state[estateType] ?? [])));
        selectedValues.add(estateType);
        ref
            .read(filterButtonProvider.notifier)
            .updateFilter('estate_type', selectedValues);
        ref
            .read(filterCacheProvider.notifier)
            .addFilter('estate_type', selectedValues.join(','));
      } catch (e) {
        print('error: $e');
      }
    });

    searchController = TextEditingController(text: filterNotifier.searchQuery);
    searchRadiusController =
        TextEditingController(text: filterNotifier.searchQuery);
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
      offerTypeController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? currentCountry =
        ref.watch(filterButtonProvider.select((state) => state['country']));

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double dynamicBoxHeight = 25;
    double dynamicBoxHeightGroup = 10;
    double dynamicBoxHeightGroupSmall = 8;
    double dynamiSpacerBoxWidth = 15;
    final model =
        ref.watch(myTextFieldViewModelProvider.notifier); // Watch the provider

    final themecolors = ref.watch(themeColorsProvider);
    const iconColor = AppColors.textColorLight;
    final currentthememode = ref.watch(themeProvider);
    final buttoncolor = Theme.of(context).primaryColor;
    final buttonTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorLight
        : AppColors.textColorLight;
    return PopupListener(
      child: SafeArea(
        child: Scaffold(
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
              GestureDetector(onTap: () {
                Navigator.of(context).pop();
              }),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: Hero(
                    tag:
                        'FilterMobile-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag
                    child: GestureDetector(
                      onTap: () {
                        model.setLoading(false);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: SizedBox(
                          width: math.max(screenWidth * 0.75, 450),
                          height: math.max(screenHeight * 0.91, 400),
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                            child: Container(
                              color: Colors.black.withOpacity(0.25),
                              child: Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: dynamiSpacerBoxWidth + 70),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ScrollbarTheme(
                                            data: ScrollbarThemeData(
                                              thumbColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white
                                                          .withOpacity(0.5)),
                                              thickness:
                                                  MaterialStateProperty.all(
                                                      6.0),
                                              radius:
                                                  const Radius.circular(10.0),
                                            ),
                                            child: Scrollbar(
                                              controller: scrollController,
                                              thumbVisibility: true,
                                              child: ListView(
                                                controller: scrollController,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0,
                                                        vertical: 16.0),
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
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Material(
                                                              color: Colors
                                                                  .transparent,
                                                              child: Text(
                                                                  'Typ oferty'
                                                                      .tr,
                                                                  style: AppTextStyles
                                                                      .interSemiBold16)),
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                                                      .interSemiBold16)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              dynamicBoxHeightGroupSmall),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          spacing: 5,
                                                          children: [
                                                            Row(
                                                              spacing: 5,
                                                              children: [
                                                                EstateTypeFilterButton(
                                                                  text:
                                                                      'Mieszkanie'
                                                                          .tr,
                                                                  filterValue:
                                                                      'Flat',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                                EstateTypeFilterButton(
                                                                  text:
                                                                      'Kawalerka'
                                                                          .tr,
                                                                  filterValue:
                                                                      'Studio',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                                const EstateTypeFilterButton(
                                                                  text:
                                                                      'Apartament',
                                                                  filterValue:
                                                                      'Apartment',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                                EstateTypeFilterButton(
                                                                  text:
                                                                      'Dom jednorodzinny'
                                                                          .tr,
                                                                  filterValue:
                                                                      'House',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                                EstateTypeFilterButton(
                                                                  text:
                                                                      'Bliźniak'
                                                                          .tr,
                                                                  filterValue:
                                                                      'Twin house',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                                EstateTypeFilterButton(
                                                                  text:
                                                                      'Szeregowiec'
                                                                          .tr,
                                                                  filterValue:
                                                                      'Row house',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            Row(
                                                              spacing: 5,
                                                              children: [
                                                                EstateTypeFilterButton(
                                                                  text:
                                                                      'Inwestycje'
                                                                          .tr,
                                                                  filterValue:
                                                                      'Invest',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                                EstateTypeFilterButton(
                                                                  text:
                                                                      'Działki'
                                                                          .tr,
                                                                  filterValue:
                                                                      'Lot',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                                EstateTypeFilterButton(
                                                                  text:
                                                                      'Lokale użytkowe'
                                                                          .tr,
                                                                  filterValue:
                                                                      'Commercial',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                                EstateTypeFilterButton(
                                                                  text:
                                                                      'Hale i magazyny'
                                                                          .tr,
                                                                  filterValue:
                                                                      'Warehouse',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                                EstateTypeFilterButton(
                                                                  text: 'Pokoje'
                                                                      .tr,
                                                                  filterValue:
                                                                      'Room',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                                EstateTypeFilterButton(
                                                                  text: 'Garaże'
                                                                      .tr,
                                                                  filterValue:
                                                                      'Garage',
                                                                  filterKey:
                                                                      'estate_type',
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
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
                                                          color: Colors
                                                              .transparent,
                                                          child: Text(
                                                              'Filtry'.tr,
                                                              style: AppTextStyles
                                                                  .interSemiBold16)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          dynamicBoxHeightGroupSmall),
                                                  IntrinsicHeight(
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
                                                                dynamicBoxHeight),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
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
                                                                                AppColors.light,
                                                                            fontSize: 14))),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height:
                                                                    dynamicBoxHeightGroupSmall),
                                                            const SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  FilterButton(
                                                                    text: '1',
                                                                    filterValue:
                                                                        '1',
                                                                    filterKey:
                                                                        'rooms',
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  FilterButton(
                                                                    text: '2',
                                                                    filterValue:
                                                                        '2',
                                                                    filterKey:
                                                                        'rooms',
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  FilterButton(
                                                                    text: '3',
                                                                    filterValue:
                                                                        '3',
                                                                    filterKey:
                                                                        'rooms',
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  FilterButton(
                                                                    text: '4',
                                                                    filterValue:
                                                                        '4',
                                                                    filterKey:
                                                                        'rooms',
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  FilterButton(
                                                                    text: '5',
                                                                    filterValue:
                                                                        '5',
                                                                    filterKey:
                                                                        'rooms',
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  FilterButton(
                                                                    text: '6',
                                                                    filterValue:
                                                                        '6',
                                                                    filterKey:
                                                                        'rooms',
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  FilterButton(
                                                                    text: '7+',
                                                                    filterValue:
                                                                        '7+',
                                                                    filterKey:
                                                                        'rooms',
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: dynamicBoxHeight),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          'Dodatkowe filtry'.tr,
                                                          style: AppTextStyles
                                                              .interSemiBold
                                                              .copyWith(
                                                                  fontSize:
                                                                      18)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          dynamicBoxHeightGroupSmall),
                                                  Column(children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: FilterButton(
                                                            text:
                                                                'Rynek pierwotny'
                                                                    .tr,
                                                            filterValue: 'new',
                                                            filterKey:
                                                                'market_type',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                dynamicBoxHeightGroup),
                                                        Expanded(
                                                          child: FilterButton(
                                                            text: 'Rynek wtórny'
                                                                .tr,
                                                            filterValue: 'use',
                                                            filterKey:
                                                                'market_type',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamicBoxHeightGroup),
                                                    SizedBox(
                                                      child:
                                                          BuildDropdownButtonFormField(
                                                        currentValue:
                                                            currentCountry,
                                                        items: [
                                                          'Blok'.tr,
                                                          'Apartamentowiec'.tr,
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
                                                      child:
                                                          BuildDropdownButtonFormField(
                                                        currentValue:
                                                            currentCountry,
                                                        items: [
                                                          'Dowolna'.tr,
                                                          'Z ostatnich 24h'.tr,
                                                          'Z ostatnich 3 dni'
                                                              .tr,
                                                          'Z ostatnich 7 dni'
                                                              .tr,
                                                          'Z ostatnich 14 dni'
                                                              .tr,
                                                          'Z ostatnich 30 dni'
                                                              .tr
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
                                                          'Beton komórkowy'.tr,
                                                          'Żelbet'.tr
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
                                                      child:
                                                          BuildDropdownButtonFormField(
                                                        currentValue:
                                                            currentCountry,
                                                        items: [
                                                          'Agent nieruchomości'
                                                              .tr,
                                                          'Deweloper'.tr,
                                                          'osoba prywatna'.tr,
                                                          'Dowolna'.tr
                                                        ],
                                                        labelText:
                                                            'Ogłoszeniodawca'
                                                                .tr,
                                                        filterKey:
                                                            'building_material',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamicBoxHeightGroup),
                                                  ]),
                                                  SizedBox(
                                                      height: dynamicBoxHeight),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                                                  'Dodatkowe informacje'
                                                                      .tr,
                                                                  style: AppTextStyles
                                                                      .interSemiBold16)),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              dynamicBoxHeightGroup),
                                                      SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          spacing: 10,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                AdditionalInfoFilterButton(
                                                                    text:
                                                                        'Balkon'
                                                                            .tr,
                                                                    filterKey:
                                                                        'balcony'),
                                                                const SizedBox(
                                                                    width: 5),
                                                                AdditionalInfoFilterButton(
                                                                    text:
                                                                        'Taras'
                                                                            .tr,
                                                                    filterKey:
                                                                        'terrace'),
                                                                const SizedBox(
                                                                    width: 5),
                                                                AdditionalInfoFilterButton(
                                                                    text:
                                                                        'Piwnica'
                                                                            .tr,
                                                                    filterKey:
                                                                        'basement'),
                                                                const SizedBox(
                                                                    width: 5),
                                                                AdditionalInfoFilterButton(
                                                                    text:
                                                                        'Winda'
                                                                            .tr,
                                                                    filterKey:
                                                                        'elevator'),
                                                                const SizedBox(
                                                                    width: 5),
                                                                AdditionalInfoFilterButton(
                                                                    text:
                                                                        'Ogród'
                                                                            .tr,
                                                                    filterKey:
                                                                        'garden'),
                                                                const SizedBox(
                                                                    width: 5),
                                                                AdditionalInfoFilterButton(
                                                                    text:
                                                                        'Garaż'
                                                                            .tr,
                                                                    filterKey:
                                                                        'garage'),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                AdditionalInfoFilterButton(
                                                                    text:
                                                                        'Klimatyzacja'
                                                                            .tr,
                                                                    filterKey:
                                                                        'air_conditioning'),
                                                                const SizedBox(
                                                                    width: 5),
                                                                AdditionalInfoFilterButton(
                                                                    text:
                                                                        'Miejsce postojowe'
                                                                            .tr,
                                                                    filterKey:
                                                                        'parking_space'),
                                                                const SizedBox(
                                                                    width: 5),
                                                                const AdditionalInfoFilterButton(
                                                                    text:
                                                                        'Jacuzzi',
                                                                    filterKey:
                                                                        'jacuzzi'),
                                                                const SizedBox(
                                                                    width: 5),
                                                                const AdditionalInfoFilterButton(
                                                                    text:
                                                                        'Sauna',
                                                                    filterKey:
                                                                        'sauna'),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: dynamicBoxHeight),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  ref
                                                      .read(filterCacheProvider
                                                          .notifier)
                                                      .clearFilters();
                                                  ref
                                                      .read(filterButtonProvider
                                                          .notifier)
                                                      .clearUiFilters();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  foregroundColor: Colors.white,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                ),
                                                child: Text('Wyczyść filtry'.tr,
                                                    style: AppTextStyles
                                                        .interRegular14
                                                        .copyWith(
                                                            color:
                                                                buttonTextColor)),
                                              ),
                                              const Spacer(),
                                              ElevatedButton(
                                                onPressed: () {
                                                  ref
                                                      .read(filterProvider
                                                          .notifier)
                                                      .applyFiltersFromCache(
                                                          ref.read(
                                                              filterCacheProvider
                                                                  .notifier),
                                                          ref);

                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: buttoncolor,
                                                  foregroundColor:
                                                      buttonTextColor,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30,
                                                          right: 30,
                                                          top: 10,
                                                          bottom: 10),
                                                  textStyle: AppTextStyles
                                                      .interSemiBold14,
                                                ),
                                                child: Text(
                                                  'Zastosuj filtry'.tr,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Mytextfield(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: MaterialButton(
                                      onPressed: () {},
                                      child: const Row(
                                        children: [
                                          SizedBox(width: 15),
                                          Text('',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          SizedBox(width: 10),
                                          Icon(Icons.save, color: iconColor),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
