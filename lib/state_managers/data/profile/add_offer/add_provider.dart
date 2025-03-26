//Riverpod/add_provider.dart

// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

final addOfferProvider =
    StateNotifierProvider<AddOfferNotifier, AddOfferState>((ref) {
  return AddOfferNotifier();
});

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

class AddOfferNotifier extends StateNotifier<AddOfferState> {
  AddOfferNotifier() : super(AddOfferState());

  final SecureStorage secureStorage =
      SecureStorage(); // Create an instance of SecureStorage
  late DropzoneViewController dropzoneController;

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        final List<Uint8List> newImagesData =
        await Future.wait(images.map((image) => image.readAsBytes()));
        state = state.copyWith(
          imagesData: List.from(state.imagesData)..addAll(newImagesData),
        );
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Future<void> handleFileDrop(dynamic file, DropzoneViewController controller) async {
    try {
      if (file != null) {
        final bytes = await controller.getFileData(file);

        state = state.copyWith(
          imagesData: List.from(state.imagesData)..add(bytes),
        );
      } else {
        print("No file dropped.");
      }
    } catch (e) {
      print("Error handling dropped file: $e");
    }
  }


  //   Future<void> pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final List<XFile>? images = await picker.pickMultiImage();
  //   if (images != null && images.isNotEmpty) {
  //     final List<Uint8List> newImagesData = await Future.wait(images.map((image) => image.readAsBytes()));
  //     state = state.copyWith(imagesData: List.from(state.imagesData)..addAll(newImagesData));
  //   }
  // }

  void removeImage(int index) {
    if (index >= 0 && index < state.imagesData.length) {
      List<Uint8List> updatedImages = List.from(state.imagesData)
        ..removeAt(index);
      state = state.copyWith(imagesData: updatedImages);
    }
  }

  void setMainImageIndex(int index) {
    state = state.copyWith(mainImageIndex: index);
    print('mainimageindex:${state.mainImageIndex}');
    print('imagelength:${state.imagesData.length}');
    Uint8List temp = state.imagesData[0];
    state.imagesData[0] = state.imagesData[state.mainImageIndex!];
    state.imagesData[state.mainImageIndex!] = temp;
  }

