import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/modules/settings/mobile/payments/pages/add_payment_screen.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class SettingsPaymentsMobile extends ConsumerWidget {
  const SettingsPaymentsMobile({super.key});

  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);

    return Scaffold(
      backgroundColor: theme.mobileBackground,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient:
              CustomBackgroundGradients.getMainMenuBackground(context, ref),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar Section
            MobileSettingsAppbar(
              title: "Payments",
              onPressed: () {
                ref.read(navigationService).beamPop();
              },
            ),

            // Scrollable Fields Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Metody płatności".tr,
                            style: TextStyle(color: theme.mobileTextcolor)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("Brak zapisanej metody płatności".tr,
                            style: TextStyle(
                                color: theme.mobileTextcolor, fontSize: 12)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Szybsza realizacja transakcji Zapisując metodę".tr,
                            style: TextStyle(
                                color: theme.mobileTextcolor, fontSize: 12)),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomElevatedButton(
                          text: 'Dodaj metodę płatności'.tr,
                          onTap: () {
                            ref
                                .read(navigationService)
                                .pushNamedScreen(Routes.addpayment);
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text("Historia transakcji".tr,
                            style: TextStyle(
                                color: theme.mobileTextcolor, fontSize: 12)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Zobacz szczegóły swoich poprzednich płatności i faktur"
                                .tr
                                .tr,
                            style: TextStyle(
                                color: theme.mobileTextcolor, fontSize: 12)),
                        const SizedBox(
                          height: 15,
                        ),
                        Settingsbutton(
                          isPc: false,
                          buttonheight: 40,
                          onTap: () {},
                          text: "Zobacz historię".tr,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
