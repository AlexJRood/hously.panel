import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/buy_filter_provider.dart';


class AgentBuyOfferControllers {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController tagsController;



  final TextEditingController searchController;

  final TextEditingController searchRadiusController;
  final TextEditingController excludeController;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final TextEditingController minPricePerMeterController;
  final TextEditingController maxPricePerMeterController;
  final TextEditingController minRoomsController;
  final TextEditingController maxRoomsController;
  final TextEditingController minBathroomsController;
  final TextEditingController maxBathroomsController;
  final TextEditingController minSquareFootageController;
  final TextEditingController maxSquareFootageController;
  final TextEditingController minLotSizeController;
  final TextEditingController maxLotSizeController;
  final TextEditingController currencyController;
  final TextEditingController estateTypeController;
  final TextEditingController buildingTypeController;
  final TextEditingController countryController;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipcodeController;
  final TextEditingController propertyFormController;
  final TextEditingController marketTypeController;
  final TextEditingController offerTypeController;

  final ScrollController scrollController;

  AgentBuyOfferControllers(Ref ref)
      :
        titleController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['title'] ?? ''),
        descriptionController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['description'] ?? ''),
        tagsController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['tags'] ?? ''),        
        searchController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['search_query'] ?? ''),


        searchRadiusController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['search_radius'] ?? ''), 
        excludeController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['exclude'] ?? ''),
        minPriceController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['min_price']?.toString() ?? ''),
        maxPriceController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['max_price']?.toString() ?? ''),
        minPricePerMeterController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['min_price_per_meter']?.toString() ?? ''),
        maxPricePerMeterController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['max_price_per_meter']?.toString() ?? ''),
        minRoomsController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['min_rooms']?.toString() ?? ''),
        maxRoomsController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['max_rooms']?.toString() ?? ''),

        minBathroomsController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['min_bathrooms']?.toString() ?? ''),
        maxBathroomsController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['max_bathrooms']?.toString() ?? ''),

        minSquareFootageController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['min_square_footage']?.toString() ?? ''),
        maxSquareFootageController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['max_square_footage']?.toString() ?? ''),

        minLotSizeController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['min_lot_size']?.toString() ?? ''),
        maxLotSizeController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['max_lot_size']?.toString() ?? ''),
        currencyController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['currency'] ?? ''),
        estateTypeController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['estate_type'] ?? ''),
        buildingTypeController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['building_type'] ?? ''),
        streetController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['street'] ?? ''),
        cityController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['city'] ?? ''),
        stateController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['state'] ?? ''),
        zipcodeController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['zipcode'] ?? ''),
        propertyFormController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['property_form'] ?? ''),
        marketTypeController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['market_type'] ?? ''),
        offerTypeController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['offer_type'] ?? ''),
        countryController = TextEditingController(text: ref.read(buyOfferFilterCacheProvider)['filters']?['country'] ?? ''),
        scrollController = ScrollController();

  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    tagsController.dispose();
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
  }
}

final buySearchControllersProvider = Provider<AgentBuyOfferControllers>((ref) {
  final controllers = AgentBuyOfferControllers(ref);
  ref.onDispose(controllers.dispose);
  return controllers;
});




//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
/////////////////////// How to use that //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
///class MyFilterScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controllers = ref.watch(filterControllersProvider);

//     return TextField(
//       controller: controllers.searchController,
//       decoration: InputDecoration(labelText: "Search"),
//     );
//   }
// }
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

