import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/state_managers/data/crm/add_field/sell_offer_provider.dart';

// ignore: must_be_immutable
class AddOfferCrm extends ConsumerWidget {
  double addOfferFontSize = 14;
  double dynamiBoxHeigth = 25;
  double dynamicSpacer = 15;
  AddOfferCrm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addOfferState = ref.watch(crmAddSellOfferProvider);
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity, // Zajmuje całą szerokość ekranu
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (addOfferState.imagesData.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
            child: addOfferState.imagesData.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      int indexToSet = addOfferState.mainImageIndex ?? 0;
                      ref
                          .read(crmAddSellOfferProvider.notifier)
                          .setMainImageIndex(indexToSet);
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.memory(
                          addOfferState
                              .imagesData[addOfferState.mainImageIndex ?? 0],
                          width: double.infinity,
                          height: screenWidth * (650 / 1200) / 2,
                          fit: BoxFit.cover,
                        ),
                        if (addOfferState.mainImageIndex != null)
                          const Positioned(
                            top: 0,
                            right: 0,
                            child: Icon(Icons.star, color: AppColors.light),
                          ),
                      ],
                    ),
                  )
                : Container(),
          ),
          const SizedBox(height: 7),
          if (addOfferState.imagesData.isNotEmpty &&
              addOfferState.imagesData.length > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Pozostałe zdjęcia'.tr,
                    style: AppTextStyles.interMedium.copyWith(
                      fontSize: 18,
                      color: AppColors.light,
                    ),
                  ),
                  Text(
                    'Wybierz główne zdjęcie klikając w miniaturkę'.tr,
                    style: AppTextStyles.interMedium.copyWith(
                      fontSize: 12,
                      color: AppColors.light,
                    ),
                  ),
                ],
              ),
            ),
          // Użyj Wrap lub Column zamiast GridView.builder
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              for (int index = 0;
                  index < addOfferState.imagesData.length;
                  index++)
                GestureDetector(
                  onTap: () {
                    ref
                        .read(crmAddSellOfferProvider.notifier)
                        .setMainImageIndex(index);
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: MemoryImage(addOfferState.imagesData[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon:
                              SvgPicture.asset(AppIcons.delete, color: AppColors.light),
                          onPressed: () {
                            if (addOfferState.imagesData.length > 4) {
                              ref
                                  .read(crmAddSellOfferProvider.notifier)
                                  .removeImage(index);
                            } else {
                              final snackBar = Customsnackbar().showSnackBar(
                                  "Warning",
                                  'Musisz dodać co najmniej 4 zdjęcia.'.tr,
                                  "warning", () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        ),
                      ),
                      if (index == addOfferState.mainImageIndex)
                        const Positioned(
                          top: 0,
                          left: 0,
                          child: Icon(Icons.star, color: AppColors.light),
                        ),
                    ],
                  ),
                ),
              // Przycisk dodawania zdjęcia
              GestureDetector(
                onTap: () =>
                    ref.read(crmAddSellOfferProvider.notifier).pickImage(),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.light),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: AppColors.light,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: dynamiBoxHeigth),
          // Inne elementy interfejsu
          selectButtonsOptions(
            controller: ref.watch(crmAddSellOfferProvider).offerTypeController,
            options: [
              ButtonOption('Chcę sprzedać'.tr, 'sell'),
              ButtonOption('Chcę wynająć'.tr, 'rent'),
            ],
            labelText: 'Co chcesz zrobić ze swoją nieruchomością?'.tr,
            context: context,
          ),
          SizedBox(height: dynamiBoxHeigth),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pod jakim adresem znajduję się nieruchomość?'.tr,
                style: AppTextStyles.interRegular
                    .copyWith(fontSize: 14, color: AppColors.light),
              ),
              SizedBox(height: dynamicSpacer),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: buildDropdownButtonFormField(
                      controller:
                          ref.watch(crmAddSellOfferProvider).countryController,
                      items: ['Polska'.tr, 'Kraj 2'.tr, 'Kraj 3'.tr],
                      labelText: 'Kraj'.tr,
                      ref: ref,
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
                    child: buildDropdownButtonFormField(
                      controller:
                          ref.watch(crmAddSellOfferProvider).zipcodeController,
                      items: ['71204', '75488', '12345'],
                      labelText: 'Kod pocztowy'.tr,
                      ref: ref,
                    ),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
            ],
          ),
          SizedBox(height: dynamiBoxHeigth),
          selectButtonsOptions(
            controller: ref.watch(crmAddSellOfferProvider).estateTypeController,
            options: [
              ButtonOption('Mieszkanie'.tr, 'Flat'),
              ButtonOption('Kawalerka'.tr, 'Studio'),
              ButtonOption('Apartament', 'Apartment'),
              ButtonOption('Dom jednorodzinny'.tr, 'House'),
              ButtonOption('Bliźniak'.tr, 'Twin house'),
              ButtonOption('Szeregowiec'.tr, 'Row house'),
              ButtonOption('Inwestycje'.tr, 'Invest'),
              ButtonOption('Działki'.tr, 'Lot'),
              ButtonOption('Lokale użytkowe'.tr, 'Commercial'),
              ButtonOption('Hale i magazyny'.tr, 'Warehouse'),
              ButtonOption('Pokoje'.tr, 'Room'),
              ButtonOption('Garaże'.tr, 'Garage'),
            ],
            labelText: 'Rodzaj nieruchomości'.tr,
            context: context,
          ),
          SizedBox(height: dynamiBoxHeigth),
          SizedBox(height: dynamiBoxHeigth),
          Text(
            'Co chcesz powiedzieć innym o swojej nieruchomości?'.tr,
            style: AppTextStyles.interRegular
                .copyWith(fontSize: 14, color: AppColors.light),
          ),
          SizedBox(height: dynamiBoxHeigth),
          buildTextField(
            controller: ref.watch(crmAddSellOfferProvider).titleController,
            labelText: 'Tytuł ogłoszenia'.tr,
            context: context,
            maxLines: 1,
          ),
          SizedBox(height: dynamicSpacer),
          buildTextFieldDes(
            controller:
                ref.watch(crmAddSellOfferProvider).descriptionController,
            labelText: 'Opis ogłoszenia'.tr,
            context: context,
          ),
          SizedBox(height: dynamiBoxHeigth),
          SizedBox(height: dynamiBoxHeigth),
          Text(
            'Jaka jest cena twojej nieruchomości?'.tr,
            style: AppTextStyles.interRegular
                .copyWith(fontSize: 14, color: AppColors.light),
          ),
          SizedBox(height: dynamiBoxHeigth),
          Column(
            children: [
              buildDropdownButtonFormField(
                controller:
                    ref.watch(crmAddSellOfferProvider).currencyController,
                items: ['PLN', 'EUR', 'GBP', 'USD', 'CZK'],
                labelText: 'Waluta'.tr,
                ref: ref,
              ),
              SizedBox(height: dynamicSpacer),
              buildNumberTextField(
                controller: ref.watch(crmAddSellOfferProvider).priceController,
                labelText: 'Za ile chcesz sprzedać swoją nieruchomość?'.tr,
                context: context,
                unit: '',
              ),
            ],
          ),
          SizedBox(height: dynamiBoxHeigth),
          SizedBox(height: dynamiBoxHeigth),
          Text(
            'Dodaj trochę informacji o swojej nieruchomości'.tr,
            style: AppTextStyles.interRegular
                .copyWith(fontSize: 14, color: AppColors.light),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            buildSelectableButtonsFormField(
                              controller: ref
                                  .watch(crmAddSellOfferProvider)
                                  .roomsController,
                              options: ['1', '2', '3', '4', '5', '6', '7+'],
                              labelText: 'Liczba pokoi'.tr,
                              context: context,
                            ),
                          ],
                        ),
                        SizedBox(height: dynamicSpacer),
                        Wrap(
                          children: [
                            buildSelectableButtonsFormField(
                              controller: ref
                                  .watch(crmAddSellOfferProvider)
                                  .bathroomsController,
                              options: ['1', '2', '3', '4', '5', '6', '7+'],
                              labelText: 'Liczba łazienek'.tr,
                              context: context,
                            ),
                          ],
                        ),
                        SizedBox(height: dynamicSpacer * 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: buildNumberTextField(
                                controller: ref
                                    .watch(crmAddSellOfferProvider)
                                    .floorController,
                                labelText: 'Piętro'.tr,
                                context: context,
                                unit: 'Piętro',
                              ),
                            ),
                            SizedBox(width: dynamicSpacer),
                            Expanded(
                              flex: 2,
                              child: buildNumberTextField(
                                controller: ref
                                    .watch(crmAddSellOfferProvider)
                                    .totalFloorsController,
                                labelText: 'Liczba pięter'.tr,
                                context: context,
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
                          buildDropdownButtonFormField(
                            controller: ref
                                .watch(crmAddSellOfferProvider)
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
                            ref: ref,
                          ),
                          SizedBox(height: dynamicSpacer),
                          buildDropdownButtonFormField(
                            controller: ref
                                .watch(crmAddSellOfferProvider)
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
                            labelText: 'Rodzaj ogrzewania'.tr,
                            ref: ref,
                          ),
                          SizedBox(height: dynamicSpacer),
                          buildDropdownButtonFormField(
                            controller: ref
                                .watch(crmAddSellOfferProvider)
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
                            labelText: 'Materiał budynku'.tr,
                            ref: ref,
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
            style: AppTextStyles.interRegular
                .copyWith(fontSize: 14, color: AppColors.light),
          ),
          SizedBox(height: dynamicSpacer),
          Column(
            children: [
              buildNumberTextField(
                controller:
                    ref.watch(crmAddSellOfferProvider).buildYearController,
                labelText: 'Rok budowy'.tr,
                context: context,
                unit: '',
              ),
              SizedBox(height: dynamicSpacer),
              buildNumberTextField(
                controller:
                    ref.watch(crmAddSellOfferProvider).squareFootageController,
                labelText: 'Jaki jest metraż twojej nieruchomości?'.tr,
                context: context,
                unit: 'm²',
              ),
            ],
          ),
          SizedBox(height: dynamiBoxHeigth),
          SizedBox(height: dynamiBoxHeigth),
          Text(
            'Dodatkowe informacje'.tr,
            style: AppTextStyles.interRegular
                .copyWith(fontSize: 14, color: AppColors.light),
          ),
          SizedBox(height: dynamicSpacer),

          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              AdditionalInfoFilterButton(
                text: 'Balkon'.tr,
                controller:
                    ref.watch(crmAddSellOfferProvider).balconyController,
              ),
              AdditionalInfoFilterButton(
                text: 'Taras'.tr,
                controller:
                    ref.watch(crmAddSellOfferProvider).terraceController,
              ),
              AdditionalInfoFilterButton(
                text: 'Sauna',
                controller: ref.watch(crmAddSellOfferProvider).saunaController,
              ),
              AdditionalInfoFilterButton(
                text: 'Jacuzzi',
                controller:
                    ref.watch(crmAddSellOfferProvider).jacuzziController,
              ),
              AdditionalInfoFilterButton(
                text: 'Piwnica'.tr,
                controller:
                    ref.watch(crmAddSellOfferProvider).basementController,
              ),
              AdditionalInfoFilterButton(
                text: 'Miejsce postojowe'.tr,
                controller:
                    ref.watch(crmAddSellOfferProvider).parkingSpaceController,
              ),
              AdditionalInfoFilterButton(
                text: 'Garaż'.tr,
                controller: ref.watch(crmAddSellOfferProvider).garageController,
              ),
              AdditionalInfoFilterButton(
                text: 'Winda'.tr,
                controller:
                    ref.watch(crmAddSellOfferProvider).elevatorController,
              ),
              AdditionalInfoFilterButton(
                text: 'Ogród'.tr,
                controller: ref.watch(crmAddSellOfferProvider).gardenController,
              ),
              AdditionalInfoFilterButton(
                text: 'Klimatyzacja'.tr,
                controller: ref
                    .watch(crmAddSellOfferProvider)
                    .airConditioningController,
              ),
            ],
          ),
        ],
      ),
      // SizedBox(height: dynamiBoxHeigth),
      // SizedBox(height: dynamiBoxHeigth),
      // SizedBox(height: dynamiBoxHeigth),
      // Container(
      //   decoration: BoxDecoration(
      //     gradient: const LinearGradient(colors: [
      //       AppColors.buttonGradient1,
      //       AppColors.buttonGradient2
      //     ]),
      //     borderRadius: BorderRadius.circular(10.0),
      //   ),
      //   child: Material(
      //     color: Colors.transparent,
      //     child: InkWell(
      //       borderRadius: BorderRadius.circular(10.0),
      //       onTap: () {
      //         ref
      //             .read(crmAddSellOfferProvider.notifier)
      //             .sendData(context);
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.all(10.0),
      //         child: Center(
      //           child: Text('Wystaw ogłoszenie',
      //               style: AppTextStyles.interMedium
      //                   .copyWith(fontSize: 16)),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      // SizedBox(height: dynamicSpacer),

      // ),
      // ),
    );
  }
}
