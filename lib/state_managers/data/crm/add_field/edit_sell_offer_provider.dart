//edit_provider.dart
// ignore_for_file: empty_catches, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image/image.dart' as img;
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:image_picker/image_picker.dart';

// Dodajemy funkcję obliczającą cenę za metr kwadratowy
double calculatePricePerMeter(String price, String squareFootage) {
  if (price.isNotEmpty && squareFootage.isNotEmpty) {
    double priceValue = double.tryParse(price) ?? 0;
    double squareFootageValue = double.tryParse(squareFootage) ?? 0;
    if (squareFootageValue > 0) {
      return priceValue / squareFootageValue;
    }
  }
  return 0;
}

final crmEditSellOfferProvider = StateNotifierProvider.family<
    CrmEditSellOfferNotifier, CrmEditSellOfferState, int?>((ref, offerId) {
  return CrmEditSellOfferNotifier(offerId: offerId);
});

class CrmEditSellOfferNotifier extends StateNotifier<CrmEditSellOfferState> {
  CrmEditSellOfferNotifier({int? offerId,dynamic ref}) : super(CrmEditSellOfferState()) {
    if (offerId != null) {
      loadOfferData(offerId,ref);
    }
  }

  Future<void> loadOfferData(int offerId,dynamic ref) async {
    final response = await ApiServices.get(
      ref: ref,
      URLs.singleEstateAgentAdvertismentDraft('$offerId'),
      hasToken: true,
    );

    if (response != null && response.statusCode == 200) {
      var offerData = jsonDecode(utf8.decode(response.data));

      // Dla TextFormField
      state = state.copyWith(
        titleController:
            TextEditingController(text: offerData['title'].toString()),
        descriptionController:
            TextEditingController(text: offerData['description'].toString()),
        priceController:
            TextEditingController(text: offerData['price'].toString()),
        floorController:
            TextEditingController(text: offerData['floor'].toString()),
        totalFloorsController:
            TextEditingController(text: offerData['total_floors'].toString()),
        streetController: TextEditingController(text: offerData['street']),
        cityController: TextEditingController(text: offerData['city']),
        stateController: TextEditingController(text: offerData['state']),
        zipcodeController: TextEditingController(text: offerData['zipcode']),
        phoneNumberController:
            TextEditingController(text: offerData['phone_number']),
        buildYearController:
            TextEditingController(text: offerData['build_year'].toString()),
        squareFootageController:
            TextEditingController(text: offerData['square_footage'].toString()),
        lotSizeController:
            TextEditingController(text: offerData['lot_size'].toString()),
      );

      // Dla przycisków typu selectButtonsOptions
      String offerType = offerData['offer_type'];
      String offerTypeDisplayValue =
          offerType == 'sell' ? 'Chcę sprzedać' : 'Chcę wynająć';
      state = state.copyWith(
          offerTypeController:
              TextEditingController(text: offerTypeDisplayValue));

      String estateType = offerData['estate_type'];
      String estateTypeDisplayValue = '';
      if (estateType == 'Flat') {
        estateTypeDisplayValue = 'Mieszkanie';
      } else if (estateType == 'Studio') {
        estateTypeDisplayValue = 'Kawalerka';
      } else if (estateType == 'Apartment') {
        estateTypeDisplayValue = 'Apartament';
      } else if (estateType == 'House') {
        estateTypeDisplayValue = 'Dom jednorodzinny';
      } else if (estateType == 'Twin house') {
        estateTypeDisplayValue = 'Bliźniak';
      } else if (estateType == 'Row house') {
        estateTypeDisplayValue = 'Szeregowiec';
      } else if (estateType == 'Invest') {
        estateTypeDisplayValue = 'Inwestycje';
      } else if (estateType == 'Lot') {
        estateTypeDisplayValue = 'Działki';
      } else if (estateType == 'Commercial') {
        estateTypeDisplayValue = 'Lokale użytkowe';
      } else if (estateType == 'Warehouse') {
        estateTypeDisplayValue = 'Hale i magazyny';
      } else if (estateType == 'Room') {
        estateTypeDisplayValue = 'Pokoje';
      } else if (estateType == 'Garage') {
        estateTypeDisplayValue = 'Garaże';
      }
      state = state.copyWith(
          estateTypeController:
              TextEditingController(text: estateTypeDisplayValue));

      // Dla buildSelectableButtonsFormField
      String rooms = offerData['rooms'].toString();
      if (['1', '2', '3', '4', '5', '6', '7+'].contains(rooms)) {
        state =
            state.copyWith(roomsController: TextEditingController(text: rooms));
      } else {
        state =
            state.copyWith(roomsController: TextEditingController(text: ''));
      }

      String bathrooms = offerData['bathrooms'].toString();
      if (['1', '2', '3', '4', '5', '6', '7+'].contains(bathrooms)) {
        state = state.copyWith(
            bathroomsController: TextEditingController(text: bathrooms));
      } else {
        state = state.copyWith(
            bathroomsController: TextEditingController(text: ''));
      }

      // Dla DropdownButtonFormField
      String country = offerData['country'];
      if (['Polska', 'Kraj 2', 'Kraj 3'].contains(country)) {
        state = state.copyWith(
            countryController: TextEditingController(text: country));
      } else if (['Polska', 'Kraj 2', 'Kraj 3'].isNotEmpty) {
        state = state.copyWith(
            countryController: TextEditingController(text: 'Polska'));
      } else {
        state =
            state.copyWith(countryController: TextEditingController(text: ''));
      }

      String currency = offerData['currency'];
      if (['PLN', 'EUR', 'GBP', 'USD', 'CZK'].contains(currency)) {
        state = state.copyWith(
            currencyController: TextEditingController(text: currency));
      } else if (['PLN', 'EUR', 'GBP', 'USD', 'CZK'].isNotEmpty) {
        state = state.copyWith(
            currencyController: TextEditingController(text: 'PLN'));
      } else {
        state =
            state.copyWith(currencyController: TextEditingController(text: ''));
      }

      String buildingType = offerData['building_type'];
      if ([
        'Blok',
        'Apartamentowiec',
        'Szeregowiec',
        'Kamienica',
        'Wieżowiec',
        'Loft'
      ].contains(buildingType)) {
        state = state.copyWith(
            buildingTypeController: TextEditingController(text: buildingType));
      } else if ([
        'Blok',
        'Apartamentowiec',
        'Szeregowiec',
        'Kamienica',
        'Wieżowiec',
        'Loft'
      ].isNotEmpty) {
        state = state.copyWith(
            buildingTypeController: TextEditingController(text: 'Blok'));
      } else {
        state = state.copyWith(
            buildingTypeController: TextEditingController(text: ''));
      }

      String heatingType = offerData['heating_type'];
      if ([
        'Gazowe',
        'Elektryczne',
        'Miejskie',
        'Pompa ciepła',
        'Olejowe',
        'Wszystkie',
        'Nie podano informacji'
      ].contains(heatingType)) {
        state = state.copyWith(
            heatingTypeController: TextEditingController(text: heatingType));
      } else if ([
        'Gazowe',
        'Elektryczne',
        'Miejskie',
        'Pompa ciepła',
        'Olejowe',
        'Wszystkie',
        'Nie podano informacji'
      ].isNotEmpty) {
        state = state.copyWith(
            heatingTypeController: TextEditingController(text: 'Gazowe'));
      } else {
        state = state.copyWith(
            heatingTypeController: TextEditingController(text: ''));
      }

      String buildingMaterial = offerData['building_material'];
      if ([
        'Cegła',
        'Wielka płyta',
        'Silikat',
        'Beton',
        'Beton Komórkowy',
        'Pustak',
        'Żelbet',
        'Keramzyt',
        'Drewno',
        'Inne'
      ].contains(buildingMaterial)) {
        state = state.copyWith(
            buildingMaterialController:
                TextEditingController(text: buildingMaterial));
      } else if ([
        'Cegła',
        'Wielka płyta',
        'Silikat',
        'Beton',
        'Beton Komórkowy',
        'Pustak',
        'Żelbet',
        'Keramzyt',
        'Drewno',
        'Inne'
      ].isNotEmpty) {
        state = state.copyWith(
            buildingMaterialController: TextEditingController(text: 'Cegła'));
      } else {
        state = state.copyWith(
            buildingMaterialController: TextEditingController(text: ''));
      }

      // Dla przycisków typu AdditionalInfoFilterButton
      state = state.copyWith(
        balconyController: ValueNotifier<bool>(offerData['balcony']),
        terraceController: ValueNotifier<bool>(offerData['terrace']),
        saunaController: ValueNotifier<bool>(offerData['sauna']),
        jacuzziController: ValueNotifier<bool>(offerData['jacuzzi']),
        basementController: ValueNotifier<bool>(offerData['basement']),
        elevatorController: ValueNotifier<bool>(offerData['elevator']),
        gardenController: ValueNotifier<bool>(offerData['garden']),
        airConditioningController:
            ValueNotifier<bool>(offerData['air_conditioning']),
        garageController: ValueNotifier<bool>(offerData['garage']),
        parkingSpaceController: ValueNotifier<bool>(offerData['parking_space']),
      );

      // Dla zdjęć
// Dla zdjęć
      List<String> imageUrls =
          List<String>.from(jsonDecode(offerData['images']));
      List<Uint8List> imagesData = [];
      List<String> supportedImageFormats = [
        'jpg',
        'jpeg',
        'png',
        'webp',
        'bmp'
      ];

      for (String url in imageUrls) {
        final fullUrl = URLs.offerImage(url);
        final extension = fullUrl.split('.').last.toLowerCase();
        if (supportedImageFormats.contains(extension)) {
          try {
            final response = await ApiServices.get(fullUrl,ref: ref);
            if (response != null && response.statusCode == 200) {
              imagesData.add(response.data);
            }
          } catch (e) {}
        }
      }

      state = state.copyWith(imagesData: imagesData);

      // Ustawienie głównego zdjęcia
      int? mainImageIndex;
      if (offerData['main_image'] != null) {
        String mainImageUrl = offerData['main_image'];
        mainImageIndex = imageUrls.indexOf(mainImageUrl);
      }
      state = state.copyWith(mainImageIndex: mainImageIndex);
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      final List<Uint8List> newImagesData =
          await Future.wait(images.map((image) => image.readAsBytes()));
      state = state.copyWith(
          imagesData: List.from(state.imagesData)..addAll(newImagesData));
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < state.imagesData.length) {
      List<Uint8List> updatedImages = List.from(state.imagesData)
        ..removeAt(index);
      state = state.copyWith(imagesData: updatedImages);
    }
  }