  Future<void> sendData(BuildContext context, WidgetRef ref) async {
    if (state.titleController.text.isEmpty) {
      final snackBar = Customsnackbar().showSnackBar(
          "Warning", "description, currency and price are required.", "warning",
          () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    if (ApiServices.token == null) {
      final snackBar = Customsnackbar().showSnackBar(
          "Not logged in", "you need to login to post an ad", "warning", () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      ref.read(navigationService).pushNamedScreen(Routes.loginPop);

      return;
    }

    state = state.copyWith(isLoading: true, statusMessages: ['Checking data']);

    try {
      state = state
          .copyWith(statusMessages: ['Checking data', 'Compressing images']);

      double pricePerMeter = calculatePricePerMeter(
        state.priceController.text,
        state.squareFootageController.text,
      );

      final formData = FormData.fromMap({
        'title': state.titleController.text,
        'description': state.descriptionController.text,
        'price': state.priceController.text.replaceAll(RegExp(r'\D'), ''),
        'estate_type': state.estateTypeController.text,
        'building_type': state.buildingTypeController.text,
        'price_per_meter': pricePerMeter.toString(),
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

      formData.files.addAll(
        state.imagesData.map((imageData) {
          return MapEntry(
            'images',
            MultipartFile.fromBytes(
              imageData,
              filename: 'image${state.imagesData.indexOf(imageData)}.jpg',
            ),
          );
        }),
      );
      state = state.copyWith(statusMessages: [
        'Checking data',
        'Compressing images',
        'Sending data to server'
      ]);

      final response = await ApiServices.post(
        URLs.addAdvertisement,
        hasToken: true,
        formData: formData,
      );

      if (response != null && response.statusCode == 201) {
        final snackBar = Customsnackbar().showSnackBar(
            "success", "Advertisement added successfully", "success", () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        ref.read(navigationService).pushNamedScreen(Routes.profile);
      } else {
        throw Exception('Failed to add advertisement');
      }
    } catch (e) {
      final snackBar = Customsnackbar().showSnackBar(
          "Error",
          " an Error has occured while sending data please retry ",
          "error", () {
        sendData(context, ref);
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

class AddOfferState {
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
  final bool isLoading; // Dodaj to pole
  final List<String> statusMessages; // Dodaj to pole

  AddOfferState({
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
    this.isLoading = false, // Domyślnie ustaw na false
    this.statusMessages = const [], // Dodaj to pole
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

  AddOfferState copyWith({
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
    bool? isLoading, // Dodaj to pole
    List<String>? statusMessages, // Dodaj to pole
  }) {
    return AddOfferState(
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
      isLoading: isLoading ?? this.isLoading, // Dodaj to pole
      statusMessages: statusMessages ?? this.statusMessages, // Dodaj to pole
    );
  }
}

class DropdownButtonFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final List<String> items;
  final String labelText;
  final WidgetRef ref;
  final String? Function(String?)? validator;

  const DropdownButtonFormFieldWidget({
    Key? key,
    required this.controller,
    required this.items,
    required this.labelText,
    required this.ref,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access theme providers
    final currentThemeMode = ref.watch(themeProvider);

    final backgroundColor = currentThemeMode == ThemeMode.system
        ? AppColors.light
        : currentThemeMode == ThemeMode.light
            ? AppColors.light
            : AppColors.dark;

    final textColor = currentThemeMode == ThemeMode.system
        ? AppColors.textColorDark
        : currentThemeMode == ThemeMode.light
            ? AppColors.textColorDark
            : AppColors.textColorLight;

    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent, // Remove hover color
        splashColor: Colors.transparent, // Remove ripple effect
        focusColor: Colors.transparent, // Remove focus color
      ),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.transparent,
        child: SizedBox(
          height: 65.0, // Increased height to accommodate error text
          child: DropdownButtonFormField<String>(
            validator: validator,
            elevation: 0,
            value: controller.text.isNotEmpty ? controller.text : null,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: AppTextStyles.interMedium14dark.copyWith(
                color: textColor,
              ),
              contentPadding:
                  const EdgeInsets.only(left: 12, top: 8, bottom: 8),
              fillColor: backgroundColor,
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
              errorStyle: const TextStyle(
                color: Colors.red, // Custom error color
                fontSize: 12, // Smaller error font size
                height: 1.2, // Line height for better spacing
              ),
              errorMaxLines: 2, // Allows wrapping for long error messages
            ),
            dropdownColor: backgroundColor,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: AppTextStyles.interMedium14dark.copyWith(
                    color: textColor,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              controller.text = newValue ?? '';
            },
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((String value) {
                return Text(
                  value,
                  style: AppTextStyles.interSemiBold.copyWith(
                    fontSize: 14,
                    color: textColor,
                  ),
                );
              }).toList();
            },
            iconSize: 24.0,
          ),
        ),
      ),
    );
  }
}

class SelectableButtonsFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final List<String> options;
  final String labelText;
  final WidgetRef ref;
  final String? Function(String?)? validator;

  const SelectableButtonsFormFieldWidget({
    Key? key,
    required this.controller,
    required this.options,
    required this.labelText,
    required this.ref,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = ref.watch(themeProvider);
    final colorScheme = Theme.of(context).primaryColor;

    final selectedBackgroundColor = colorScheme;
    final unselectedBackgroundColor = currentThemeMode == ThemeMode.system
        ? Colors.white
        : currentThemeMode == ThemeMode.light
            ? Colors.white
            : AppColors.dark;

    final selectedTextColor = Colors.white;

    final unselectedTextColor = currentThemeMode == ThemeMode.system
        ? AppColors.textColorDark
        : currentThemeMode == ThemeMode.light
            ? AppColors.textColorDark
            : AppColors.textColorLight;

    return FormField<String>(
      initialValue: controller.text,
      validator: validator,
      builder: (FormFieldState<String> fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                labelText,
                style: AppTextStyles.interRegular.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: options.map((option) {
                  final isSelected = controller.text == option;

                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.text = option;
                        fieldState.didChange(option);
                        (context as Element).markNeedsBuild();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? selectedBackgroundColor
                            : unselectedBackgroundColor,
                        foregroundColor: isSelected
                            ? selectedTextColor
                            : unselectedTextColor,
                        textStyle:
                            AppTextStyles.interRegular.copyWith(fontSize: 14),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected
                              ? selectedTextColor
                              : unselectedTextColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  fieldState.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}

class AdditionalInfoFilterButton extends ConsumerWidget {
  final String text;
  final ValueNotifier<bool> controller;

  const AdditionalInfoFilterButton({
    super.key,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, ref) {
    final currentthememode = ref.watch(themeProvider);
    final colorScheme = Theme.of(context).primaryColor;

    final selectedBackgroundColor = colorScheme;

    final unselectedBackgroundColor = currentthememode == ThemeMode.system
        ? Colors.white // White background for system theme when not selected
        : currentthememode == ThemeMode.light
            ? Colors.white // White background for light mode
            : AppColors.dark; // Dark background for dark mode

    final selectedTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorLight
        : currentthememode == ThemeMode.light
            ? AppColors.textColorLight
            : AppColors.textColorDark;

    final unselectedTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorDark
        : currentthememode == ThemeMode.light
            ? AppColors.textColorDark
            : AppColors.textColorLight;
    return ValueListenableBuilder<bool>(
      valueListenable: controller,
      builder: (_, isSelected, __) {
        return ElevatedButton(
          onPressed: () => controller.value = !isSelected,
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected
                ? selectedBackgroundColor
                : unselectedBackgroundColor,
            foregroundColor:
                isSelected ? selectedTextColor : unselectedTextColor,
            side: isSelected
                ? null
                : BorderSide(color: Theme.of(context).primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          child: Text(text,
              style: TextStyle(
                  color: isSelected ? selectedTextColor : unselectedTextColor)),
        );
      },
    );
  }
}

class EstateTypeAddButton extends ConsumerWidget {
  final String text;
  final String filterValue;
  final TextEditingController controller;

  const EstateTypeAddButton({
    super.key,
    required this.text,
    required this.filterValue,
    required this.controller,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sprawdzanie, czy wartość przycisku jest aktualnie wybrana
    bool isSelected = controller.text == filterValue;

    return ElevatedButton(
      onPressed: () {
        // Jeśli przycisk jest już zaznaczony, to kliknięcie go ponownie powinno usunąć selekcję
        if (isSelected) {
          controller.text =
              ''; // Czyszczenie kontrolera, jeśli wartość jest już zaznaczona
        } else {
          // Ustawienie kontrolera na wartość przycisku, niezależnie od poprzedniego stanu
          controller.text = filterValue;
        }
        // Zmuszenie interfejsu do odświeżenia i pokazania aktualnego stanu
        (context as Element).markNeedsBuild();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Colors.blue
            : Colors.white, // Podświetlenie przycisku, gdy jest wybrany
        foregroundColor: isSelected
            ? Colors.white
            : Colors.black, // Zmiana koloru tekstu w zależności od stanu
        side: isSelected
            ? null
            : const BorderSide(
                color: Colors
                    .grey), // Dodanie obramowania dla niezaznaczonych przycisków
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18.0)), // Zaokrąglenie rogów przycisku
      ),
      child: Text(text,
          style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Colors
                      .black)), // Zmiana koloru tekstu w zależności od stanu
    );
  }
}

class ButtonOption {
  final String label;
  final String value;

  ButtonOption(this.label, this.value);
}

class SelectButtonsOptionsWidget extends StatelessWidget {
  final TextEditingController controller;
  final List<ButtonOption> options;
  final String labelText;
  final WidgetRef ref;
  final String? Function(String?)? validator;

  const SelectButtonsOptionsWidget({
    Key? key,
    required this.controller,
    required this.options,
    required this.labelText,
    required this.ref,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = ref.watch(themeProvider);
    final colorScheme = Theme.of(context).primaryColor;

    // Set button colors based on theme mode
    final selectedBackgroundColor =
        currentThemeMode == ThemeMode.system ? Colors.blue : colorScheme;

    final unselectedBackgroundColor = currentThemeMode == ThemeMode.system
        ? Colors.white
        : currentThemeMode == ThemeMode.light
            ? Colors.white
            : AppColors.dark;

    final selectedTextColor = currentThemeMode == ThemeMode.system
        ? AppColors.textColorLight
        : currentThemeMode == ThemeMode.light
            ? AppColors.textColorLight
            : AppColors.textColorDark;

    final unselectedTextColor = currentThemeMode == ThemeMode.system
        ? AppColors.textColorDark
        : currentThemeMode == ThemeMode.light
            ? AppColors.textColorDark
            : AppColors.textColorLight;

    return FormField<String>(
      initialValue: controller.text,
      validator: validator,
      builder: (FormFieldState<String> fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                labelText,
                style: AppTextStyles.interRegular.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: options.map((option) {
                  final isSelected = controller.text == option.value;

                  return Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.text = option.value;
                        fieldState.didChange(option.value);
                        (context as Element).markNeedsBuild(); // Update UI
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? selectedBackgroundColor
                            : unselectedBackgroundColor,
                        foregroundColor: isSelected
                            ? selectedTextColor
                            : unselectedTextColor,
                      ),
                      child: Text(
                        option.label,
                        style: TextStyle(
                          color: isSelected
                              ? selectedTextColor
                              : unselectedTextColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  fieldState.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int? maxLines;
  final String? Function(String?)? validator;
  final WidgetRef ref;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.ref,
    this.maxLines,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = ref.watch(themeProvider);
    final textFieldColor = (currentThemeMode == ThemeMode.system ||
            currentThemeMode == ThemeMode.light)
        ? Colors.black
        : Colors.white;

    return TextFormField(
      style: AppTextStyles.interRegular
          .copyWith(fontSize: 14, color: textFieldColor),
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        labelText: labelText,
        labelStyle: AppTextStyles.interRegular.copyWith(
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: AppColors.light),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: AppColors.light),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      maxLines: maxLines ?? 1, // Default to one line unless specified
      validator: validator,
    );
  }
}

class CustomTextFieldDescription extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final WidgetRef ref;
  final String? Function(String?)? validator;

  const CustomTextFieldDescription({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.ref,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    final textFieldColor = theme.textFieldColor;

    return TextFormField(
      style: AppTextStyles.interRegular
          .copyWith(fontSize: 14, color: textFieldColor),
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        labelText: labelText,
        labelStyle: AppTextStyles.interRegular.copyWith(fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: AppColors.light),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: AppColors.light),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        counterText: '', // Hides character counter
      ),
      maxLines: null, // Allows unlimited lines; field expands vertically
      maxLength: 2500, // Limits character count to 2500
      validator: validator,
    );
  }
}

class CustomNumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final WidgetRef ref;
  final String? Function(String?)? validator;
  final String unit; // Parameter for unit

  const CustomNumberTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.ref,
    this.validator,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use NumberFormat with a space separator
    final formatter = NumberFormat('#,###.##', 'pl_PL');

    // Determine text field color based on the theme
    final theme = ref.watch(themeColorsProvider);
    final textFieldColor = theme.textFieldColor;

    return TextFormField(
      style: AppTextStyles.interSemiBold
          .copyWith(fontSize: 14, color: textFieldColor),
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        labelText: labelText,
        labelStyle: AppTextStyles.interRegular
            .copyWith(fontSize: 14, color: textFieldColor),
        filled: true, // Enable background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: AppColors.dark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: AppColors.light),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixText: unit, // Add the unit as a suffix
        suffixStyle: AppTextStyles.interRegular.copyWith(fontSize: 14),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Allow only digits
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.isEmpty) {
            return newValue.copyWith(text: '');
          }
          final int value =
              int.parse(newValue.text.replaceAll(' ', '').replaceAll(',', ''));
          final String newText = formatter.format(value).replaceAll(',', ' ');
          return newValue.copyWith(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length),
          );
        }),
      ],
      validator: validator,
    );
  }
}

class UnitInputFormatter extends TextInputFormatter {
  final String unit;

  UnitInputFormatter({required this.unit});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText =
        newValue.text.replaceAll(',', '.'); // Zamiana przecinka na kropkę

    if (newText.isNotEmpty && !newText.endsWith(unit)) {
      // Jeśli nowy tekst nie kończy się jednostką, dodaj ją
      newText += ' $unit';
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(
          offset:
              newText.length - unit.length - 1), // Aktualizacja pozycji kursora
    );
  }
}
