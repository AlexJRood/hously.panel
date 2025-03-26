import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/profile/edit_offer/edit_provider.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import '../../../widgets/screens/profile/edit_fileds.dart';
import '../../../widgets/side_menu/slide_rotate_menu.dart';

// ignore: must_be_immutable
class EditOfferMobilePage extends ConsumerWidget {
  double editOfferFontSize = 14;
  double dynamiBoxHeigth = 25;
  double dynamicSpacer = 15;
  final ScrollController scrollController = ScrollController();
  final int? offerId;

  EditOfferMobilePage({super.key, required this.offerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ensure the provider is only watched once

    final editOfferState = ref.watch(editOfferProvider(offerId));
    double screenWidth = MediaQuery.of(context).size.width;
    final sideMenuKey = GlobalKey<SideMenuState>();

    return PopupListener(
      child: SafeArea(
        child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: CustomBackgroundGradients.getMainMenuBackground(
                          context, ref)),
                  child: Column(
                    children: [
                      Expanded(
                        child: ScrollbarTheme(
                          data: ScrollbarThemeData(
                            thumbColor: MaterialStateProperty.all(
                              AppColors.light.withOpacity(0.35),
                            ),
                            thickness: MaterialStateProperty.all(2),
                            radius: const Radius.circular(8.0),
                          ),
                          child: Scrollbar(
                            thumbVisibility: true,
                            thickness: 4,
                            radius: const Radius.circular(8.0),
                            child: ListView(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              children: [
                                if (editOfferState.imagesData.isNotEmpty)
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      'Twoje główne zdjęcie'.tr,
                                      style: AppTextStyles.interMedium.copyWith(
                                        fontSize: 18,
                                        color: AppColors.light,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: double.infinity,
                                  child: editOfferState.imagesData.isNotEmpty
                                      ? GestureDetector(
                                          onTap: () {
                                            final indexToSet =
                                                editOfferState.mainImageIndex ??
                                                    0;
                                            ref
                                                .read(editOfferProvider(offerId)
                                                    .notifier)
                                                .setMainImageIndex(indexToSet);
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.memory(
                                                editOfferState.imagesData[
                                                    editOfferState
                                                            .mainImageIndex ??
                                                        0],
                                                width: double.infinity,
                                                height:
                                                    screenWidth * (650 / 1200),
                                                fit: BoxFit.cover,
                                              ),
                                              if (editOfferState.mainImageIndex !=
                                                  null)
                                                const Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Icon(Icons.star,
                                                      color: AppColors.light),
                                                ),
                                            ],
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () => ref
                                              .read(editOfferProvider(offerId)
                                                  .notifier)
                                              .pickImage(),
                                          child: Container(
                                            height: screenWidth * (650 / 1200),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              gradient: CustomBackgroundGradients
                                                  .adGradient1(context, ref),
                                              border: Border.all(
                                                  color: AppColors.light),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: AppColors.light,
                                                size: 48,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                const SizedBox(height: 7),
                                if (editOfferState.imagesData.isNotEmpty &&
                                    editOfferState.imagesData.length > 1)
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pozostałe zdjęcia'.tr,
                                          style:
                                              AppTextStyles.interMedium.copyWith(
                                            fontSize: 18,
                                            color: AppColors.light,
                                          ),
                                        ),
                                        Text(
                                          'Wybierz główne zdjęcie klikając w miniaturkę'
                                              .tr,
                                          style:
                                              AppTextStyles.interMedium.copyWith(
                                            fontSize: 12,
                                            color: AppColors.light,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 5,
                                    crossAxisSpacing: 7,
                                    mainAxisSpacing: 7,
                                  ),
                                  itemCount: editOfferState.imagesData.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        editOfferState.imagesData.length) {
                                      return GestureDetector(
                                        onTap: () => ref
                                            .read(editOfferProvider(offerId)
                                                .notifier)
                                            .pickImage(),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.light),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.add,
                                              color: AppColors.light,
                                              size: 48,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(editOfferProvider(offerId)
                                                .notifier)
                                            .setMainImageIndex(index);
                                      },
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                image: DecorationImage(
                                                  image: MemoryImage(
                                                      editOfferState
                                                          .imagesData[index]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: IconButton(
                                                icon: SvgPicture.asset(AppIcons.delete,
                                                    color: AppColors.light),
                                                onPressed: () {
                                                  if (editOfferState
                                                          .imagesData.length >
                                                      4) {
                                                    ref
                                                        .read(editOfferProvider(
                                                                offerId)
                                                            .notifier)
                                                        .removeImage(index);
                                                  } else {
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Musisz dodać co najmniej 4 zdjęcia.'
                                                                .tr),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                            if (index ==
                                                editOfferState.mainImageIndex)
                                              const Positioned(
                                                top: 0,
                                                left: 0,
                                                child: Icon(Icons.star,
                                                    color: AppColors.light),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                SelectButtonsOptions(
                                  controller: ref
                                      .watch(editOfferProvider(offerId))
                                      .offerTypeController,
                                  options: [
                                    ButtonOption('Chcę sprzedać'.tr, 'sell'),
                                    ButtonOption('Chcę wynająć'.tr, 'rent'),
                                  ],
                                  labelText:
                                      'Co chcesz zrobić ze swoją nieruchomością?'
                                          .tr,
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                SizedBox(height: dynamiBoxHeigth),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pod jakim adresem znajduję się nieruchomość?'
                                          .tr,
                                      style: AppTextStyles.interRegular.copyWith(
                                          fontSize: 14, color: AppColors.light),
                                    ),
                                    SizedBox(height: dynamicSpacer),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: BuildDropdownButtonFormField(
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .countryController,
                                            items: [
                                              'Polska'.tr,
                                              'Kraj 2'.tr,
                                              'Kraj 3'.tr
                                            ],
                                            labelText: 'Kraj'.tr,
                                          ),
                                        ),
                                        SizedBox(width: dynamicSpacer),
                                      ],
                                    ),
                                    SizedBox(height: dynamicSpacer),
                                    Row(
                                      children: [
                                        SizedBox(width: dynamiBoxHeigth),
                                        Expanded(
                                          flex: 2,
                                          child: BuildDropdownButtonFormField(
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .zipcodeController,
                                            items: const [
                                              '71204',
                                              '75488',
                                              '12345'
                                            ],
                                            labelText: 'Kod pocztowy'.tr,
                                          ),
                                        ),
                                        const Spacer(flex: 1),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                SelectButtonsOptions(
                                  controller: ref
                                      .watch(editOfferProvider(offerId))
                                      .estateTypeController,
                                  options: [
                                    ButtonOption('Mieszkanie'.tr, 'Flat'),
                                    ButtonOption('Kawalerka'.tr, 'Studio'),
                                    const ButtonOption('Apartament', 'Apartment'),
                                    ButtonOption('Dom jednorodzinny'.tr, 'House'),
                                    ButtonOption('Bliźniak'.tr, 'Twin house'),
                                    ButtonOption('Szeregowiec'.tr, 'Row house'),
                                    ButtonOption('Inwestycje'.tr, 'Invest'),
                                    ButtonOption('Działki'.tr, 'Lot'),
                                    ButtonOption(
                                        'Lokale użytkowe'.tr, 'Commercial'),
                                    ButtonOption(
                                        'Hale i magazyny'.tr, 'Warehouse'),
                                    ButtonOption('Pokoje'.tr, 'Room'),
                                    ButtonOption('Garaże'.tr, 'Garage'),
                                  ],
                                  labelText: 'Rodzaj nieruchomości'.tr,
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                SizedBox(height: dynamiBoxHeigth),
                                Text(
                                  'Co chcesz powiedzieć innym o swojej nieruchomości?'
                                      .tr,
                                  style: AppTextStyles.interRegular.copyWith(
                                      fontSize: 14, color: AppColors.light),
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                BuildTextField(
                                  controller: ref
                                      .watch(editOfferProvider(offerId))
                                      .titleController,
                                  labelText: 'Tytuł ogłoszenia'.tr,
                                  maxLines: 1,
                                ),
                                SizedBox(height: dynamicSpacer),
                                BuildTextFieldDes(
                                  controller: ref
                                      .watch(editOfferProvider(offerId))
                                      .descriptionController,
                                  labelText: 'Opis ogłoszenia'.tr,
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                SizedBox(height: dynamiBoxHeigth),
                                Text(
                                  'Jaka jest cena twojej nieruchomości?'.tr,
                                  style: AppTextStyles.interRegular.copyWith(
                                      fontSize: 14, color: AppColors.light),
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                Column(
                                  children: [
                                    BuildDropdownButtonFormField(
                                      controller: ref
                                          .watch(editOfferProvider(offerId))
                                          .currencyController,
                                      items: const [
                                        'PLN',
                                        'EUR',
                                        'GBP',
                                        'USD',
                                        'CZK'
                                      ],
                                      labelText: 'Waluta'.tr,
                                    ),
                                    SizedBox(height: dynamicSpacer),
                                    BuildNumberTextField(
                                      controller: ref
                                          .watch(editOfferProvider(offerId))
                                          .priceController,
                                      labelText:
                                          'Za ile chcesz sprzedać swoją nieruchomość?'
                                              .tr,
                                      unit: '',
                                    ),
                                  ],
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                SizedBox(height: dynamiBoxHeigth),
                                Text(
                                  'Dodaj trochę informacji o swojej nieruchomości'
                                      .tr,
                                  style: AppTextStyles.interRegular.copyWith(
                                      fontSize: 14, color: AppColors.light),
                                ),
                                SizedBox(height: dynamicSpacer),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Wrap(
                                                children: [
                                                  BuildSelectableButtonsFormField(
                                                    controller: ref
                                                        .watch(editOfferProvider(
                                                            offerId))
                                                        .roomsController,
                                                    options: const [
                                                      '1',
                                                      '2',
                                                      '3',
                                                      '4',
                                                      '5',
                                                      '6',
                                                      '7+'
                                                    ],
                                                    labelText: 'Liczba pokoi'.tr,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: dynamicSpacer),
                                              Wrap(
                                                children: [
                                                  BuildSelectableButtonsFormField(
                                                    controller: ref
                                                        .watch(editOfferProvider(
                                                            offerId))
                                                        .bathroomsController,
                                                    options: const [
                                                      '1',
                                                      '2',
                                                      '3',
                                                      '4',
                                                      '5',
                                                      '6',
                                                      '7+'
                                                    ],
                                                    labelText:
                                                        'Liczba łazienek'.tr,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: dynamicSpacer * 2),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: BuildNumberTextField(
                                                      controller: ref
                                                          .watch(
                                                              editOfferProvider(
                                                                  offerId))
                                                          .floorController,
                                                      labelText: 'Piętro'.tr,
                                                      unit: 'Piętro',
                                                    ),
                                                  ),
                                                  SizedBox(width: dynamicSpacer),
                                                  Expanded(
                                                    flex: 2,
                                                    child: BuildNumberTextField(
                                                      controller: ref
                                                          .watch(
                                                              editOfferProvider(
                                                                  offerId))
                                                          .totalFloorsController,
                                                      labelText:
                                                          'Liczba pięter'.tr,
                                                      unit: 'Pięter',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: dynamicSpacer),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Column(
                                              children: [
                                                SizedBox(height: dynamicSpacer),
                                                BuildDropdownButtonFormField(
                                                  controller: ref
                                                      .watch(editOfferProvider(
                                                          offerId))
                                                      .buildingTypeController,
                                                  items: [
                                                    'Blok'.tr,
                                                    'Apartamentowiec'.tr,
                                                    'Szeregowiec'.tr,
                                                    'Kamienica'.tr,
                                                    'Wieżowiec'.tr,
                                                    'Loft'
                                                  ],
                                                  labelText: 'Rodzaj zabudowy'.tr,
                                                ),
                                                SizedBox(height: dynamicSpacer),
                                                BuildDropdownButtonFormField(
                                                  controller: ref
                                                      .watch(editOfferProvider(
                                                          offerId))
                                                      .heatingTypeController,
                                                  items: [
                                                    'Gazowe'.tr,
                                                    'Elektryczne'.tr,
                                                    'Miejskie'.tr,
                                                    'Pompa ciepła'.tr,
                                                    'Olejowe'.tr,
                                                    'Wszystkie'.tr,
                                                    'Nie podano informacji'.tr
                                                  ],
                                                  labelText:
                                                      'Rodzaj ogrzewania'.tr,
                                                ),
                                                SizedBox(height: dynamicSpacer),
                                                BuildDropdownButtonFormField(
                                                  controller: ref
                                                      .watch(editOfferProvider(
                                                          offerId))
                                                      .buildingMaterialController,
                                                  items: [
                                                    'Cegła'.tr,
                                                    'Wielka płyta'.tr,
                                                    'Silikat'.tr,
                                                    'Beton'.tr,
                                                    'Beton Komórkowy'.tr,
                                                    'Pustak'.tr,
                                                    'Żelbet'.tr,
                                                    'Keramzyt'.tr,
                                                    'Drewno'.tr,
                                                    'Inne'.tr
                                                  ],
                                                  labelText:
                                                      'Materiał budynku'.tr,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                SizedBox(height: dynamiBoxHeigth),
                                Text(
                                  'Informacje na temat nieruchomości'.tr,
                                  style: AppTextStyles.interRegular.copyWith(
                                      fontSize: 14, color: AppColors.light),
                                ),
                                SizedBox(height: dynamicSpacer),
                                Column(
                                  children: [
                                    BuildNumberTextField(
                                      controller: ref
                                          .watch(editOfferProvider(offerId))
                                          .buildYearController,
                                      labelText: 'Rok budowy'.tr,
                                      unit: '',
                                    ),
                                    SizedBox(height: dynamicSpacer),
                                    BuildNumberTextField(
                                      controller: ref
                                          .watch(editOfferProvider(offerId))
                                          .squareFootageController,
                                      labelText:
                                          'Jaki jest metraż twojej nieruchomości?'
                                              .tr,
                                      unit: 'm²',
                                    ),
                                  ],
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                SizedBox(height: dynamiBoxHeigth),
                                Text(
                                  'Dodatkowe informacje'.tr,
                                  style: AppTextStyles.interRegular.copyWith(
                                      fontSize: 14, color: AppColors.light),
                                ),
                                SizedBox(height: dynamicSpacer),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AdditionalInfoFilterButton(
                                            text: 'Balkon'.tr,
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .balconyController,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          AdditionalInfoFilterButton(
                                            text: 'Taras'.tr,
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .terraceController,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          AdditionalInfoFilterButton(
                                            text: 'Sauna',
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .saunaController,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          AdditionalInfoFilterButton(
                                            text: 'Jacuzzi',
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .jacuzziController,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          AdditionalInfoFilterButton(
                                            text: 'Piwnica'.tr,
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .basementController,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AdditionalInfoFilterButton(
                                            text: 'Miejsce postojowe'.tr,
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .parkingSpaceController,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          AdditionalInfoFilterButton(
                                            text: 'Garaż'.tr,
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .garageController,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          AdditionalInfoFilterButton(
                                            text: 'Winda'.tr,
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .elevatorController,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          AdditionalInfoFilterButton(
                                            text: 'Ogród'.tr,
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .gardenController,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          AdditionalInfoFilterButton(
                                            text: 'Klimatyzacja'.tr,
                                            controller: ref
                                                .watch(editOfferProvider(offerId))
                                                .airConditioningController,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: dynamiBoxHeigth),
                                SizedBox(height: dynamiBoxHeigth),
                                SizedBox(height: dynamiBoxHeigth),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: CustomBackgroundGradients
                                        .getbuttonGradient1(context, ref),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10.0),
                                      onTap: () {
                                        ref
                                            .read(editOfferProvider(offerId)
                                                .notifier)
                                            .sendData(context, offerId);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text('Zaktualizuj ogłoszenie'.tr,
                                              style: AppTextStyles.interMedium
                                                  .copyWith(fontSize: 16)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: dynamicSpacer),
                                const SizedBox(height: 55),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (editOfferState.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Theme.of(context)
                                .iconTheme
                                .color, // Ustawienie koloru paska ładowania na biały
                          ),
                          const SizedBox(height: 20),
                          AnimatedTextKit(
                            animatedTexts: editOfferState.statusMessages
                                .map((message) => TypewriterAnimatedText(
                                      message,
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      speed: const Duration(milliseconds: 100),
                                    ))
                                .toList(),
                            isRepeatingAnimation: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom:0,
                    right: 0,
                    child: BottomBarMobile(),),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: AppBarMobile(sideMenuKey: sideMenuKey,),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
