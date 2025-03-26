import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/utils/api_services.dart';

final selectedTabProvider = StateProvider<String>((ref) => 'VIEW');

class AddClientFormState {
  // Client
  final TextEditingController clientNameController;
  final TextEditingController clientLastNameController;
  final TextEditingController clientPhoneNumberController;
  final TextEditingController clientEmailController;
  final TextEditingController clientDescriptionController;
  final TextEditingController clientNoteController;

  // Transaction
  final ValueNotifier<bool> transactionIsSellerController;
  final ValueNotifier<bool> transactionIsBuyerController;
  final TextEditingController transactionNameController;
  final TextEditingController transactionCommissionController;
  final TextEditingController transactionAmountController;
  final TextEditingController transactionCurrencyController;
  final TextEditingController transactionTypeController;
  final TextEditingController transactionPaymentDateController;
  final TextEditingController transactionNoteController;

  // Saved Search
  final TextEditingController savedSearchTitleController;
  final TextEditingController savedSearchDescriptionController;
  final TextEditingController savedSearchTagsController;
  final TextEditingController savedSearchSearchQueryController;
  final TextEditingController savedSearchPriceMinController;
  final TextEditingController savedSearchPriceMaxController;
  final TextEditingController savedSearchRoomsController;

  // Draft
  final TextEditingController draftTitleController;
  final TextEditingController draftPriceController;
  final TextEditingController draftCurrencyController;
  final TextEditingController draftDescriptionController;
  final TextEditingController draftStreetController;
  final TextEditingController draftCityController;
  final TextEditingController draftStateController;
  final TextEditingController draftCountryController;
  final TextEditingController draftRoomsController;
  final TextEditingController draftBathroomsController;
  final TextEditingController draftSquareFootageController;
  final TextEditingController draftOfferTypeController;
  final List<Uint8List> imagesData;

  // Event
  final TextEditingController eventTitleController;
  final TextEditingController eventDescriptionController;
  final TextEditingController eventLocationController;

  final bool isLoading;
  final String? errorMessage;
  final bool success;

  AddClientFormState({
    this.imagesData = const [],
    // Client
    TextEditingController? clientNameController,
    TextEditingController? clientLastNameController,
    TextEditingController? clientPhoneNumberController,
    TextEditingController? clientEmailController,
    TextEditingController? clientDescriptionController,
    TextEditingController? clientNoteController,

    // Transaction
    ValueNotifier<bool>? transactionIsSellerController,
    ValueNotifier<bool>? transactionIsBuyerController,
    TextEditingController? transactionNameController,
    TextEditingController? transactionCommissionController,
    TextEditingController? transactionAmountController,
    TextEditingController? transactionCurrencyController,
    TextEditingController? transactionTypeController,
    TextEditingController? transactionPaymentDateController,
    TextEditingController? transactionNoteController,

    // Saved Search
    TextEditingController? savedSearchTitleController,
    TextEditingController? savedSearchDescriptionController,
    TextEditingController? savedSearchTagsController,
    TextEditingController? savedSearchSearchQueryController,
    TextEditingController? savedSearchPriceMinController,
    TextEditingController? savedSearchPriceMaxController,
    TextEditingController? savedSearchRoomsController,

    // Draft
    TextEditingController? draftTitleController,
    TextEditingController? draftPriceController,
    TextEditingController? draftCurrencyController,
    TextEditingController? draftDescriptionController,
    TextEditingController? draftStreetController,
    TextEditingController? draftCityController,
    TextEditingController? draftStateController,
    TextEditingController? draftCountryController,
    TextEditingController? draftRoomsController,
    TextEditingController? draftBathroomsController,
    TextEditingController? draftSquareFootageController,
    TextEditingController? draftOfferTypeController,

    // Event
    TextEditingController? eventTitleController,
    TextEditingController? eventDescriptionController,
    TextEditingController? eventLocationController,
    this.isLoading = false,
    this.errorMessage,
    this.success = false,
  })  :
        // Client
        clientNameController = clientNameController ?? TextEditingController(),
        clientLastNameController =
            clientLastNameController ?? TextEditingController(),
        clientPhoneNumberController =
            clientPhoneNumberController ?? TextEditingController(),
        clientEmailController =
            clientEmailController ?? TextEditingController(),
        clientDescriptionController =
            clientDescriptionController ?? TextEditingController(),
        clientNoteController = clientNoteController ?? TextEditingController(),

