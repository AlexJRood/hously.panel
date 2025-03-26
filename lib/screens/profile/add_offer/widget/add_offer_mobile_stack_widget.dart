import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/state_managers/data/profile/add_offer/add_provider.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class AddOfferMobileStackWidget extends ConsumerWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  const AddOfferMobileStackWidget({super.key, required this.sideMenuKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addOfferState = ref.watch(addOfferProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double dynamiBoxHeigth = 25;
    double dynamicSpacer = 15;
    final scrollController = ScrollController();
    return Stack(
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
                    controller: scrollController,
                    thumbVisibility: true,
                    thickness: 4,
                    radius: const Radius.circular(8.0),
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      children: [
                        SizedBox(height: 65),
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
                                    final indexToSet =
                                        addOfferState.mainImageIndex ?? 0;
                                    ref
                                        .read(addOfferProvider.notifier)
                                        .setMainImageIndex(indexToSet);
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.memory(
                                        addOfferState.imagesData[0],
                                        width: double.infinity,
                                        height: screenWidth * (650 / 1200),
                                        fit: BoxFit.cover,
                                      ),
                                      if (addOfferState.mainImageIndex != null)
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Icon(Icons.star,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color!),
                                        ),
                                    ],
                                  ),
                                )
                              : InkWell(
                                  onTap: () => ref
                                      .read(addOfferProvider.notifier)
                                      .pickImage(),
                                  child: Container(
                                    height: screenWidth * (650 / 1200),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      gradient: CustomBackgroundGradients
                                          .getaddpagebackground(context, ref),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.camera_alt,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        size: 48,
                                      ),
                                    ),
                                  ),
                                ),
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
                                  'Wybierz główne zdjęcie klikając w miniaturkę'
                                      .tr,
                                  style: AppTextStyles.interMedium.copyWith(
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
                          itemCount: addOfferState.imagesData.length +
                              1, // Increase the item count by 1
                          itemBuilder: (context, index) {
                            if (index == addOfferState.imagesData.length) {
                              // Render the "Add Image" tile as the last item
                              return GestureDetector(
                                onTap: () => ref
                                    .read(addOfferProvider.notifier)
                                    .pickImage(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Theme.of(context).iconTheme.color!),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Theme.of(context).iconTheme.color!,
                                      size: 48,
                                    ),
                                  ),
                                ),
                              );
                            }

                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(addOfferProvider.notifier)
                                    .setMainImageIndex(index);
                              },
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: MemoryImage(
                                              addOfferState.imagesData[index]),
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
                                          if (addOfferState.imagesData.length >
                                              4) {
                                            ref
                                                .read(addOfferProvider.notifier)
                                                .removeImage(index);
                                          } else {
                                            final snackBar = Customsnackbar()
                                                .showSnackBar(
                                                    "Warning",
                                                    "Musisz dodać co najmniej 4 zdjęcia."
                                                        .tr,
                                                    "error", () {
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
                        SelectButtonsOptionsWidget(
                          ref: ref,
                          controller:
                              ref.watch(addOfferProvider).offerTypeController,
                          options: [
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
                            SizedBox(height: dynamicSpacer),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonFormFieldWidget(
                                    controller: ref
                                        .watch(addOfferProvider)
                                        .countryController,
                                    items: [
                                      'Polska'.tr,
                                      'Kraj 2'.tr,
                                      'Kraj 3'.tr
                                    ],
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
                                  child: DropdownButtonFormFieldWidget(
                                    controller: ref
                                        .watch(addOfferProvider)
                                        .zipcodeController,
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
                        SelectButtonsOptionsWidget(
                          ref: ref,
                          controller:
                              ref.watch(addOfferProvider).estateTypeController,
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
                        ),
                        SizedBox(height: dynamiBoxHeigth),
                        SizedBox(height: dynamiBoxHeigth),
                        Text(
                          'Co chcesz powiedzieć innym o swojej nieruchomości?'
                              .tr,
                          style: AppTextStyles.interRegular
                              .copyWith(fontSize: 14, color: AppColors.light),
                        ),
                        SizedBox(height: dynamiBoxHeigth),
                        CustomTextField(
                          ref: ref,
                          controller:
                              ref.watch(addOfferProvider).titleController,
                          labelText: 'Tytuł ogłoszenia'.tr,
                          maxLines: 1,
                        ),
                        SizedBox(height: dynamicSpacer),
                        CustomTextFieldDescription(
                          ref: ref,
                          controller:
                              ref.watch(addOfferProvider).descriptionController,
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
                        Column(
                          children: [
                            DropdownButtonFormFieldWidget(
                              controller: ref
                                  .watch(addOfferProvider)
                                  .currencyController,
                              items: ['PLN', 'EUR', 'GBP', 'USD', 'CZK'],
                              labelText: 'Waluta'.tr,
                              ref: ref,
                            ),
                            SizedBox(height: dynamicSpacer),
                            CustomNumberTextField(
                              ref: ref,
                              controller:
                                  ref.watch(addOfferProvider).priceController,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        children: [
                                          SelectableButtonsFormFieldWidget(
                                            ref: ref,
                                            controller: ref
                                                .watch(addOfferProvider)
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
                                          SelectableButtonsFormFieldWidget(
                                            controller: ref
                                                .watch(addOfferProvider)
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
                                            ref: ref,
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
                                            child: CustomNumberTextField(
                                              ref: ref,
                                              controller: ref
                                                  .watch(addOfferProvider)
                                                  .floorController,
                                              labelText: 'Piętro'.tr,
                                              unit: 'Piętro',
                                            ),
                                          ),
                                          SizedBox(width: dynamicSpacer),
                                          Expanded(
                                            flex: 2,
                                            child: CustomNumberTextField(
                                              ref: ref,
                                              controller: ref
                                                  .watch(addOfferProvider)
                                                  .totalFloorsController,
                                              labelText: 'Liczba pięter'.tr,
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
                                        DropdownButtonFormFieldWidget(
                                          controller: ref
                                              .watch(addOfferProvider)
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
                                        DropdownButtonFormFieldWidget(
                                          controller: ref
                                              .watch(addOfferProvider)
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
                                        DropdownButtonFormFieldWidget(
                                          controller: ref
                                              .watch(addOfferProvider)
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
                            CustomNumberTextField(
                              ref: ref,
                              controller: ref
                                  .watch(addOfferProvider)
                                  .buildYearController,
                              labelText: 'Rok budowy'.tr,
                              unit: '',
                            ),
                            SizedBox(height: dynamicSpacer),
                            CustomNumberTextField(
                              ref: ref,
                              controller: ref
                                  .watch(addOfferProvider)
                                  .squareFootageController,
                              labelText:
                                  'Jaki jest metraż twojej nieruchomości?'.tr,
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
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AdditionalInfoFilterButton(
                                    text: 'Balkon'.tr,
                                    controller: ref
                                        .watch(addOfferProvider)
                                        .balconyController,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AdditionalInfoFilterButton(
                                    text: 'Taras'.tr,
                                    controller: ref
                                        .watch(addOfferProvider)
                                        .terraceController,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AdditionalInfoFilterButton(
                                    text: 'Sauna',
                                    controller: ref
                                        .watch(addOfferProvider)
                                        .saunaController,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AdditionalInfoFilterButton(
                                    text: 'Jacuzzi',
                                    controller: ref
                                        .watch(addOfferProvider)
                                        .jacuzziController,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AdditionalInfoFilterButton(
                                    text: 'Piwnica'.tr,
                                    controller: ref
                                        .watch(addOfferProvider)
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AdditionalInfoFilterButton(
                                    text: 'Miejsce postojowe'.tr,
                                    controller: ref
                                        .watch(addOfferProvider)
                                        .parkingSpaceController,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AdditionalInfoFilterButton(
                                    text: 'Garaż'.tr,
                                    controller: ref
                                        .watch(addOfferProvider)
                                        .garageController,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AdditionalInfoFilterButton(
                                    text: 'Winda'.tr,
                                    controller: ref
                                        .watch(addOfferProvider)
                                        .elevatorController,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AdditionalInfoFilterButton(
                                    text: 'Ogród'.tr,
                                    controller: ref
                                        .watch(addOfferProvider)
                                        .gardenController,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AdditionalInfoFilterButton(
                                    text: 'Klimatyzacja'.tr,
                                    controller: ref
                                        .watch(addOfferProvider)
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
                              gradient:
                                  CustomBackgroundGradients.getbuttonGradient1(
                                      context, ref)),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10.0),
                              onTap: () {
                                ref
                                    .read(addOfferProvider.notifier)
                                    .sendData(context, ref);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text('Wystaw ogłoszenie'.tr,
                                      style: AppTextStyles.interMedium.copyWith(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color)),
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
        if (addOfferState.isLoading)
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
                    animatedTexts: addOfferState.statusMessages
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
          bottom: 0,
          right: 0,
          child: BottomBarMobile(),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: AppBarMobile(
            sideMenuKey: sideMenuKey,
          ),
        ),
      ],
    );
  }
}
