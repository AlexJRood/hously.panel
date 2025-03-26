import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:intl/intl.dart';

import '../../../widgets/side_menu/side_menu_manager.dart';
import '../../../widgets/side_menu/slide_rotate_menu.dart';

class FiltersPvMobilePage extends ConsumerStatefulWidget {
  const FiltersPvMobilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FiltersPagePopState createState() => _FiltersPagePopState();
}

class _FiltersPagePopState extends ConsumerState<FiltersPvMobilePage> {
  String selectedOfferType =
      ''; // Zmienna stanu przechowująca wybrany typ ofert

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
    super.dispose();
  }

  void setSelectedOfferType(String value) {
    setState(() {
      selectedOfferType = value;
      offerTypeController.text = value; // Aktualizacja kontrolera tekstu
    });
  }
  final sideMenuKey = GlobalKey<SideMenuState>();


  @override
  Widget build(BuildContext context) {
    final String? currentCountry = ref.watch(filterButtonProvider)['country'];

    // final RangeValues rangeValues = ref.watch(filterButtonProvider.select((state) => state['floorsRange'] as RangeValues? ?? const RangeValues(0, 100)));

    double screenWidth = MediaQuery.of(context).size.width;
    double dynamicBoxHeight = 20;
    double dynamicBoxHeightGroup = 12;
    double dynamicBoxHeightGroupSmall = 10;
    double dynamiSpacerBoxWidth = 15;
    double inputWidth = math.max(screenWidth * 0.25, 170);

    return SideMenuManager.sideMenuSettings(
      menuKey: sideMenuKey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
               AppBarMobile(sideMenuKey: sideMenuKey,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // const AppBarMobile(),
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
                                    style: AppTextStyles.interRegular.copyWith(
                                        fontSize: 14, color: AppColors.dark),
                                    decoration: InputDecoration(
                                      labelText: 'Wyszukaj'.tr,
                                      labelStyle: AppTextStyles.interRegular
                                          .copyWith(
                                              fontSize: 14,
                                              color: AppColors
                                                  .dark), // Kolor etykiety na biały
                                      prefixIcon: const Icon(Icons.search,
                                          color: Colors
                                              .black), // Ikona wyszukiwania na biały
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide:
                                            BorderSide.none, // Brak domyślnej ramki
                                      ),
                                      filled: false, // Wypełnienie tłem
                                      fillColor: Colors.white, // Białe tło
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: const BorderSide(
                                            color: Colors
                                                .black), // Czarna ramka po kliknięciu
                                      ),
                                    ),
                                    onChanged: (value) => ref
                                        .read(filterCacheProvider.notifier)
                                        .setSearchQuery(value),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: dynamiSpacerBoxWidth),
                            // Przycisk 'Zapisz wyszukiwanie'
                            MaterialButton(
                              onPressed: () {
                                // Akcja po naciśnięciu przycisku
                              },
                              child:  Row(
                                children: [
                                  Text('Zapisz wyszukiwanie'.tr,
                                      style: const TextStyle(
                                          color: Colors
                                              .white)), // Tekst przycisku na biały
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.save,
                                      color: Colors.white), // Ikona zapisu na biały
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: dynamiSpacerBoxWidth),
                        Wrap(
                          spacing: dynamicBoxHeightGroupSmall,
                          runSpacing: dynamicBoxHeightGroupSmall,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Typ oferty'.tr,
                                    style: AppTextStyles.interSemiBold
                                        .copyWith(fontSize: 18)),
                              ],
                            ),

                             FilterButton(
                              text: 'Na sprzedaż'.tr,
                              filterValue: 'sell',
                              filterKey:
                                  'offer_type', // Ustawienie klucza filtra na 'offer_type'
                            ),
                            // Odstęp między przyciskami
                             FilterButton(
                              text: 'Na wynajem'.tr,
                              filterValue: 'rent',
                              filterKey:
                                  'offer_type', // Ponownie, ustawienie klucza filtra na 'offer_type'
                            ),
                          ],
                        ),
                        SizedBox(height: dynamicBoxHeight),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Lokalizacja'.tr,
                                    style: AppTextStyles.interSemiBold
                                        .copyWith(fontSize: 18)),
                              ],
                            ),
                            SizedBox(height: dynamicBoxHeightGroupSmall),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: BuildTextField(
                                    controller: countryController,
                                    labelText: 'Kraj'.tr,
                                    filterKey:
                                        'country', // Klucz filtra, który ma być aktualizowany
                                    ref: ref,
                                  ),
                                ),
                                SizedBox(width: dynamiSpacerBoxWidth),
                                Expanded(
                                  child: BuildTextField(
                                    controller: cityController,
                                    labelText: 'Miasto'.tr,
                                    filterKey:
                                        'city', // Klucz filtra, który ma być aktualizowany
                                    ref: ref,
                                  ),
                                ),
                                SizedBox(width: dynamiSpacerBoxWidth),
                                Expanded(
                                  child: BuildTextField(
                                    controller: stateController,
                                    labelText: 'Województwo'.tr,
                                    filterKey:
                                        'state', // Klucz filtra, który ma być aktualizowany
                                    ref: ref,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: dynamicBoxHeightGroupSmall),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: BuildTextField(
                                    controller: streetController,
                                    labelText: 'Ulica'.tr,
                                    filterKey:
                                        'street', // Klucz filtra, który ma być aktualizowany
                                    ref: ref,
                                  ),
                                ),
                                SizedBox(width: dynamiSpacerBoxWidth),
                                SizedBox(
                                  width: 150, // zmienić na dynamiczny rozmair
                                  child: BuildTextField(
                                    controller: zipcodeController,
                                    labelText: 'Kod pocztowy'.tr,
                                    filterKey:
                                        'zip_code', // Klucz filtra, który ma być aktualizowany
                                    ref: ref,
                                  ),
                                ),
                                SizedBox(width: dynamiSpacerBoxWidth),
                                SizedBox(
                                  width: 100, // zmienić na dynamiczny rozmair
                                  child: BuildTextField(
                                    controller: searchRadiusController,
                                    labelText: '+ 0km',
                                    filterKey:
                                        'city', // Klucz filtra, który ma być aktualizowany
                                    ref: ref, // Przekazanie WidgetRef do funkcji
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: dynamicBoxHeight),
                        Wrap(
                          spacing: dynamicBoxHeightGroupSmall,
                          runSpacing: dynamicBoxHeightGroupSmall,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rodzaj nieruchomości'.tr,
                                    style: AppTextStyles.interSemiBold
                                        .copyWith(fontSize: 18)),
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
                              text: 'Dom jednorodzinny'.tr,
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
                        SizedBox(height: dynamicBoxHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Filtry'.tr,
                                style: AppTextStyles.interSemiBold
                                    .copyWith(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: dynamicBoxHeightGroupSmall),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: BuildNumberField(
                                          controller: minSquareFootageController,
                                          labelText: 'Metraż od'.tr,
                                          filterKey: 'min_square_footage',
                                          ref: ref,
                                          formatter: NumberFormat('#,###'),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              dynamiSpacerBoxWidth), // Odstęp pomiędzy polami
                                      Expanded(
                                        // width: 250,
                                        child: BuildNumberField(
                                          controller: maxSquareFootageController,
                                          labelText: 'Metraż do'.tr,
                                          filterKey:
                                              'max_square_footage', // Klucz używany do aktualizacji wartości w filterProvider
                                          ref: ref,
                                          formatter: NumberFormat('#,###'),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: dynamicBoxHeightGroup),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        // width: 250,
                                        child: BuildNumberField(
                                          controller: minPriceController,
                                          labelText: 'Cena od'.tr,
                                          formatter: NumberFormat('#,###'),
                                          filterKey:
                                              'min_price', // Klucz używany do aktualizacji wartości w filterProvider
                                          ref:
                                              ref, // Przekazanie referencji WidgetRef
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              dynamiSpacerBoxWidth), // Odstęp pomiędzy polami
                                      Expanded(
                                        // width: 250,
                                        child: BuildNumberField(
                                          controller: maxPriceController,
                                          labelText: 'Cena do'.tr,
                                          formatter: NumberFormat('#,###'),
                                          filterKey:
                                              'max_price', // Klucz używany do aktualizacji wartości w filterProvider
                                          ref:
                                              ref, // Przekazanie referencji WidgetRef
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: dynamicBoxHeightGroup),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        // width: 250,
                                        child: BuildNumberField(
                                          controller: minPricePerMeterController,
                                          labelText: 'Cena za metr od'.tr,
                                          formatter: NumberFormat('#,###'),
                                          filterKey:
                                              'min_price_per_meter', // Klucz używany do aktualizacji wartości w filterProvider
                                          ref: ref,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              dynamiSpacerBoxWidth), // Odstęp pomiędzy polami
                                      Expanded(
                                        // width: 250,
                                        child: BuildNumberField(
                                          controller: maxPricePerMeterController,
                                          labelText: 'Cena za metr do'.tr,
                                          formatter: NumberFormat('#,###'),
                                          filterKey:
                                              'max_price_per_meter', // Klucz używany do aktualizacji wartości w filterProvider
                                          ref: ref,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: dynamicBoxHeightGroup),

                                  // Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text('Liczba pokoi',
                                  //         style: AppTextStyles.interMedium
                                  //             .copyWith(color: AppColors.light, fontSize: 14)),
                                  //   ],
                                  // ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        // width: 250,
                                        child: BuildNumberField(
                                          controller:
                                              minRoomsController, //do ustawienia
                                          labelText: 'Rok budowy od'.tr,
                                          formatter: NumberFormat('#,###'),
                                          filterKey:
                                              'min_build_year', // do uzupełnienia
                                          ref: ref,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              dynamiSpacerBoxWidth), // Odstęp pomiędzy polami
                                      Expanded(
                                        // width: 250,
                                        child: BuildNumberField(
                                          controller:
                                              maxRoomsController, //do ustawienia
                                          labelText: 'Rok budowy do'.tr,
                                          formatter: NumberFormat('#,###'),
                                          filterKey:
                                              'max_build_year', // Klucz używany do aktualizacji wartości w filterProvider
                                          ref: ref,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: dynamicBoxHeightGroup),
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    spacing:
                                        dynamicBoxHeightGroupSmall, // odstęp poziomy między dziećmi
                                    runSpacing:
                                        dynamicBoxHeightGroupSmall, // odstęp pionowy między liniami

                                    children: [
                                      Text('Liczba pokoi'.tr,
                                          style: AppTextStyles.interMedium
                                              .copyWith(
                                                  color: AppColors.light,
                                                  fontSize: 14)),
                                      const FilterButton(
                                        text: '1',
                                        filterValue: '1',
                                        filterKey:
                                            'rooms', // Ustawienie klucza filtra na 'offer_type'
                                      ),
                                      // Odstęp między przyciskami
                                      const FilterButton(
                                        text: '2',
                                        filterValue: '2',
                                        filterKey:
                                            'rooms', // Ponownie, ustawienie klucza filtra na 'offer_type'
                                      ),

                                      const FilterButton(
                                        text: '3',
                                        filterValue: '3',
                                        filterKey:
                                            'rooms', // Ponownie, ustawienie klucza filtra na 'offer_type'
                                      ),

                                      const FilterButton(
                                        text: '4',
                                        filterValue: '4',
                                        filterKey:
                                            'rooms', // Ponownie, ustawienie klucza filtra na 'offer_type'
                                      ),

                                      const FilterButton(
                                        text: '5',
                                        filterValue: '5',
                                        filterKey:
                                            'rooms', // Ponownie, ustawienie klucza filtra na 'offer_type'
                                      ),

                                      const FilterButton(
                                        text: '6',
                                        filterValue: '6',
                                        filterKey:
                                            'rooms', // Ponownie, ustawienie klucza filtra na 'offer_type'
                                      ),

                                      const FilterButton(
                                        //ustawić logikę wyszukiwania 7+
                                        text: '7+',
                                        filterValue: '7+',
                                        filterKey:
                                            'rooms', // Ponownie, ustawienie klucza filtra na 'offer_type'
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: dynamicBoxHeightGroup),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: dynamiSpacerBoxWidth * 3,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                         FilterButton(
                                          text: 'Rynek pierwotny'.tr,
                                          filterValue: 'new',
                                          filterKey: 'market_type',
                                        ),
                                        SizedBox(width: dynamicBoxHeightGroup),
                                         FilterButton(
                                          text: 'Rynek wtórny'.tr,
                                          filterValue: 'use',
                                          filterKey: 'market_type',
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: dynamicBoxHeightGroup),

                                  SizedBox(
                                    width: inputWidth,
                                    child: BuildDropdownButtonFormField(
                                      currentValue: currentCountry,
                                      items: [
                                        'Blok'.tr,
                                        'Apartamentowiec'.tr,
                                        'Kamienica'.tr,
                                        'Wieżowiec'.tr,
                                        'Loft',
                                        'Szeregowiec'.tr,
                                        'Plomba'.tr
                                      ],
                                      labelText: 'Rodzaj zabudowy'.tr,
                                      filterKey:
                                          'building_type', // Klucz używany do aktualizacji wartości w filterProvider
                                      ref: ref, // Przekazanie referencji WidgetRef
                                    ),
                                  ),
                                  SizedBox(height: dynamicBoxHeightGroup),

                                  //Do uzupełnienia kontroler
                                  SizedBox(
                                    width: inputWidth,
                                    child: BuildDropdownButtonFormField(
                                      currentValue: currentCountry,
                                      items: [
                                        'Gazowe'.tr,
                                        'Elektryczne'.tr,
                                        'Miejskie'.tr,
                                        'Pompa ciepła'.tr,
                                        'Olejowe'.tr,
                                        'Nie podono informacji'.tr,
                                        'Wszystkie'.tr
                                      ],
                                      labelText: 'Rodzaj ogrzewania'.tr,
                                      filterKey:
                                          'heater_type', // Klucz używany do aktualizacji wartości w filterProvider
                                      ref: ref, // Przekazanie referencji WidgetRef
                                    ),
                                  ),
                                  SizedBox(height: dynamicBoxHeightGroup),

                                  //Do uzupełnienia kontroler
                                  SizedBox(
                                    width: inputWidth,
                                    child: BuildDropdownButtonFormField(
                                      currentValue: currentCountry,
                                      items: [
                                        'Dowolna'.tr,
                                        'Z ostatnich 24h'.tr,
                                        'Z ostatnich 3 dni'.tr,
                                        'Z ostatnich 7 dni'.tr,
                                        'Z ostatnich 14 dni'.tr,
                                        'Z ostatnich 30 dni'.tr,
                                      ],
                                      labelText: 'Aktualność oferty'.tr,
                                      filterKey:
                                          'aktualnosc_oferty', // Klucz używany do aktualizacji wartości w filterProvider
                                      ref: ref, // Przekazanie referencji WidgetRef
                                    ),
                                  ),
                                  SizedBox(height: dynamicBoxHeightGroup),

                                  //Do uzupełnienia kontroler
                                  SizedBox(
                                    width: inputWidth,
                                    child: BuildDropdownButtonFormField(
                                      currentValue: currentCountry,
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
                                        'Żelbet'.tr,
                                      ],
                                      labelText: 'Materiał budnku'.tr,
                                      filterKey:
                                          'building_material', // Klucz używany do aktualizacji wartości w filterProvider
                                      ref: ref, // Przekazanie referencji WidgetRef
                                    ),
                                  ),
                                  SizedBox(height: dynamicBoxHeightGroup),

                                  //Do uzupełnienia kontroler
                                  SizedBox(
                                    width: inputWidth,
                                    child: BuildDropdownButtonFormField(
                                      currentValue: currentCountry,
                                      items: [
                                        'Agent nieruchomości'.tr,
                                        'Deweloper'.tr,
                                        'osoba prywatna'.tr,
                                        'Dowolna'.tr,
                                      ],
                                      labelText: 'Ogłoszeniodawca'.tr,
                                      filterKey:
                                          'building_material', // Klucz używany do aktualizacji wartości w filterProvider
                                      ref: ref, // Przekazanie referencji WidgetRef
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Dodatkowe informacje'.tr,
                                    style: AppTextStyles.interSemiBold
                                        .copyWith(fontSize: 18)),
                              ],
                            ),
                            Wrap(
                              alignment: WrapAlignment.start,
                              spacing:
                                  dynamicBoxHeightGroup, // odstęp poziomy między dziećmi
                              runSpacing:
                                  dynamicBoxHeightGroupSmall, // odstęp pionowy między liniami

                              children:  [
                                AdditionalInfoFilterButton(
                                    text: 'Balkon'.tr, filterKey: 'balcony'),
                                AdditionalInfoFilterButton(
                                    text: 'Taras'.tr, filterKey: 'terrace'),
                                AdditionalInfoFilterButton(
                                    text: 'Piwnica'.tr, filterKey: 'basement'),
                                AdditionalInfoFilterButton(
                                    text: 'Winda'.tr, filterKey: 'elevator'),
                                AdditionalInfoFilterButton(
                                    text: 'Ogród'.tr, filterKey: 'garden'),
                                AdditionalInfoFilterButton(
                                    text: 'Klimatyzacja'.tr,
                                    filterKey: 'air_conditioning'),
                                AdditionalInfoFilterButton(
                                    text: 'Garaż'.tr, filterKey: 'garage'),
                                AdditionalInfoFilterButton(
                                    text: 'Miejsce postojowe'.tr,
                                    filterKey: 'parking_space'),
                                const AdditionalInfoFilterButton(
                                    text: 'Jacuzzi', filterKey: 'jacuzzi'),
                                const AdditionalInfoFilterButton(
                                    text: 'Sauna', filterKey: 'sauna'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: dynamicBoxHeight),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Wywołanie metody clearFilters w notifierze, aby wyczyścić filtry
                                ref
                                    .read(filterCacheProvider.notifier)
                                    .clearFilters();
                                ref
                                    .read(filterButtonProvider.notifier)
                                    .clearUiFilters();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .transparent, // Możesz ustawić kolor tła przycisku
                                foregroundColor:
                                    Colors.white, // Kolor tekstu przycisku
                              ),
                              child: Text('Wyczyść filtry'.tr,
                                  style: AppTextStyles.interMedium.copyWith(
                                      fontSize: 12, color: AppColors.light)),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                // Wywołanie metody applyFilters z notifiera filtra
                                ref.read(filterProvider.notifier).applyFilters(ref);
                                // ref.read(mapPageProvider.notifier).refreshMap(ref);
                                // Pobranie ostatniej strony z historii nawigacji bezpośrednio z notifiera
                                final String lastPage = ref
                                    .read(navigationHistoryProvider.notifier)
                                    .lastPage;
                                // Powrót do ostatniej strony używając Navigator
                                if (ref.read(navigationService).canBeamBack()) {
                                  ref.read(navigationService).beamPop();
                                } else {
                                  // Jeśli nie można cofnąć (np. jesteśmy na pierwszej stronie stosu), możemy nawigować do lastPage
                                  ref
                                      .read(navigationService)
                                      .pushNamedScreen(lastPage);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue, // Kolor tła przycisku
                                foregroundColor:
                                    Colors.white, // Kolor tekstu przycisku
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 10, bottom: 10),
                                textStyle: const TextStyle(
                                    fontSize: 18), // Rozmiar czcionki przycisku
                              ),
                              child:  Text('Zastosuj filtry'.tr),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const BottomBarMobile(),
            ],
          ),
        ),
      ),
    );
  }
}