        // Transaction
        transactionIsSellerController =
            transactionIsSellerController ?? ValueNotifier(false),
        transactionIsBuyerController =
            transactionIsBuyerController ?? ValueNotifier(false),
        transactionNameController =
            transactionNameController ?? TextEditingController(),
        transactionCommissionController =
            transactionCommissionController ?? TextEditingController(),
        transactionAmountController =
            transactionAmountController ?? TextEditingController(),
        transactionCurrencyController =
            transactionCurrencyController ?? TextEditingController(),
        transactionTypeController =
            transactionTypeController ?? TextEditingController(),
        transactionPaymentDateController =
            transactionPaymentDateController ?? TextEditingController(),
        transactionNoteController =
            transactionNoteController ?? TextEditingController(),

        // Saved Search
        savedSearchTitleController =
            savedSearchTitleController ?? TextEditingController(),
        savedSearchDescriptionController =
            savedSearchDescriptionController ?? TextEditingController(),
        savedSearchTagsController =
            savedSearchTagsController ?? TextEditingController(),
        savedSearchSearchQueryController =
            savedSearchSearchQueryController ?? TextEditingController(),
        savedSearchPriceMinController =
            savedSearchPriceMinController ?? TextEditingController(),
        savedSearchPriceMaxController =
            savedSearchPriceMaxController ?? TextEditingController(),
        savedSearchRoomsController =
            savedSearchRoomsController ?? TextEditingController(),

        // Draft
        draftTitleController = draftTitleController ?? TextEditingController(),
        draftPriceController = draftPriceController ?? TextEditingController(),
        draftCurrencyController =
            draftCurrencyController ?? TextEditingController(),
        draftDescriptionController =
            draftDescriptionController ?? TextEditingController(),
        draftStreetController =
            draftStreetController ?? TextEditingController(),
        draftCityController = draftCityController ?? TextEditingController(),
        draftStateController = draftStateController ?? TextEditingController(),
        draftCountryController =
            draftCountryController ?? TextEditingController(),
        draftRoomsController = draftRoomsController ?? TextEditingController(),
        draftBathroomsController =
            draftBathroomsController ?? TextEditingController(),
        draftSquareFootageController =
            draftSquareFootageController ?? TextEditingController(),
        draftOfferTypeController =
            draftOfferTypeController ?? TextEditingController(),

        // Event
        eventTitleController = eventTitleController ?? TextEditingController(),
        eventDescriptionController =
            eventDescriptionController ?? TextEditingController(),
        eventLocationController =
            eventLocationController ?? TextEditingController();

  /// CopyWith Method - Ensures TextEditingController instances are not replaced
  AddClientFormState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? success,
    List<Uint8List>? imagesData,
  }) {
    return AddClientFormState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      success: success ?? this.success,
      imagesData: imagesData ?? this.imagesData,

      // Use the existing controllers
      clientNameController: clientNameController,
      clientLastNameController: clientLastNameController,
      clientPhoneNumberController: clientPhoneNumberController,
      clientEmailController: clientEmailController,
      clientDescriptionController: clientDescriptionController,
      clientNoteController: clientNoteController,

      transactionIsSellerController: transactionIsSellerController,
      transactionIsBuyerController: transactionIsBuyerController,
      transactionNameController: transactionNameController,
      transactionCommissionController: transactionCommissionController,
      transactionAmountController: transactionAmountController,
      transactionCurrencyController: transactionCurrencyController,
      transactionTypeController: transactionTypeController,
      transactionPaymentDateController: transactionPaymentDateController,
      transactionNoteController: transactionNoteController,

      savedSearchTitleController: savedSearchTitleController,
      savedSearchDescriptionController: savedSearchDescriptionController,
      savedSearchTagsController: savedSearchTagsController,
      savedSearchSearchQueryController: savedSearchSearchQueryController,
      savedSearchPriceMinController: savedSearchPriceMinController,
      savedSearchPriceMaxController: savedSearchPriceMaxController,
      savedSearchRoomsController: savedSearchRoomsController,

      draftTitleController: draftTitleController,
      draftPriceController: draftPriceController,
      draftCurrencyController: draftCurrencyController,
      draftDescriptionController: draftDescriptionController,
      draftStreetController: draftStreetController,
      draftCityController: draftCityController,
      draftStateController: draftStateController,
      draftCountryController: draftCountryController,
      draftRoomsController: draftRoomsController,
      draftBathroomsController: draftBathroomsController,
      draftSquareFootageController: draftSquareFootageController,
      draftOfferTypeController: draftOfferTypeController,

      eventTitleController: eventTitleController,
      eventDescriptionController: eventDescriptionController,
      eventLocationController: eventLocationController,
    );
  }
}

