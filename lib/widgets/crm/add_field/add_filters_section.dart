import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/filters_components.dart';

class AddCrmFilters extends ConsumerStatefulWidget {
  const AddCrmFilters({super.key});

  @override
  AddCrmFiltersState createState() => AddCrmFiltersState();
}

class AddCrmFiltersState extends ConsumerState<AddCrmFilters> {
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

  @override
  void initState() {
    super.initState();
    final filterNotifier = ref.read(filterCacheProvider.notifier);

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
      offerTypeController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? currentCountry =
        ref.watch(filterButtonProvider.select((state) => state['country']));

    double dynamicBoxHeight = 25;
    double dynamicBoxHeightGroup = 10;
    double dynamicBoxHeightGroupSmall = 8;
    double dynamiSpacerBoxWidth = 15;
    double dynamicSpace = 5;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(30.0),
                          elevation: 2,
                          child: SizedBox(
                            height: 35.0,
                            child: TextField(
                              controller: searchController,
                              style: AppTextStyles.interRegular14
                                  .copyWith(color: AppColors.dark),
                              decoration: InputDecoration(
                                labelText: 'Wyszukaj'.tr,
                                labelStyle: AppTextStyles.interRegular14
                                    .copyWith(color: AppColors.dark),
                                prefixIcon: const Icon(Icons.search,
                                    color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: false,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black),
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
                      MaterialButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text('', style: TextStyle(color: Colors.white)),
                            SizedBox(width: 10),
                            Icon(Icons.save, color: Colors.white),
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
                          Material(
                              color: Colors.transparent,
                              child: Text('Typ oferty'.tr,
                                  style: AppTextStyles.interSemiBold16)),
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
                  SizedBox(height: dynamicBoxHeight),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Material(
                              color: Colors.transparent,
                              child: Text('Lokalizacja'.tr,
                                  style: AppTextStyles.interSemiBold16)),
                        ],
                      ),
                      SizedBox(height: dynamicBoxHeightGroupSmall),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: BuildDropdownButtonFormField(
                              currentValue: currentCountry,
                              items:  [
                                'Polska'.tr,
                                'Niemcy'.tr,
                                'Czechy'.tr,
                                'Austria',
                                'Litwa'.tr,
                                'Francja'.tr
                              ],
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
                          SizedBox(width: dynamiSpacerBoxWidth),
                          Expanded(
                            child: BuildTextField(
                              controller: stateController,
                              labelText: 'Województwo'.tr,
                              filterKey: 'state',
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
                              filterKey: 'street',
                            ),
                          ),
                          SizedBox(width: dynamiSpacerBoxWidth),
                          SizedBox(
                            width: 150,
                            child: BuildTextField(
                              controller: zipcodeController,
                              labelText: 'Kod pocztowy'.tr,
                              filterKey: 'zip_code',
                            ),
                          ),
                          SizedBox(width: dynamiSpacerBoxWidth),
                          SizedBox(
                            width: 100,
                            child: BuildTextField(
                              controller: searchRadiusController,
                              labelText: '+ 0km',
                              filterKey: 'city',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: dynamicBoxHeight),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                              color: Colors.transparent,
                              child: Text('Rodzaj nieruchomości'.tr,
                                  style: AppTextStyles.interSemiBold16)),
                        ],
                      ),
                      SizedBox(height: dynamicBoxHeightGroupSmall),
                       Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [
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
                    ],
                  ),
                  SizedBox(height: dynamicBoxHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Material(
                          color: Colors.transparent,
                          child: Text('Filtry'.tr,
                              style: AppTextStyles.interSemiBold16)),
                    ],
                  ),
                  SizedBox(height: dynamicBoxHeightGroupSmall),
                  IntrinsicHeight(
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
                              ),
                            ),
                            SizedBox(width: dynamiSpacerBoxWidth),
                            Expanded(
                              child: BuildNumberField(
                                controller: maxSquareFootageController,
                                labelText: 'Metraż do'.tr,
                                filterKey: 'max_square_footage',
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
                                filterKey: 'min_price',
                              ),
                            ),
                            SizedBox(width: dynamiSpacerBoxWidth),
                            Expanded(
                              child: BuildNumberField(
                                controller: maxPriceController,
                                labelText: 'Cena do'.tr,
                                filterKey: 'max_price',
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
                                controller: minPricePerMeterController,
                                labelText: 'Cena za metr od'.tr,
                                filterKey: 'min_price_per_meter',
                              ),
                            ),
                            SizedBox(width: dynamiSpacerBoxWidth),
                            Expanded(
                              child: BuildNumberField(
                                controller: maxPricePerMeterController,
                                labelText: 'Cena za metr do'.tr,
                                filterKey: 'max_price_per_meter',
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
                                controller: minRoomsController,
                                labelText: 'Rok budowy od'.tr,
                                filterKey: 'min_build_year',
                              ),
                            ),
                            SizedBox(width: dynamiSpacerBoxWidth),
                            Expanded(
                              child: BuildNumberField(
                                controller: maxRoomsController,
                                labelText: 'Rok budowy do'.tr,
                                filterKey: 'max_build_year',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: dynamicBoxHeight),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Material(
                                    color: Colors.transparent,
                                    child: Text('Liczba pokoi'.tr,
                                        style: AppTextStyles.interMedium
                                            .copyWith(
                                                color: AppColors.light,
                                                fontSize: 14))),
                              ],
                            ),
                            SizedBox(height: dynamicBoxHeightGroupSmall),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const FilterButton(
                                    text: '1',
                                    filterValue: '1',
                                    filterKey: 'rooms',
                                  ),
                                  SizedBox(width: dynamicSpace),
                                  const FilterButton(
                                    text: '2',
                                    filterValue: '2',
                                    filterKey: 'rooms',
                                  ),
                                  SizedBox(width: dynamicSpace),
                                  const FilterButton(
                                    text: '3',
                                    filterValue: '3',
                                    filterKey: 'rooms',
                                  ),
                                  SizedBox(width: dynamicSpace),
                                  const FilterButton(
                                    text: '4',
                                    filterValue: '4',
                                    filterKey: 'rooms',
                                  ),
                                  SizedBox(width: dynamicSpace),
                                  const FilterButton(
                                    text: '5',
                                    filterValue: '5',
                                    filterKey: 'rooms',
                                  ),
                                  SizedBox(width: dynamicSpace),
                                  const FilterButton(
                                    text: '6',
                                    filterValue: '6',
                                    filterKey: 'rooms',
                                  ),
                                  SizedBox(width: dynamicSpace),
                                  const FilterButton(
                                    text: '7+',
                                    filterValue: '7+',
                                    filterKey: 'rooms',
                                  ),
                                  SizedBox(width: dynamicSpace),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: dynamicBoxHeightGroup),
                      ],
                    ),
                  ),
                  SizedBox(height: dynamicBoxHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Text('Dodatkowe filtry'.tr,
                            style: AppTextStyles.interSemiBold
                                .copyWith(fontSize: 18)),
                      ),
                    ],
                  ),
                  SizedBox(height: dynamicBoxHeightGroupSmall),
                  Column(children: [
                    Row(
                      children: [
                         Expanded(
                          child: FilterButton(
                            text: 'Rynek pierwotny'.tr,
                            filterValue: 'new',
                            filterKey: 'market_type',
                          ),
                        ),
                        SizedBox(width: dynamicBoxHeightGroup),
                         Expanded(
                          child: FilterButton(
                            text: 'Rynek wtórny'.tr,
                            filterValue: 'use',
                            filterKey: 'market_type',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: dynamicBoxHeightGroup),
                    SizedBox(
                      child: BuildDropdownButtonFormField(
                        currentValue: currentCountry,
                        items:  [
                          'Blok'.tr,
                          'Apartamentowiec'.tr,
                          'Kamienica'.tr,
                          'Wieżowiec'.tr,
                          'Loft',
                          'Szeregowiec'.tr,
                          'Plomba'.tr
                        ],
                        labelText: 'Rodzaj zabudowy'.tr,
                        filterKey: 'building_type',
                      ),
                    ),
                    SizedBox(height: dynamicBoxHeightGroup),
                    SizedBox(
                      child: BuildDropdownButtonFormField(
                        currentValue: currentCountry,
                        items:  [
                          'Gazowe'.tr,
                          'Elektryczne'.tr,
                          'Miejskie'.tr,
                          'Pompa ciepła'.tr,
                          'Olejowe'.tr,
                          'Nie podono informacji'.tr,
                          'Wszystkie'.tr
                        ],
                        labelText: 'Rodzaj ogrzewania'.tr,
                        filterKey: 'heater_type',
                      ),
                    ),
                    SizedBox(height: dynamicBoxHeightGroup),
                    SizedBox(
                      child: BuildDropdownButtonFormField(
                        currentValue: currentCountry,
                        items:  [
                          'Dowolna'.tr,
                          'Z ostatnich 24h'.tr,
                          'Z ostatnich 3 dni'.tr,
                          'Z ostatnich 7 dni'.tr,
                          'Z ostatnich 14 dni'.tr,
                          'Z ostatnich 30 dni'.tr
                        ],
                        labelText: 'Aktualność oferty'.tr,
                        filterKey: 'aktualnosc_oferty',
                      ),
                    ),
                    SizedBox(height: dynamicBoxHeightGroup),
                    SizedBox(
                      child: BuildDropdownButtonFormField(
                        currentValue: currentCountry,
                        items:  [
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
                        labelText: 'Materiał budnku'.tr,
                        filterKey: 'building_material',
                      ),
                    ),
                    SizedBox(height: dynamicBoxHeightGroup),
                    SizedBox(
                      child: BuildDropdownButtonFormField(
                        currentValue: currentCountry,
                        items:  [
                          'Agent nieruchomości'.tr,
                          'Deweloper'.tr,
                          'osoba prywatna'.tr,
                          'Dowolna'.tr
                        ],
                        labelText: 'Ogłoszeniodawca'.tr,
                        filterKey: 'building_material',
                      ),
                    ),
                    SizedBox(height: dynamicBoxHeightGroup),
                  ]),
                  SizedBox(height: dynamicBoxHeight),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                              color: Colors.transparent,
                              child: Text('Dodatkowe informacje'.tr,
                                  style: AppTextStyles.interSemiBold16)),
                        ],
                      ),
                      SizedBox(height: dynamicBoxHeightGroup),
                       Wrap(
                        spacing: 7,
                        runSpacing: 7,
                        children: [
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
                              text: 'Garaż'.tr, filterKey: 'garage'),
                          AdditionalInfoFilterButton(
                              text: 'Klimatyzacja'.tr,
                              filterKey: 'air_conditioning'),
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
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: dynamicBoxHeight),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(filterCacheProvider.notifier).clearFilters();
                  ref.read(filterButtonProvider.notifier).clearUiFilters();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                ),
                child:
                    Text('Wyczyść filtry'.tr, style: AppTextStyles.interRegular14),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  ref.read(filterProvider.notifier).applyFiltersFromCache(
                      ref.read(filterCacheProvider.notifier),ref);
                  final String lastPage =
                      ref.read(navigationHistoryProvider.notifier).lastPage;
                  if (ref.read(navigationService).canBeamBack()) {
                    ref.read(navigationService).beamPop();
                  } else {
                    ref
                        .read(navigationService)
                        .pushNamedReplacementScreen(lastPage);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 10, bottom: 10),
                  textStyle: AppTextStyles.interSemiBold14,
                ),
                child:  Text('Zastosuj filtry'.tr),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