//wykluczenie słów kluczowych

/*      Material(
                        child: TextField(
                          controller: excludeController,
                          decoration: const InputDecoration(
                            labelText: 'Wyklucz',
                            prefixIcon: Icon(Icons.block),
                          ),
                          onChanged: (value) => ref
                              .read(filterProvider.notifier)
                              .setExcludeQuery(value),
                        ),
                      ),

                      */

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
    final bool isSelected = ref.watch(filterButtonProvider
        .select((state) => state[filterKey] == filterValue));

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
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected
            ? Colors.white
            : Colors
                .black, // Zmiana koloru tekstu na czarny, gdy przycisk nie jest zaznaczony
        side: isSelected
            ? null
            : const BorderSide(
                color: Colors
                    .grey), // Dodanie obramowania, gdy przycisk nie jest zaznaczony
      ),
      child: Text(text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
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
    final bool isSelected = selectedValues.contains(filterValue);

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
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        side: isSelected ? null : const BorderSide(color: Colors.grey),
      ),
      child: Text(text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
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

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.filterKey,
    required this.ref,
  });

  final TextEditingController controller;
  final String labelText;
  final String filterKey;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 2, // Lekkie uniesienie dla efektu cienia
      child: SizedBox(
        height: 35.0, // Ustawienie wysokości na 35px
        child: TextField(
          controller: controller,
          onChanged: (value) {
            // Aktualizacja wartości w filterProvider
            ref.read(filterCacheProvider.notifier).addFilter(filterKey, value);
          },
          style: AppTextStyles.interMedium.copyWith(
              fontSize: 14, color: AppColors.dark), // Styl tekstu wpisywanego
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: AppTextStyles.interMedium
                .copyWith(fontSize: 14, color: AppColors.dark), // Styl etykiety
            contentPadding: const EdgeInsets.only(
                left: 12,
                top: 8,
                bottom:
                    8), // Zmniejszenie paddingu, by tekst mieścił się w 35px
            fillColor: Colors.white,
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
        ),
      ),
    );
  }
}