  void setMainImageIndex(int index) {
    state = state.copyWith(mainImageIndex: index);
  }

  Future<void> sendData(BuildContext context, int? offerId) async {
    // Check for required fields
    if (state.titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Title, description, currency, and price are required.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    // Check for authentication
    if (ApiServices.token == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You need to be logged in to edit an advertisement.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    // Set up Dio request with authorization
    final updateUrl = URLs.updateOffer('$offerId');

    try {
      // Set up form data
      final formData = FormData.fromMap({
        'title': state.titleController.text,
        'description': state.descriptionController.text,
        'price': state.priceController.text.replaceAll(RegExp(r'\D'), ''),
        'estate_type': state.estateTypeController.text,
        'building_type': state.buildingTypeController.text,
        'floor': state.floorController.text.replaceAll(RegExp(r'\D'), ''),
        'total_floors':
            state.totalFloorsController.text.replaceAll(RegExp(r'\D'), ''),
        'currency': state.currencyController.text,
        'street': state.streetController.text,
        'phone_number':
            state.phoneNumberController.text.replaceAll(RegExp(r'\D'), ''),
        'city': state.cityController.text,
        'country': state.countryController.text,
        'state': state.stateController.text,
        'zipcode': state.zipcodeController.text.replaceAll(RegExp(r'\D'), ''),
        'rooms': state.roomsController.text.replaceAll(RegExp(r'\D'), ''),
        'heating_type': state.heatingTypeController.text,
        'build_year':
            state.buildYearController.text.replaceAll(RegExp(r'\D'), ''),
        'bathrooms':
            state.bathroomsController.text.replaceAll(RegExp(r'\D'), ''),
        'square_footage':
            state.squareFootageController.text.replaceAll(RegExp(r'\D'), ''),
        'lot_size': state.lotSizeController.text.replaceAll(RegExp(r'\D'), ''),
        'property_form': state.propertyFormController.text,
        'market_type': state.marketTypeController.text,
        'offer_type': state.offerTypeController.text,
        'building_material': state.buildingMaterialController.text,
        'balcony': state.balconyController.value.toString(),
        'terrace': state.terraceController.value.toString(),
        'sauna': state.saunaController.value.toString(),
        'jacuzzi': state.jacuzziController.value.toString(),
        'basement': state.basementController.value.toString(),
        'elevator': state.elevatorController.value.toString(),
        'garden': state.gardenController.value.toString(),
        'air_conditioning': state.airConditioningController.value.toString(),
        'garage': state.garageController.value.toString(),
        'parking_space': state.parkingSpaceController.value.toString(),
      });

      // Ensure main image is at the start of the image list
      if (state.mainImageIndex != null &&
          state.mainImageIndex! < state.imagesData.length) {
        Uint8List mainImage = state.imagesData.removeAt(state.mainImageIndex!);
        state.imagesData.insert(0, mainImage);
      }

      // Add images to form data
      for (int i = 0; i < state.imagesData.length; i++) {
        formData.files.add(
          MapEntry(
            'image$i',
            MultipartFile.fromBytes(state.imagesData[i],
                filename: 'image$i.jpg'),
          ),
        );
      }

      // Send request
      final response = await ApiServices.put(
        updateUrl,
        formData: formData,
        hasToken: true,
      );

      // Handle response
      if (response != null && response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Advertisement updated successfully.'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update advertisement: ${response}'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to update advertisement: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }
}

class CrmEditSellOfferState {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController floorController;
  final TextEditingController totalFloorsController;
  final TextEditingController streetController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipcodeController;
  final TextEditingController roomsController;
  final TextEditingController bathroomsController;
  final TextEditingController squareFootageController;
  final TextEditingController lotSizeController;
  final TextEditingController estateTypeController;
  final TextEditingController buildingTypeController;
  final TextEditingController currencyController;
  final TextEditingController propertyFormController;
  final TextEditingController marketTypeController;
  final TextEditingController offerTypeController;
  final TextEditingController countryController;
  final TextEditingController phoneNumberController;
  final TextEditingController heatingTypeController;
  final TextEditingController buildYearController;
  final TextEditingController buildingMaterialController;
  final List<Uint8List> imagesData;
  final int? mainImageIndex;
  final ValueNotifier<bool> balconyController;
  final ValueNotifier<bool> terraceController;
  final ValueNotifier<bool> saunaController;
  final ValueNotifier<bool> jacuzziController;
  final ValueNotifier<bool> basementController;
  final ValueNotifier<bool> elevatorController;
  final ValueNotifier<bool> gardenController;
  final ValueNotifier<bool> airConditioningController;
  final ValueNotifier<bool> garageController;
  final ValueNotifier<bool> parkingSpaceController;
  final int? editedOfferId;

  CrmEditSellOfferState({
    this.imagesData = const [],
    this.mainImageIndex,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    TextEditingController? priceController,
    TextEditingController? floorController,
    TextEditingController? totalFloorsController,
    TextEditingController? streetController,
    TextEditingController? cityController,
    TextEditingController? stateController,
    TextEditingController? zipcodeController,
    TextEditingController? roomsController,
    TextEditingController? bathroomsController,
    TextEditingController? squareFootageController,
    TextEditingController? phoneNumberController,
    TextEditingController? lotSizeController,
    TextEditingController? estateTypeController,
    TextEditingController? buildingTypeController,
    TextEditingController? buildingMaterialController,
    TextEditingController? currencyController,
    TextEditingController? propertyFormController,
    TextEditingController? marketTypeController,
    TextEditingController? offerTypeController,
    TextEditingController? countryController,
    TextEditingController? buildYearController,
    TextEditingController? heatingTypeController,
    ValueNotifier<bool>? balconyController,
    ValueNotifier<bool>? terraceController,
    ValueNotifier<bool>? saunaController,
    ValueNotifier<bool>? jacuzziController,
    ValueNotifier<bool>? basementController,
    ValueNotifier<bool>? elevatorController,
    ValueNotifier<bool>? gardenController,
    ValueNotifier<bool>? airConditioningController,
    ValueNotifier<bool>? garageController,
    ValueNotifier<bool>? parkingSpaceController,
    this.editedOfferId,
  })  : titleController = titleController ?? TextEditingController(),
        descriptionController =
            descriptionController ?? TextEditingController(),
        priceController = priceController ?? TextEditingController(),
        floorController = floorController ?? TextEditingController(),
        totalFloorsController =
            totalFloorsController ?? TextEditingController(),
        streetController = streetController ?? TextEditingController(),
        cityController = cityController ?? TextEditingController(),
        countryController = countryController ?? TextEditingController(),
        stateController = stateController ?? TextEditingController(),
        zipcodeController = zipcodeController ?? TextEditingController(),
        roomsController = roomsController ?? TextEditingController(),
        bathroomsController = bathroomsController ?? TextEditingController(),
        squareFootageController =
            squareFootageController ?? TextEditingController(),
        lotSizeController = lotSizeController ?? TextEditingController(),
        estateTypeController = estateTypeController ?? TextEditingController(),
        buildingTypeController =
            buildingTypeController ?? TextEditingController(),
        currencyController = currencyController ?? TextEditingController(),
        propertyFormController =
            propertyFormController ?? TextEditingController(),
        marketTypeController = marketTypeController ?? TextEditingController(),
        phoneNumberController =
            phoneNumberController ?? TextEditingController(),
        buildYearController = buildYearController ?? TextEditingController(),
        heatingTypeController =
            heatingTypeController ?? TextEditingController(),
        buildingMaterialController =
            buildingMaterialController ?? TextEditingController(),
        offerTypeController = offerTypeController ?? TextEditingController(),
        balconyController = balconyController ?? ValueNotifier<bool>(false),
        terraceController = terraceController ?? ValueNotifier<bool>(false),
        saunaController = saunaController ?? ValueNotifier<bool>(false),
        jacuzziController = jacuzziController ?? ValueNotifier<bool>(false),
        basementController = basementController ?? ValueNotifier<bool>(false),
        elevatorController = elevatorController ?? ValueNotifier<bool>(false),
        gardenController = gardenController ?? ValueNotifier<bool>(false),
        airConditioningController =
            airConditioningController ?? ValueNotifier<bool>(false),
        garageController = garageController ?? ValueNotifier<bool>(false),
        parkingSpaceController =
            parkingSpaceController ?? ValueNotifier<bool>(false);

  CrmEditSellOfferState copyWith({
    List<Uint8List>? imagesData,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    TextEditingController? priceController,
    TextEditingController? floorController,
    TextEditingController? totalFloorsController,
    TextEditingController? streetController,
    TextEditingController? cityController,
    TextEditingController? stateController,
    TextEditingController? zipcodeController,
    TextEditingController? roomsController,
    TextEditingController? bathroomsController,
    TextEditingController? squareFootageController,
    TextEditingController? lotSizeController,
    TextEditingController? estateTypeController,
    TextEditingController? buildingTypeController,
    TextEditingController? currencyController,
    TextEditingController? propertyFormController,
    TextEditingController? marketTypeController,
    TextEditingController? offerTypeController,
    TextEditingController? countryController,
    TextEditingController? phoneNumberController,
    TextEditingController? buildYearController,
    TextEditingController? heatingTypeController,
    TextEditingController? buildingMaterialController,
    int? mainImageIndex,
    ValueNotifier<bool>? balconyController,
    ValueNotifier<bool>? terraceController,
    ValueNotifier<bool>? saunaController,
    ValueNotifier<bool>? jacuzziController,
    ValueNotifier<bool>? basementController,
    ValueNotifier<bool>? elevatorController,
    ValueNotifier<bool>? gardenController,
    ValueNotifier<bool>? airConditioningController,
    ValueNotifier<bool>? garageController,
    ValueNotifier<bool>? parkingSpaceController,
  }) {
    return CrmEditSellOfferState(
      imagesData: imagesData ?? this.imagesData,
      mainImageIndex: mainImageIndex ?? mainImageIndex,
      titleController: titleController ?? this.titleController,
      descriptionController:
          descriptionController ?? this.descriptionController,
      priceController: priceController ?? this.priceController,
      floorController: floorController ?? this.floorController,
      totalFloorsController:
          totalFloorsController ?? this.totalFloorsController,
      streetController: streetController ?? this.streetController,
      cityController: cityController ?? this.cityController,
      stateController: stateController ?? this.stateController,
      zipcodeController: zipcodeController ?? this.zipcodeController,
      roomsController: roomsController ?? this.roomsController,
      bathroomsController: bathroomsController ?? this.bathroomsController,
      squareFootageController:
          squareFootageController ?? this.squareFootageController,
      lotSizeController: lotSizeController ?? this.lotSizeController,
      estateTypeController: estateTypeController ?? this.estateTypeController,
      buildingTypeController:
          buildingTypeController ?? this.buildingTypeController,
      currencyController: currencyController ?? this.currencyController,
      propertyFormController:
          propertyFormController ?? this.propertyFormController,
      marketTypeController: marketTypeController ?? this.marketTypeController,
      offerTypeController: offerTypeController ?? this.offerTypeController,
      countryController: countryController ?? this.countryController,
      phoneNumberController:
          phoneNumberController ?? this.phoneNumberController,
      buildYearController: buildYearController ?? this.buildYearController,
      heatingTypeController:
          heatingTypeController ?? this.heatingTypeController,
      buildingMaterialController:
          buildingMaterialController ?? this.buildingMaterialController,
      balconyController: balconyController ?? this.balconyController,
      terraceController: terraceController ?? this.terraceController,
      saunaController: saunaController ?? this.saunaController,
      jacuzziController: jacuzziController ?? this.jacuzziController,
      basementController: basementController ?? this.basementController,
      elevatorController: elevatorController ?? this.elevatorController,
      gardenController: gardenController ?? this.gardenController,
      airConditioningController:
          airConditioningController ?? this.airConditioningController,
      garageController: garageController ?? this.garageController,
      parkingSpaceController:
          parkingSpaceController ?? this.parkingSpaceController,
    );
  }
}
