import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/colors.dart';
import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/modules/settings/components/pc/components/settings_tile_providers.dart';
import 'package:hously_flutter/modules/settings/components/pc/components/settings_tiles.dart';
import 'package:hously_flutter/modules/settings/components/security_screen_button.dart';
import 'package:hously_flutter/modules/settings/components/pc/payment%20components%20pc/payment_pc_components.dart';
import 'package:hously_flutter/modules/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class SettingsPaymentPc extends ConsumerStatefulWidget {
  const SettingsPaymentPc({super.key});

  @override
  _SettingsPaymentPcState createState() => _SettingsPaymentPcState();
}

bool ishistory = false;

class _SettingsPaymentPcState extends ConsumerState<SettingsPaymentPc> {
  @override
  Widget build(BuildContext context) {
    final curentthememode = ref.watch(themeProvider);
    final isToggled = ref.watch(toggleProvider);

    final List<Map<String, String>> cardData = [
      {
        'cardNumber': '**** **** **** 6698',
        'validThru': '06/25',
        'cardHolderName': 'JOHN DOE',
      },
      {
        'cardNumber': '**** **** **** 1234',
        'validThru': '12/27',
        'cardHolderName': 'JANE SMITH',
      },
      {
        'cardNumber': '**** **** **** 9876',
        'validThru': '03/28',
        'cardHolderName': 'SAM WILSON',
      },
    ];

    return GestureDetector(
      onTap: () {
        setState(() {
          ishistory = false;
        });
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isToggled == true) ...[
                const SizedBox(
                  height: 1,
                ),
              ],
              HeadingText(text: 'Metody płatności'.tr),
              const SizedBox(height: 15),
              if (cardData.isEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: HeadingText(
                            text: 'Brak zapisanej metody płatności'.tr,
                            fontsize: 13,
                          ),
                        ),
                        const Expanded(flex: 3, child: SizedBox()),
                        if (cardData.isEmpty)
                          Expanded(
                            flex: 1,
                            child: CustomElevatedButton(
                              text: 'Dodaj metodę płatności'.tr,
                              onTap: () {},
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SubtitleText(
                      text:
                          'Dokonuj płatności szybciej, zapisując metodę płatności'
                              .tr,
                    ),
                  ],
                )
              else
                SubtitleText(
                  text:
                      'Tutaj możesz zarządzać wszystkimi swoimi oszczędnościami'
                          .tr,
                ),
              const SizedBox(height: 10),
              if (cardData.isNotEmpty)
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cardData.length + 1,
                    itemBuilder: (context, index) {
                      if (index < cardData.length) {
                        return CreditCardWidget(
                          gradient: curentthememode == ThemeMode.system ||
                                  curentthememode == ThemeMode.light
                              ? lighterGradients[
                                  index % lighterGradients.length]
                              : darkerGradients[index % darkerGradients.length],
                          cardNumber: cardData[index]['cardNumber']!,
                          validThru: cardData[index]['validThru']!,
                          cardHolderName: cardData[index]['cardHolderName']!,
                        );
                      } else {
                        return NewCardWidget(
                          onAddCard: () {
                            print("Add card button tapped!");
                          },
                        );
                      }
                    },
                  ),
                ),
              const SizedBox(height: 40),
              HeadingText(text: 'Historia transakcji'.tr),
              const SizedBox(height: 15),
              SubtitleText(
                  text:
                      'Zobacz szczegóły swoich poprzednich płatności i faktur.'
                          .tr),
              const SizedBox(height: 10),
              if (ishistory == false) ...[
                Settingsbutton(
                  isPc: true,
                  buttonheight: 40,
                  onTap: () {
                    setState(() {
                      ishistory = true;
                    });
                  },
                  text: 'Zobacz historię'.tr,
                )
              ],
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  if (ishistory == true) ...[const InvoiceTable()]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
