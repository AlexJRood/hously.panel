import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/screens/add_client_form/provider/buy_filter_provider.dart';
import 'package:hously_flutter/screens/add_client_form/provider/sell_estate_data_provider.dart';
import 'package:hously_flutter/screens/add_client_form/provider/transaction_provider.dart';
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
  final int? selectedClientId;

  // draft
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
    TextEditingController? transactionTitleController,
    TextEditingController? clientDescriptionController,
    TextEditingController? clientNoteController,

    // Event
    TextEditingController? eventTitleController,
    TextEditingController? eventDescriptionController,
    TextEditingController? eventLocationController,
    this.selectedClientId,
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
    int? selectedClientId,

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

      eventTitleController: eventTitleController,
      eventDescriptionController: eventDescriptionController,
      eventLocationController: eventLocationController,
      selectedClientId: selectedClientId ?? this.selectedClientId,
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

    void setSelectedClientId(int? clientId) {
    state = state.copyWith(selectedClientId: clientId);
  }


Future<void> sellTransAction(WidgetRef ref) async {
  try {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final sellOfferDraftData = ref.read(sellOfferFilterCacheProvider);
    final transactionData = ref.read(agentTransactionCacheProvider);

    // Sprawdzamy, czy mamy wybranego klienta przez ID:
    final clientId = state.selectedClientId;

    final requestBody = {
      if (clientId != null)
        "client": clientId
      else
        "client": {
          "name": state.clientNameController.text,
          "last_name": state.clientLastNameController.text,
          "email": state.clientEmailController.text,
          "phone_number": state.clientPhoneNumberController.text,
          "description": state.clientDescriptionController.text,
          "note": state.clientNoteController.text,
        },
      "draft": sellOfferDraftData['draft'] ?? {},
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
      "transaction": transactionData['transaction'] ?? {},
    };

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
















Future<void> buyTransAction(WidgetRef ref) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);


      final savedSearchFilters = ref.read(buyOfferFilterCacheProvider);
      final transactionData = ref.read(agentTransactionCacheProvider);

      // Sprawdzamy, czy mamy wybranego klienta przez ID:
      final clientId = state.selectedClientId;

      final requestBody = {
        if (clientId != null)
          "client": clientId
        else
          "client": {
            "name": state.clientNameController.text,
            "last_name": state.clientLastNameController.text,
            "email": state.clientEmailController.text,
            "phone_number": state.clientPhoneNumberController.text,
            "description": state.clientDescriptionController.text,
            "note": state.clientNoteController.text,
          },
        "transaction": transactionData['transaction'] ?? {},
        "saved_search": savedSearchFilters,
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

        // Sprawdzamy, czy mamy wybranego klienta przez ID:
        final clientId = state.selectedClientId;

        final requestBody = {
          if (clientId != null)
            "client": clientId
          else
            "client": {
              "name": state.clientNameController.text,
              "last_name": state.clientLastNameController.text,
              "email": state.clientEmailController.text,
              "phone_number": state.clientPhoneNumberController.text,
              "description": state.clientDescriptionController.text,
              "note": state.clientNoteController.text,
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
    // state.clientNameController.clear();
    // state.clientLastNameController.clear();
    // state.clientPhoneNumberController.clear();
    // state.clientEmailController.clear();
    // state.clientDescriptionController.clear();
    // state.clientNoteController.clear();

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