class AddClientFormNotifier extends StateNotifier<AddClientFormState> {
  AddClientFormNotifier() : super(AddClientFormState());

  void updateTextField(TextEditingController controller, String value) {
    controller.value = controller.value.copyWith(
      text: value,
      selection: TextSelection.collapsed(
          offset: value.length), // Maintain cursor position
    );
    print(value);
  }

  Future<void> sellTransAction() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final requestBody = {
        "client": {
          "name": state.clientNameController.text,
          "last_name": state.clientLastNameController.text,
          "email": state.clientEmailController.text,
          "phone_number": state.clientPhoneNumberController.text,
          "description": state.clientDescriptionController.text,
          "note": state.clientNoteController.text
        },
        "draft": {
          "title": state.draftTitleController.text,
          "price": int.tryParse(state.draftPriceController.text) ?? 0,
          "currency": state.draftCurrencyController.text,
          "description": state.draftDescriptionController.text,
          "street": state.draftStreetController.text,
          "city": state.draftCityController.text,
          "state": state.draftStateController.text,
          "country": state.draftCountryController.text,
          "rooms": int.tryParse(state.draftRoomsController.text) ?? 0,
          "bathrooms": int.tryParse(state.draftBathroomsController.text) ?? 0,
          "square_footage": state.draftSquareFootageController.text,
          "offer_type": state.draftOfferTypeController.text,
          "images": state.imagesData
        },
        "event": {
          "title": state.eventTitleController.text.isEmpty
              ? 'Meeting with Buyer'
              : state.eventTitleController.text,
          "description": state.eventDescriptionController.text.isEmpty
              ? 'Discussing contract details.'
              : state.eventDescriptionController.text,
          "location": state.eventLocationController.text.isEmpty
              ? 'Main Office'
              : state.eventLocationController.text
        },
        "transaction": {
          "is_seller": state.transactionIsSellerController.value,
          "is_buyer": state.transactionIsBuyerController.value,
          "name": state.transactionNameController.text,
          "commission":
              int.tryParse(state.transactionCommissionController.text) ?? 0,
          "amount": int.tryParse(state.transactionAmountController.text) ?? 0,
          "currency": state.transactionCurrencyController.text,
          "transaction_type": state.transactionTypeController.text,
          "note": state.transactionNoteController.text
        }
      };
      print(requestBody);

