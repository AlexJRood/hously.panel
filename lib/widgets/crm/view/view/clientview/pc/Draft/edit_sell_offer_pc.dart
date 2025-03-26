//Components/edit_offer.dart

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/crm/add_field/edit_sell_offer_provider.dart';
import 'package:hously_flutter/state_managers/data/profile/edit_offer/edit_provider.dart';
import 'package:hously_flutter/widgets/screens/profile/edit_fileds.dart';

// ignore: must_be_immutable
class CrmEditSellOfferPc extends ConsumerWidget {
  double editOfferFontSize = 14;
  double dynamiBoxHeigth = 15;
  final int? offerId;

  CrmEditSellOfferPc({super.key, required this.offerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editOfferState = ref.watch(crmEditSellOfferProvider(offerId));
    double screenWidth = MediaQuery.of(context).size.width;
    double textSideWidth = screenWidth / 2 - 100;
    double imageSideWidth = screenWidth / 2 - 85;

    double itemWidth = screenWidth / 1920 * 350;
    itemWidth = max(100.0, min(itemWidth, 300.0));

    double minBaseTextSize = 14;
    double maxBaseTextSize = 20;
    double baseTextSize = minBaseTextSize +
        (itemWidth - 150) / (240 - 150) * (maxBaseTextSize - minBaseTextSize);
    baseTextSize = max(minBaseTextSize, min(baseTextSize, maxBaseTextSize));

    return Expanded(
      child: Row(
        children: [
          SizedBox(
            width: textSideWidth,
            child: ScrollbarTheme(
              data: ScrollbarThemeData(
                thumbColor: MaterialStateProperty.all(
                    AppColors.light.withOpacity(0.35)),
                thickness: MaterialStateProperty.all(4),
                radius: const Radius.circular(8.0),
              ),
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 4,
                radius: const Radius.circular(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SelectButtonsOptions(
                          controller: ref
                              .watch(crmEditSellOfferProvider(offerId))
                              .offerTypeController,
                          options:  [
                            ButtonOption('Chcę sprzedać'.tr, 'sell'),
                            ButtonOption('Chcę wynająć'.tr, 'rent'),
                          ],
                          labelText:
                              'Co chcesz zrobić ze swoją nieruchomością?'.tr,
                        ),
                        SizedBox(height: dynamiBoxHeigth),
                        SizedBox(height: dynamiBoxHeigth),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pod jakim adresem znajduję się nieruchomość?'.tr,
                              style: AppTextStyles.interRegular.copyWith(
                                  fontSize: 14, color: AppColors.light),
                            ),
                            SizedBox(height: dynamiBoxHeigth),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: BuildDropdownButtonFormField(
                                    controller: ref
                                        .watch(crmEditSellOfferProvider(offerId))
                                        .countryController,
                                    items:  ['Polska'.tr, 'Kraj 2'.tr, 'Kraj 3'.tr],
                                    labelText: 'Kraj'.tr,
                                  ),
                                ),
                                SizedBox(width: dynamiBoxHeigth),
                                Expanded(
                                  flex: 3,
                                  child: BuildDropdownButtonFormField(
                                    controller: ref
                                        .watch(crmEditSellOfferProvider(offerId))
                                        .stateController,
                                    items:  const [
                                      'Dolnośląskie',
                                      'Kujawsko-Pomorskie',
                                      'Lubelskie',
                                      'Lubuskie',
                                      'Łódzkie',
                                      'Małopolskie',
                                      'Mazowieckie',
                                      'Opolskie',
                                      'Podkarpackie',
                                      'Podlaskie',
                                      'Pomorskie',
                                      'Śląskie',
                                      'Świętokrzyskie',
                                      'Warmińsko-Mazurskie',
                                      'Wielkopolskie',
                                      'Zachodniopomorskie'
                                    ],
                                    labelText: 'Województwo'.tr,
                                  ),
                                ),
                                SizedBox(width: dynamiBoxHeigth),
                                Expanded(
                                  flex: 3,
                                  child: BuildDropdownButtonFormField(
                                    controller: ref
                                        .read(crmEditSellOfferProvider(offerId))
                                        .cityController,
                                    items: const [
                                      'Warsaw',
                                      'Kraków',
                                      'Wrocław',
                                      'Poznań',
                                      'Gdańsk',
                                      'Szczecin',
                                      'Bydgoszcz',
                                      'Lublin',
                                      'Katowice',
                                      'Białystok',
                                      'Gdynia',
                                      'Częstochowa',
                                      'Radom',
                                      'Sosnowiec',
                                      'Toruń',
                                      'Kielce',
                                      'Gliwice',
                                      'Zabrze',
                                      'Bytom',
                                      'Olsztyn'
                                    ],
                                    labelText: 'Miasto'.tr,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: dynamiBoxHeigth),
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: BuildDropdownButtonFormField(
                                    controller: ref
                                        .read(crmEditSellOfferProvider(offerId))
                                        .streetController,
                                    items:  [
                                      'Marszałkowska',
                                      'Krakowskie Przedmieście',
                                      'Piotrkowska',
                                      'Słowackiego',
                                      'Długa',
                                      '3 Maja',
                                      'Solidarności',
                                      'Grzybowska',
                                      'Żeromskiego',
                                      'Polna',
                                      'Ogrodowa',
                                      'Mickiewicza',
                                      'Sienkiewicza',
                                      'Wielkopolska',
                                      'Gdańska',
                                      'Kościuszki',
                                      'Zamkowa',
                                      'Podwale',
                                      'Reymonta',
                                      'Kopernika',
                                      'Jagiellońska',
                                      'Lwowska',
                                      'Brzozowa',
                                      'Nadbrzeżna',
                                      'Parkowa',
                                      'Rybacka',
                                      'Słoneczna',
                                      'Widok'.tr,
                                      'Zielona',
                                      'Klonowa',
                                      'Akacjowa',
                                      'Cicha',
                                      'Wiśniowa',
                                      'Kwiatowa',
                                      'Łąkowa',
                                      'Modrzewiowa',
                                      'Nadwiślańska',
                                      'Opolska',
                                      'Piaskowa',
                                      'Różana'
                                    ],
                                    labelText: 'Adres'.tr,
                                  ),
                                ),
                                SizedBox(width: dynamiBoxHeigth),
                                Expanded(
                                  flex: 2,
                                  child: BuildDropdownButtonFormField(
                                    controller: ref
                                        .watch(crmEditSellOfferProvider(offerId))
                                        .zipcodeController,
                                    items: const ['71204', '75488', '12345'],
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
                              .read(crmEditSellOfferProvider(offerId))
                              .estateTypeController,
                          options:  [
                            ButtonOption('Mieszkanie'.tr, 'Flat'),
                            ButtonOption('Kawalerka'.tr, 'Studio'),
                            const ButtonOption('Apartament', 'Apartment'),
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
                        ),
                        SizedBox(height: dynamiBoxHeigth),
                        SizedBox(height: dynamiBoxHeigth),
                        Text(
                          'Co chcesz powiedzieć innym o swojej nieruchomości?'.tr,
                          style: AppTextStyles.interRegular
                              .copyWith(fontSize: 14, color: AppColors.light),
                        ),
                        SizedBox(height: dynamiBoxHeigth),
                        BuildTextField(
                          controller: ref
                              .read(crmEditSellOfferProvider(offerId))
                              .titleController,
                          labelText: 'Tytuł ogłoszenia'.tr,
                          maxLines: 1,
                        ),
                        SizedBox(height: dynamiBoxHeigth),
                        BuildTextFieldDes(
                          controller: ref
                              .read(crmEditSellOfferProvider(offerId))
                              .descriptionController,
                          labelText: 'Opis ogłoszenia'.tr,
                        ),
                        SizedBox(height: dynamiBoxHeigth),
                        SizedBox(height: dynamiBoxHeigth),
                        Text(
                          'Jaka jest cena twojej nieruchomości?'.tr,
                          style: AppTextStyles.interRegular
                              .copyWith(fontSize: 14, color: AppColors.light),
                        ),
                        SizedBox(height: dynamiBoxHeigth),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: BuildDropdownButtonFormField(
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
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
                            ),
                            SizedBox(width: dynamiBoxHeigth),
                            Expanded(
                              flex: 7,
                              child: BuildNumberTextField(
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .priceController,
                                labelText:
                                    'Za ile chcesz sprzedać swoją nieruchomość?'.tr,
                                unit: '',
                              ),
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
                        SizedBox(height: dynamiBoxHeigth / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    children: [
                                      BuildSelectableButtonsFormField(
                                        controller: ref
                                            .watch(crmEditSellOfferProvider(offerId))
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
                                  Wrap(
                                    children: [
                                      BuildSelectableButtonsFormField(
                                        controller: ref
                                            .watch(crmEditSellOfferProvider(offerId))
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
                                        labelText: 'Liczba łazienek'.tr,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: dynamiBoxHeigth * 1.5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: BuildNumberTextField(
                                          controller: ref
                                              .watch(crmEditSellOfferProvider(offerId))
                                              .floorController,
                                          labelText: 'Piętro'.tr,
                                          unit: 'Piętro',
                                        ),
                                      ),
                                      SizedBox(width: dynamiBoxHeigth),
                                      Expanded(
                                        flex: 2,
                                        child: BuildNumberTextField(
                                          controller: ref
                                              .watch(crmEditSellOfferProvider(offerId))
                                              .totalFloorsController,
                                          labelText: 'Liczba pięter'.tr,
                                          unit: 'Pięter',
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: dynamiBoxHeigth * 2),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    SizedBox(height: dynamiBoxHeigth),
                                    BuildDropdownButtonFormField(
                                      controller: ref
                                          .watch(crmEditSellOfferProvider(offerId))
                                          .buildingTypeController,
                                      items:  [
                                        'Blok'.tr,
                                        'Apartamentowiec'.tr,
                                        'Szeregowiec'.tr,
                                        'Kamienica'.tr,
                                        'Wieżowiec'.tr,
                                        'Loft'
                                      ],
                                      labelText: 'Rodzaj zabudowy'.tr,
                                    ),
                                    SizedBox(height: dynamiBoxHeigth),
                                    BuildDropdownButtonFormField(
                                      controller: ref
                                          .watch(crmEditSellOfferProvider(offerId))
                                          .heatingTypeController,
                                      items:  [
                                        'Gazowe'.tr,
                                        'Elektryczne'.tr,
                                        'Miejskie'.tr,
                                        'Pompa ciepła'.tr,
                                        'Olejowe'.tr,
                                        'Wszystkie'.tr,
                                        'Nie podano informacji'.tr
                                      ],
                                      labelText: 'Rodzaj ogrzewania'.tr,
                                    ),
                                    SizedBox(height: dynamiBoxHeigth),
                                    BuildDropdownButtonFormField(
                                      controller: ref
                                          .watch(crmEditSellOfferProvider(offerId))
                                          .buildingMaterialController,
                                      items:  [
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
                                    ),
                                  ],
                                ),
                              ),
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
                        SizedBox(height: dynamiBoxHeigth),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: BuildNumberTextField(
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .buildYearController,
                                labelText: 'Rok budowy'.tr,
                                unit: '',
                              ),
                            ),
                            SizedBox(width: dynamiBoxHeigth),
                            Expanded(
                              flex: 5,
                              child: BuildNumberTextField(
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .squareFootageController,
                                labelText:
                                    'Jaki jest metraż twojej nieruchomości?'.tr,
                                unit: 'm²',
                              ),
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
                        SizedBox(height: dynamiBoxHeigth),
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: dynamiBoxHeigth,
                          runSpacing: dynamiBoxHeigth,
                          children: [
                            AdditionalInfoFilterButton(
                                text: 'Balkon'.tr,
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .balconyController),
                            AdditionalInfoFilterButton(
                                text: 'Taras'.tr,
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .terraceController),
                            AdditionalInfoFilterButton(
                                text: 'Sauna',
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .saunaController),
                            AdditionalInfoFilterButton(
                                text: 'Jacuzzi',
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .jacuzziController),
                            AdditionalInfoFilterButton(
                                text: 'Piwnica'.tr,
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .basementController),
                            AdditionalInfoFilterButton(
                                text: 'Winda'.tr,
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .elevatorController),
                            AdditionalInfoFilterButton(
                                text: 'Ogród'.tr,
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .gardenController),
                            AdditionalInfoFilterButton(
                                text: 'Klimatyzacja'.tr,
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .airConditioningController),
                            AdditionalInfoFilterButton(
                                text: 'Garaż'.tr,
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .garageController),
                            AdditionalInfoFilterButton(
                                text: 'Miejsce postojowe'.tr,
                                controller: ref
                                    .watch(crmEditSellOfferProvider(offerId))
                                    .parkingSpaceController),
                          ],
                        ),
                        SizedBox(height: dynamiBoxHeigth),
                        SizedBox(height: dynamiBoxHeigth),
                        SizedBox(height: dynamiBoxHeigth),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: dynamiBoxHeigth * 2),
          SizedBox(
            width: imageSideWidth,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: dynamiBoxHeigth),
                        // Etykieta "Twoje główne zdjęcie"
                        if (editOfferState.imagesData.isNotEmpty)
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

                        SizedBox(height: dynamiBoxHeigth),
                        // Kontener dla głównego zdjęcia lub przycisku do wyboru zdjęć
                        SizedBox(
                          width: imageSideWidth,
                          height: imageSideWidth * (650 / 1200),
                          child: editOfferState.imagesData.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    int indexToSet =
                                        editOfferState.mainImageIndex ?? 0;
                                    ref
                                        .read(
                                            crmEditSellOfferProvider(offerId).notifier)
                                        .setMainImageIndex(indexToSet);
                                  },
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Image.memory(
                                        editOfferState.imagesData[
                                            editOfferState.mainImageIndex ?? 0],
                                        width: imageSideWidth,
                                        height: imageSideWidth * (650 / 1200),
                                        fit: BoxFit.cover,
                                      ),
                                      if (editOfferState.mainImageIndex != null)
                                        const Icon(Icons.star,
                                            color: AppColors.light),
                                    ],
                                  ),
                                )
                              : InkWell(
                                  onTap: () => ref
                                      .read(crmEditSellOfferProvider(offerId).notifier)
                                      .pickImage(),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: CustomBackgroundGradients.adGradient1(context, ref), // Tło kontenera
                                      border:
                                          Border.all(color: AppColors.light),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.camera_alt, // Ikona aparatu
                                        color: AppColors.light,
                                        size: 48,
                                      ),
                                    ),
                                  ),
                                ),
                        ),

                        SizedBox(height: dynamiBoxHeigth),

                        // Etykieta "Pozostałe zdjęcia"
                        if (editOfferState.imagesData.isNotEmpty &&
                            editOfferState.imagesData.length > 1)
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
                                  'Wybierz główne zdjęcie klikając w miniatrurkę'.tr,
                                  style: AppTextStyles.interMedium.copyWith(
                                    fontSize: 12,
                                    color: AppColors.light,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: dynamiBoxHeigth / 2,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 7,
                          ),
                          itemCount: editOfferState.imagesData.length +
                              1, // Dodaj +1 do liczby elementów
                          itemBuilder: (context, index) {
                            // Sprawdzenie, czy bieżący indeks to ostatni kafelek
                            if (index == editOfferState.imagesData.length) {
                              // Renderowanie przycisku dodawania zdjęć
                              return InkWell(
                                onTap: () => ref
                                    .read(crmEditSellOfferProvider(offerId).notifier)
                                    .pickImage(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.add, // Ikona plusa
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                              );
                            } else {
                              // Renderowanie miniatury zdjęcia
                              return GestureDetector(
                                onTap: () {
                                  ref
                                      .read(crmEditSellOfferProvider(offerId).notifier)
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
                                            image: MemoryImage(editOfferState
                                                .imagesData[index]),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: SvgPicture.asset(AppIcons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          if (editOfferState
                                              .imagesData.isNotEmpty) {
                                            ref
                                                .read(crmEditSellOfferProvider(offerId)
                                                    .notifier)
                                                .removeImage(index);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                               SnackBar(
                                                content: Text(
                                                    'Musisz dodać co najmniej 4 zdjęcia.'.tr),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: dynamiBoxHeigth),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        gradient:CustomBackgroundGradients.getbuttonGradient1(context, ref),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.0),
                          onTap: () {
                            ref
                                .read(crmEditSellOfferProvider(offerId).notifier)
                                .sendData(context, offerId);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: baseTextSize * 1.5,
                                vertical: baseTextSize / 5),
                            child: Text('Wystaw ogłoszenie'.tr,
                                style: AppTextStyles.interMedium
                                    .copyWith(fontSize: baseTextSize)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: dynamiBoxHeigth),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