class BuildNumberField extends StatelessWidget {
  const BuildNumberField({
    super.key,
    required this.formatter,
    required this.controller,
    required this.labelText,
    required this.filterKey,
    required this.ref,
  });

  final NumberFormat formatter;
  final TextEditingController controller;
  final String labelText;
  final String filterKey;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
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
              fontSize: 14, color: AppColors.dark), // Styl tekstu wpisywanego
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: AppTextStyles.interMedium
                .copyWith(fontSize: 14, color: AppColors.dark), // Styl etykiety
            contentPadding: const EdgeInsets.only(
                left: 12,
                top: 8,
                bottom:
                    8), // Zmniejszenie paddingu, by tekst mieścił się w 35px
            fillColor: Colors.white,
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

class BuildDropdownButtonFormField extends StatelessWidget {
  const BuildDropdownButtonFormField({
    super.key,
    this.currentValue,
    required this.items,
    required this.filterKey,
    required this.ref,
    required this.labelText,
  });
  final String? currentValue;
  final List<String> items;
  final String filterKey;
  final WidgetRef ref;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 2,
      child: SizedBox(
        height: 35.0,
        child: DropdownButtonFormField<String>(
          value: currentValue,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyles.interMedium
                    .copyWith(fontSize: 14, color: AppColors.dark),
              ),
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
            labelStyle: AppTextStyles.interMedium
                .copyWith(fontSize: 14, color: AppColors.dark),
            contentPadding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
            fillColor: Colors.white,
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