      final response = await ApiServices.post(
        URLs.sellTransAction,
        hasToken: true,
        data: requestBody,
      );

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        state = state.copyWith(success: true);
        print('✅ Sell transaction added successfully');
        print('Response Data: ${jsonEncode(response.data)}');
      } else {
        state = state.copyWith(errorMessage: 'Failed to add sell transaction');
        print('❌ Failed to add sell transaction');
      }
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error: $e');
      print('⚠️ Error while adding sell transaction: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> buyTransAction() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final requestBody = {
        "client": {
          "name": state.clientNameController.text,
          "last_name": state.clientLastNameController.text,
          "email": state.clientEmailController.text,
          "phone_number": state.clientPhoneNumberController.text,
          "description": state.clientDescriptionController.text,
          "note": state.clientNoteController.text
        },
        "transaction": {
          "is_seller": state.transactionIsSellerController.value,
          "is_buyer": state.transactionIsBuyerController.value,
          "name": state.transactionNameController.text,
          "commission":
              int.tryParse(state.transactionCommissionController.text) ?? 0,
          "amount": int.tryParse(state.transactionAmountController.text) ?? 0,
          "currency": state.transactionCurrencyController.text,
          "transaction_type": state.transactionTypeController.text,
          "note": state.transactionNoteController.text
        },
        "saved_search": {
          "title": "Modern Apartments in Downtown",
          "description": "Looking for modern apartments in the city center.",
          "tags": "apartment, downtown",
          "search_query": "apartment AND downtown",
          "filters": {
            "price_min": 1000,
            "price_max": 100000,
            "rooms": int.tryParse(state.savedSearchRoomsController.text) ?? 1
          }
        },
        "event": {
          "title": state.eventTitleController.text.isEmpty
              ? 'Meeting with Buyer'
              : state.eventTitleController.text,
          "description": state.eventDescriptionController.text.isEmpty
              ? 'Discussing contract details.'
              : state.eventDescriptionController.text,
          "location": state.eventLocationController.text.isEmpty
              ? 'Main Office'
              : state.eventLocationController.text
        }
      };
      print(requestBody);

      final response = await ApiServices.post(
        URLs.buyTransAction,
        hasToken: true,
        data: requestBody,
      );

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        state = state.copyWith(success: true);
        print('✅ Buy transaction added successfully');
      } else {
        state = state.copyWith(errorMessage: 'Failed to add buy transaction');
        print('❌ Failed to add buy transaction');
      }
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error: $e');
      print('⚠️ Error while adding buy transaction: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> estateViewing() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final requestBody = {
        "client": {
          "name": state.clientNameController.text,
          "last_name": state.clientLastNameController.text,
          "email": state.clientEmailController.text,
          "phone_number": state.clientPhoneNumberController.text,
          "description": state.clientDescriptionController.text,
          "note": state.clientNoteController.text
        },
        "event": {
          "title": state.eventTitleController.text.isEmpty
              ? 'Meeting with Buyer'
              : state.eventTitleController.text,
          "description": state.eventDescriptionController.text.isEmpty
              ? 'Discussing contract details.'
              : state.eventDescriptionController.text,
          "location": state.eventLocationController.text.isEmpty
              ? 'Main Office'
              : state.eventLocationController.text
        }
      };
      print(requestBody);

      final response = await ApiServices.post(
        URLs.estateViewing,
        hasToken: true,
        data: requestBody,
      );

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        state = state.copyWith(success: true);
        print('✅ Estate viewing added successfully');
      } else {
        state = state.copyWith(errorMessage: 'Failed to add estate viewing');
        print('❌ Failed to add estate viewing');
      }
    } catch (e) {
      state = state.copyWith(errorMessage: 'Error: $e');
      print('⚠️ Error while adding estate viewing: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void clearForm() {
    // Clear Client Fields
    state.clientNameController.clear();
    state.clientLastNameController.clear();
    state.clientPhoneNumberController.clear();
    state.clientEmailController.clear();
    state.clientDescriptionController.clear();
    state.clientNoteController.clear();

    // Clear Transaction Fields
    state.transactionNameController.clear();
    state.transactionCommissionController.clear();
    state.transactionAmountController.clear();
    state.transactionCurrencyController.clear();
    state.transactionTypeController.clear();
    state.transactionPaymentDateController.clear();
    state.transactionNoteController.clear();
    state.transactionIsSellerController.value = false;
    state.transactionIsBuyerController.value = false;

    // Clear Saved Search Fields
    state.savedSearchTitleController.clear();
    state.savedSearchDescriptionController.clear();
    state.savedSearchTagsController.clear();
    state.savedSearchSearchQueryController.clear();
    state.savedSearchPriceMinController.clear();
    state.savedSearchPriceMaxController.clear();
    state.savedSearchRoomsController.clear();

    // Clear Draft Fields
    state.draftTitleController.clear();
    state.draftPriceController.clear();
    state.draftCurrencyController.clear();
    state.draftDescriptionController.clear();
    state.draftStreetController.clear();
    state.draftCityController.clear();
    state.draftStateController.clear();
    state.draftCountryController.clear();
    state.draftRoomsController.clear();
    state.draftBathroomsController.clear();
    state.draftSquareFootageController.clear();
    state.draftOfferTypeController.clear();

    // Clear Event Fields
    state.eventTitleController.clear();
    state.eventDescriptionController.clear();
    state.eventLocationController.clear();

    // Reset State
    state = state.copyWith(
      imagesData: [],
      success: false,
      errorMessage: null,
    );
  }
}

final addClientFormProvider =
    StateNotifierProvider<AddClientFormNotifier, AddClientFormState>(
  (ref) => AddClientFormNotifier(),
);
