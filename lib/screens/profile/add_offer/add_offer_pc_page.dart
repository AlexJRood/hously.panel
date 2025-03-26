import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/profile/add_offer/add_provider.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_logo.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';

import '../../../widgets/side_menu/slide_rotate_menu.dart';

// ignore: must_be_immutable
class AddOfferPcPage extends ConsumerWidget {
  double addOfferFontSize = 14;
  double dynamiBoxHeigth = 15;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddOfferPcPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addOfferState = ref.watch(addOfferProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double textSideWidth = screenWidth / 2 - 100;
    double imageSideWidth = screenWidth / 2 - 85;
    double dynamicPadding = screenWidth / 50;

    double itemWidth = screenWidth / 1920 * 350;
    itemWidth = max(100.0, min(itemWidth, 300.0));

    double minBaseTextSize = 12;
    double maxBaseTextSize = 18;
    double baseTextSize = minBaseTextSize +
        (itemWidth - 150) / (240 - 150) * (maxBaseTextSize - minBaseTextSize);
    baseTextSize = max(minBaseTextSize, min(baseTextSize, maxBaseTextSize));

    final currentthememode = ref.watch(themeProvider);

    ScrollController scrollController = ScrollController();
    final sideMenuKey = GlobalKey<SideMenuState>();
    DropzoneViewController? dropzoneController;
    bool isHovered = false; // Tracks hover state
    final hoverNotifier =
        ref.read(hoverStateProvider.notifier); // Read notifier

    Future<void> handleFileDrop(dynamic file) async {
      try {
        ref.read(addOfferProvider.notifier).pickImage(); // Or save the file
      } catch (e) {
        print("Error handling dropped file: $e");
      }
    }

    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        KeyBoardShortcuts().handleKeyEvent(event, scrollController, 50, 100);
     
      },
      child: Scaffold(
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: CustomBackgroundGradients.getMainMenuBackground(
                          context, ref)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Sidebar(
                        sideMenuKey: sideMenuKey,
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: dynamicPadding),
                          child: Column(
                            children: [
                              const TopAppBarLogoRegisterPage(),
                              Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: textSideWidth,
                                      child: ScrollbarTheme(
                                        data: ScrollbarThemeData(
                                          thumbColor: MaterialStateProperty.all(
                                              AppColors.light
                                                  .withOpacity(0.35)),
                                          // Kolor kciuka paska przewijania
                                          thickness:
                                              MaterialStateProperty.all(4),
                                          // Grubość paska przewijania
                                          radius: const Radius.circular(
                                              8.0), // Promień zaokrąglenia krawędzi paska
                                          // Możesz także dostosować inne właściwości, takie jak kolor tła paska przewijania itp.
                                        ),
                                        child: Scrollbar(
                                          controller: scrollController,
                                          thumbVisibility: true,
                                          // Kciuk paska przewijania jest zawsze widoczny
                                          thickness: 4,
                                          // Grubość paska przewijania
                                          radius: const Radius.circular(8.0),
                                          // Zaokrąglenie krawędzi paska przewijania
                                          child: GestureDetector(
                                            onVerticalDragUpdate: (details) {
                                              // Manually scroll by dragging
                                              scrollController.jumpTo(
                                                scrollController.offset -
                                                    details.delta.dy,
                                              );
                                            },
                                            child: SingleChildScrollView(
                                              controller: scrollController,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              // Efekt przewijania dla iOS
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SelectButtonsOptionsWidget(
                                                      validator: (p0) {
                                                        if (p0 == null ||
                                                            p0.isEmpty) {
                                                          return 'this field can\'t be empty';
                                                        }
                                                        return null;
                                                      },
                                                      ref: ref,
                                                      controller: ref
                                                          .watch(
                                                              addOfferProvider)
                                                          .offerTypeController,
                                                      options: [
                                                        ButtonOption(
                                                            'Chcę sprzedać'.tr,
                                                            'sell'),
                                                        ButtonOption(
                                                            'Chcę wynająć'.tr,
                                                            'rent'),
                                                      ],
                                                      labelText:
                                                          'Co chcesz zrobić ze swoją nieruchomością?'
                                                              .tr,
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Pod jakim adresem znajduję się nieruchomość?'
                                                              .tr,
                                                          style: AppTextStyles
                                                              .interRegular
                                                              .copyWith(
                                                                  fontSize: 14,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .iconTheme
                                                                      .color),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                dynamiBoxHeigth),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  DropdownButtonFormFieldWidget(
                                                                controller: ref
                                                                    .watch(
                                                                        addOfferProvider)
                                                                    .countryController,
                                                                items: [
                                                                  'Polska'.tr,
                                                                  'Kraj 2'.tr,
                                                                  'Kraj 3'.tr
                                                                ],
                                                                labelText:
                                                                    'Kraj'.tr,
                                                                ref: ref,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    dynamiBoxHeigth),
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  DropdownButtonFormFieldWidget(
                                                                controller: ref
                                                                    .watch(
                                                                        addOfferProvider)
                                                                    .stateController,
                                                                items: const [
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
                                                                labelText:
                                                                    'Województwo'
                                                                        .tr,
                                                                ref: ref,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    dynamiBoxHeigth),
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  DropdownButtonFormFieldWidget(
                                                                controller: ref
                                                                    .watch(
                                                                        addOfferProvider)
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
                                                                labelText:
                                                                    'Miasto',
                                                                ref: ref,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                dynamiBoxHeigth),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 3,
                                                              child:
                                                                  DropdownButtonFormFieldWidget(
                                                                validator:
                                                                    (p0) {
                                                                  if (p0 ==
                                                                          null ||
                                                                      p0.isEmpty) {
                                                                    return 'this field can\'t be empty';
                                                                  }
                                                                  return null;
                                                                },
                                                                controller: ref
                                                                    .watch(
                                                                        addOfferProvider)
                                                                    .streetController,
                                                                items: const [
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
                                                                  'Widok',
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
                                                                labelText:
                                                                    'Adres'.tr,
                                                                ref: ref,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width:
                                                                    dynamiBoxHeigth),
                                                            Expanded(
                                                              flex: 2,
                                                              child:
                                                                  DropdownButtonFormFieldWidget(
                                                                controller: ref
                                                                    .watch(
                                                                        addOfferProvider)
                                                                    .zipcodeController,
                                                                items: const [
                                                                  '71204',
                                                                  '75488',
                                                                  '12345'
                                                                ],
                                                                labelText:
                                                                    'Kod pocztowy'
                                                                        .tr,
                                                                ref: ref,
                                                              ),
                                                            ),
                                                            const Spacer(
                                                                flex: 1),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    SelectButtonsOptionsWidget(
                                                      validator: (p0) {
                                                        if (p0 == null ||
                                                            p0.isEmpty) {
                                                          return 'this field can\'t be empty';
                                                        }
                                                        return null;
                                                      },
                                                      ref: ref,
                                                      controller: ref
                                                          .watch(
                                                              addOfferProvider)
                                                          .estateTypeController,
                                                      options: [
                                                        ButtonOption(
                                                            'Mieszkanie'.tr,
                                                            'Flat'),
                                                        ButtonOption(
                                                            'Kawalerka'.tr,
                                                            'Studio'),
                                                        ButtonOption(
                                                            'Apartament',
                                                            'Apartment'),
                                                        ButtonOption(
                                                            'Dom jednorodzinny'
                                                                .tr,
                                                            'House'),
                                                        ButtonOption(
                                                            'Bliźniak'.tr,
                                                            'Twin house'),
                                                        ButtonOption(
                                                            'Szeregowiec'.tr,
                                                            'Row house'),
                                                        ButtonOption(
                                                            'Inwestycje'.tr,
                                                            'Invest'),
                                                        ButtonOption(
                                                            'Działki'.tr,
                                                            'Lot'),
                                                        ButtonOption(
                                                            'Lokale użytkowe'
                                                                .tr,
                                                            'Commercial'),
                                                        ButtonOption(
                                                            'Hale i magazyny'
                                                                .tr,
                                                            'Warehouse'),
                                                        ButtonOption(
                                                            'Pokoje'.tr,
                                                            'Room'),
                                                        ButtonOption(
                                                            'Garaże'.tr,
                                                            'Garage'),
                                                      ],
                                                      labelText:
                                                          'Rodzaj nieruchomości'
                                                              .tr,
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    Text(
                                                      'Co chcesz powiedzieć innym o swojej nieruchomości?'
                                                          .tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    CustomTextField(
                                                      ref: ref,
                                                      controller: ref
                                                          .watch(
                                                              addOfferProvider)
                                                          .titleController,
                                                      labelText:
                                                          'Tytuł ogłoszenia'.tr,
                                                      maxLines: 1,
                                                      validator: (p0) {
                                                        if (p0 == null ||
                                                            p0.isEmpty) {
                                                          return 'this field can\'t be empty';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    CustomTextFieldDescription(
                                                      validator: (p0) {
                                                        if (p0 == null ||
                                                            p0.isEmpty) {
                                                          return 'this field can\'t be empty';
                                                        }
                                                        return null;
                                                      },
                                                      ref: ref,
                                                      controller: ref
                                                          .watch(
                                                              addOfferProvider)
                                                          .descriptionController,
                                                      labelText:
                                                          'Opis ogłoszenia'.tr,
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    Text(
                                                      'Jaka jest cena twojej nieruchomości?'
                                                          .tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child:
                                                              DropdownButtonFormFieldWidget(
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .currencyController,
                                                            items: const [
                                                              'PLN',
                                                              'EUR',
                                                              'GBP',
                                                              'USD',
                                                              'CZK'
                                                            ],
                                                            labelText:
                                                                'Waluta'.tr,
                                                            ref: ref,
                                                            validator: (p0) {
                                                              if (p0 == null ||
                                                                  p0.isEmpty) {
                                                                return 'this field can\'t be empty';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                dynamiBoxHeigth),
                                                        Expanded(
                                                          flex: 7,
                                                          child:
                                                              CustomNumberTextField(
                                                            ref: ref,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .priceController,
                                                            labelText:
                                                                'Za ile chcesz sprzedać swoją nieruchomość?'
                                                                    .tr,
                                                            unit: '',
                                                            validator: (p0) {
                                                              if (p0 == null ||
                                                                  p0.isEmpty) {
                                                                return 'this field can\'t be empty';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    Text(
                                                      'Dodaj trochę informacji o swojej nieruchomości'
                                                          .tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth /
                                                                2),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Wrap(
                                                                children: [
                                                                  SelectableButtonsFormFieldWidget(
                                                                    validator:
                                                                        (p0) {
                                                                      if (p0 ==
                                                                              null ||
                                                                          p0.isEmpty) {
                                                                        return 'this field can\'t be empty';
                                                                      }
                                                                      return null;
                                                                    },
                                                                    ref: ref,
                                                                    controller: ref
                                                                        .watch(
                                                                            addOfferProvider)
                                                                        .roomsController,
                                                                    // Przykładowy kontroler dla liczby pokoi
                                                                    options: const [
                                                                      '1',
                                                                      '2',
                                                                      '3',
                                                                      '4',
                                                                      '5',
                                                                      '6',
                                                                      '7+'
                                                                    ],
                                                                    // Lista opcji
                                                                    labelText:
                                                                        'Liczba pokoi'
                                                                            .tr,
                                                                  ),
                                                                ],
                                                              ),
                                                              Wrap(
                                                                children: [
                                                                  SelectableButtonsFormFieldWidget(
                                                                    validator:
                                                                        (p0) {
                                                                      if (p0 ==
                                                                              null ||
                                                                          p0.isEmpty) {
                                                                        return 'this field can\'t be empty';
                                                                      }
                                                                      return null;
                                                                    },
                                                                    ref: ref,
                                                                    controller: ref
                                                                        .watch(
                                                                            addOfferProvider)
                                                                        .bathroomsController,
                                                                    // Przykładowy kontroler dla liczby pokoi
                                                                    options: const [
                                                                      '1',
                                                                      '2',
                                                                      '3',
                                                                      '4',
                                                                      '5',
                                                                      '6',
                                                                      '7+'
                                                                    ],
                                                                    // Lista opcji
                                                                    labelText:
                                                                        'Liczba łazienek'
                                                                            .tr,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      dynamiBoxHeigth *
                                                                          1.5),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                    // Możesz dostosować wartość flex, aby zmienić proporcje rozmiaru pól
                                                                    child:
                                                                        CustomNumberTextField(
                                                                      ref: ref,
                                                                      controller: ref
                                                                          .watch(
                                                                              addOfferProvider)
                                                                          .floorController,
                                                                      // Kontroler piętra
                                                                      labelText:
                                                                          'Piętro'
                                                                              .tr,

                                                                      unit:
                                                                          'Piętro',
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          dynamiBoxHeigth),
                                                                  // Upewnij się, że ta wartość jest poprawna i nie jest zbyt duża
                                                                  Expanded(
                                                                    flex: 2,
                                                                    // Możesz dostosować wartość flex, aby zmienić proporcje rozmiaru pól
                                                                    child:
                                                                        CustomNumberTextField(
                                                                      ref: ref,
                                                                      controller: ref
                                                                          .watch(
                                                                              addOfferProvider)
                                                                          .totalFloorsController,
                                                                      // Kontroler liczby pięter
                                                                      labelText:
                                                                          'Liczba pięter'
                                                                              .tr,

                                                                      unit:
                                                                          'Pięter',
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                dynamiBoxHeigth *
                                                                    2),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                    height:
                                                                        dynamiBoxHeigth),
                                                                DropdownButtonFormFieldWidget(
                                                                  controller: ref
                                                                      .watch(
                                                                          addOfferProvider)
                                                                      .buildingTypeController,
                                                                  // Przekazanie kontrolera
                                                                  items: [
                                                                    'Blok'.tr,
                                                                    'Apartamentowiec'
                                                                        .tr,
                                                                    'Szeregowiec'
                                                                        .tr,
                                                                    'Kamienica'
                                                                        .tr,
                                                                    'Wieżowiec'
                                                                        .tr,
                                                                    'Loft'
                                                                  ],
                                                                  labelText:
                                                                      'Rodzaj zabudowy'
                                                                          .tr,
                                                                  ref: ref,
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        dynamiBoxHeigth),
                                                                DropdownButtonFormFieldWidget(
                                                                  controller: ref
                                                                      .watch(
                                                                          addOfferProvider)
                                                                      .heatingTypeController,
                                                                  // Przekazanie kontrolera
                                                                  items: [
                                                                    'Gazowe'.tr,
                                                                    'Elektryczne'
                                                                        .tr,
                                                                    'Miejskie'
                                                                        .tr,
                                                                    'Pompa ciepła'
                                                                        .tr,
                                                                    'Olejowe'
                                                                        .tr,
                                                                    'Wszystkie'
                                                                        .tr,
                                                                    'Nie podano informacji'
                                                                        .tr
                                                                  ],
                                                                  labelText:
                                                                      'Rodzaj ogrzewania'
                                                                          .tr,
                                                                  ref: ref,
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        dynamiBoxHeigth),
                                                                DropdownButtonFormFieldWidget(
                                                                  controller: ref
                                                                      .watch(
                                                                          addOfferProvider)
                                                                      .buildingMaterialController,
                                                                  // Przekazanie kontrolera
                                                                  items: [
                                                                    'Cegła'.tr,
                                                                    'Wielka płyta'
                                                                        .tr,
                                                                    'Silikat'
                                                                        .tr,
                                                                    'Beton'.tr,
                                                                    'Beton Komórkowy'
                                                                        .tr,
                                                                    'Pustak'.tr,
                                                                    'Żelbet'.tr,
                                                                    'Keramzyt'
                                                                        .tr,
                                                                    'Drewno'.tr,
                                                                    'Inne'.tr
                                                                  ],
                                                                  labelText:
                                                                      'Materiał budynku'
                                                                          .tr,
                                                                  ref: ref,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    Text(
                                                      'Informacje na temat nieruchomości'
                                                          .tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child:
                                                              CustomNumberTextField(
                                                            ref: ref,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .buildYearController,
                                                            // Do ustawienia kontroler roku budowy
                                                            labelText:
                                                                'Rok budowy'.tr,

                                                            unit: '',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width:
                                                                dynamiBoxHeigth),
                                                        Expanded(
                                                          flex: 5,
                                                          child:
                                                              CustomNumberTextField(
                                                            validator: (p0) {
                                                              if (p0 == null ||
                                                                  p0.isEmpty) {
                                                                return 'this field can\'t be empty';
                                                              }
                                                              return null;
                                                            },
                                                            ref: ref,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .squareFootageController,
                                                            // Przykładowy kontroler dla metrażu
                                                            labelText:
                                                                'Jaki jest metraż twojej nieruchomości?'
                                                                    .tr,

                                                            unit: 'm²',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    Text(
                                                      'Dodatkowe informacje'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    Wrap(
                                                      alignment:
                                                          WrapAlignment.start,
                                                      spacing: dynamiBoxHeigth,
                                                      runSpacing:
                                                          dynamiBoxHeigth,
                                                      children: [
                                                        AdditionalInfoFilterButton(
                                                            text: 'Balkon'.tr,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .balconyController),
                                                        AdditionalInfoFilterButton(
                                                            text: 'Taras'.tr,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .terraceController),
                                                        AdditionalInfoFilterButton(
                                                            text: 'Sauna',
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .saunaController),
                                                        AdditionalInfoFilterButton(
                                                            text: 'Jacuzzi',
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .jacuzziController),
                                                        AdditionalInfoFilterButton(
                                                            text: 'Piwnica'.tr,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .basementController),
                                                        AdditionalInfoFilterButton(
                                                            text: 'Winda'.tr,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .elevatorController),
                                                        AdditionalInfoFilterButton(
                                                            text: 'Ogród'.tr,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .gardenController),
                                                        AdditionalInfoFilterButton(
                                                            text: 'Klimatyzacja'
                                                                .tr,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .airConditioningController),
                                                        AdditionalInfoFilterButton(
                                                            text: 'Garaż'.tr,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .garageController),
                                                        AdditionalInfoFilterButton(
                                                            text:
                                                                'Miejsce postojowe'
                                                                    .tr,
                                                            controller: ref
                                                                .watch(
                                                                    addOfferProvider)
                                                                .parkingSpaceController),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                    SizedBox(
                                                        height:
                                                            dynamiBoxHeigth),
                                                  ],
                                                ),
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                      height: dynamiBoxHeigth),
                                                  // Etykieta "Twoje główne zdjęcie"
                                                  if (addOfferState
                                                      .imagesData.isNotEmpty)
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                        'Twoje główne zdjęcie'
                                                            .tr,
                                                        style: AppTextStyles
                                                            .interMedium
                                                            .copyWith(
                                                          fontSize: 18,
                                                          color:
                                                              Theme.of(context)
                                                                  .iconTheme
                                                                  .color,
                                                        ),
                                                      ),
                                                    ),

                                                  SizedBox(
                                                      height: dynamiBoxHeigth),
                                                  // Kontener dla głównego zdjęcia lub przycisku do wyboru zdjęć
                                                  FormField(
                                                    validator: (value) {
                                                      if (ref
                                                          .watch(
                                                              addOfferProvider)
                                                          .imagesData
                                                          .isEmpty) {
                                                        return 'This field cannot be empty.';
                                                      } else if (ref
                                                              .watch(
                                                                  addOfferProvider)
                                                              .imagesData
                                                              .length <
                                                          5) {
                                                        return 'Please select at least 5 images.';
                                                      }
                                                      return null;
                                                    },
                                                    builder: (FormFieldState
                                                        fieldState) {
                                                      final addOfferState =
                                                          ref.watch(
                                                              addOfferProvider);
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                imageSideWidth,
                                                            height:
                                                                imageSideWidth *
                                                                    (650 /
                                                                        1200),
                                                            child: addOfferState
                                                                    .imagesData
                                                                    .isNotEmpty
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      int indexToSet =
                                                                          addOfferState.mainImageIndex ??
                                                                              0;
                                                                      ref
                                                                          .read(addOfferProvider
                                                                              .notifier)
                                                                          .setMainImageIndex(
                                                                              indexToSet);
                                                                    },
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      children: [
                                                                        Image
                                                                            .memory(
                                                                          addOfferState
                                                                              .imagesData[0],
                                                                          width:
                                                                              imageSideWidth,
                                                                          height:
                                                                              imageSideWidth * (650 / 1200),
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        ),
                                                                        if (addOfferState.mainImageIndex !=
                                                                            null)
                                                                          const Icon(
                                                                              Icons.star,
                                                                              color: AppColors.light),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      await ref
                                                                          .read(
                                                                              addOfferProvider.notifier)
                                                                          .pickImage();
                                                                    },
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              double.infinity,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            gradient:
                                                                                CustomBackgroundGradients.getaddpagebackground(context, ref),
                                                                            border:
                                                                                Border.all(color: Theme.of(context).iconTheme.color!),
                                                                            borderRadius:
                                                                                BorderRadius.circular(12),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Icon(
                                                                              Icons.camera_alt,
                                                                              color: Theme.of(context).iconTheme.color,
                                                                              size: 48,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Positioned
                                                                            .fill(
                                                                          child:
                                                                              DropzoneView(
                                                                            onCreated: (controller) =>
                                                                                dropzoneController = controller,
                                                                            onDropFile:
                                                                                (file) async {
                                                                              await ref.read(addOfferProvider.notifier).handleFileDrop(file, dropzoneController!);
                                                                            },
                                                                            mime: const [
                                                                              'image/png',
                                                                              'image/jpeg',
                                                                              'image/webp',
                                                                              'image/svg+xml',
                                                                            ],
                                                                            onHover: () =>
                                                                                hoverNotifier.setHovered(true),
                                                                            onLeave: () =>
                                                                                hoverNotifier.setHovered(false),
                                                                            operation:
                                                                                DragOperation.copy,
                                                                          ),
                                                                        ),
                                                                        if (ref.watch(
                                                                            hoverStateProvider))
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.black.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(12),
                                                                            ),
                                                                            child:
                                                                                const Align(
                                                                              alignment: Alignment.topCenter,
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(top: 110.0),
                                                                                child: Text(
                                                                                  "Drop files here",
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                    fontSize: 16,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                          ),
                                                          if (fieldState
                                                              .hasError)
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 8.0),
                                                              child: Text(
                                                                fieldState
                                                                    .errorText!,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                        ],
                                                      );
                                                    },
                                                  ),

                                                  SizedBox(
                                                      height: dynamiBoxHeigth),

                                                  // Etykieta "Pozostałe zdjęcia"
                                                  if (addOfferState.imagesData
                                                          .isNotEmpty &&
                                                      addOfferState.imagesData
                                                              .length >
                                                          1)
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Pozostałe zdjęcia'
                                                                .tr,
                                                            style: AppTextStyles
                                                                .interMedium
                                                                .copyWith(
                                                              fontSize: 18,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Wybierz główne zdjęcie klikając w miniatrurkę'
                                                                .tr,
                                                            style: AppTextStyles
                                                                .interMedium
                                                                .copyWith(
                                                              fontSize: 12,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color,
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
                                                    itemCount: addOfferState
                                                            .imagesData.length +
                                                        1,
                                                    // Dodaj +1 do liczby elementów
                                                    itemBuilder:
                                                        (context, index) {
                                                      // Sprawdzenie, czy bieżący indeks to ostatni kafelek
                                                      if (index ==
                                                          addOfferState
                                                              .imagesData
                                                              .length) {
                                                        // Renderowanie przycisku dodawania zdjęć
                                                        return InkWell(
                                                          onTap: () => ref
                                                              .read(
                                                                  addOfferProvider
                                                                      .notifier)
                                                              .pickImage(),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: currentthememode ==
                                                                      ThemeMode
                                                                          .dark
                                                                  ? AppColors
                                                                      .dark
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Icon(
                                                              Icons.add,
                                                              // Ikona plusa
                                                              color: currentthememode ==
                                                                      ThemeMode
                                                                          .dark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              size: 24,
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        // Renderowanie miniatury zdjęcia
                                                        return GestureDetector(
                                                          onTap: () {
                                                            ref
                                                                .read(addOfferProvider
                                                                    .notifier)
                                                                .setMainImageIndex(
                                                                    index);
                                                          },
                                                          child: AspectRatio(
                                                            aspectRatio: 1,
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    image:
                                                                        DecorationImage(
                                                                      image: MemoryImage(
                                                                          addOfferState
                                                                              .imagesData[index]),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .red),
                                                                  onPressed:
                                                                      () {
                                                                    if (addOfferState
                                                                        .imagesData
                                                                        .isNotEmpty) {
                                                                      ref
                                                                          .read(addOfferProvider
                                                                              .notifier)
                                                                          .removeImage(
                                                                              index);
                                                                    } else {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content:
                                                                              Text('Musisz dodać co najmniej 4 zdjęcia.'.tr),
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
                                                  gradient:
                                                      CustomBackgroundGradients
                                                          .getbuttonGradient1(
                                                              context, ref),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    onTap: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        ref
                                                            .read(
                                                                addOfferProvider
                                                                    .notifier)
                                                            .sendData(
                                                                context, ref);
                                                      }
                                                      // ref
                                                      //     .read(addOfferProvider
                                                      //         .notifier)
                                                      //     .sendData(context, ref);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  baseTextSize *
                                                                      1.5,
                                                              vertical:
                                                                  baseTextSize /
                                                                      5),
                                                      child: Text(
                                                          'Wystaw ogłoszenie'
                                                              .tr,
                                                          style: AppTextStyles
                                                              .interMedium
                                                              .copyWith(
                                                                  fontSize:
                                                                      baseTextSize,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .iconTheme
                                                                      .color)),
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
                              ),
                            ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HoverStateNotifier extends StateNotifier<bool> {
  HoverStateNotifier() : super(false);

  void setHovered(bool hovered) => state = hovered;
}

// Provider for the hover state
final hoverStateProvider = StateNotifierProvider<HoverStateNotifier, bool>(
  (ref) => HoverStateNotifier(),
);
