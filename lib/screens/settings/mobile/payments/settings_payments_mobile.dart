import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/screens/settings/components/settings_button.dart';
import 'package:hously_flutter/screens/settings/mobile/payments/pages/add_payment_screen.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class SettingsPaymentsMobile extends ConsumerWidget {
  const SettingsPaymentsMobile({super.key});

  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);

    return Scaffold(
      backgroundColor: theme.mobileBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AppBar Section
          MobileSettingsAppbar(
            title: "Payments",
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          // Scrollable Fields Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Metody płatności".tr,
                          style: TextStyle(color: theme.whitewhiteblack)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Brak zapisanej metody płatności".tr,
                          style: TextStyle(
                              color: theme.whitewhiteblack, fontSize: 12)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Szybsza realizacja transakcji Zapisując metodę".tr,
                          style: TextStyle(
                              color: theme.popupcontainertextcolor,
                              fontSize: 12)),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomElevatedButton(
                        text: 'Dodaj metodę płatności'.tr,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddPaymentScreen()));
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Historia transakcji".tr,
                          style: TextStyle(
                              color: theme.whitewhiteblack, fontSize: 12)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Zobacz szczegóły swoich poprzednich płatności i faktur"
                              .tr
                              .tr,
                          style: TextStyle(
                              color: theme.popupcontainertextcolor,
                              fontSize: 12)),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0xff2e343b)),
                        child: Center(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            "Zobacz historię".tr,
                            style: const TextStyle(
                                fontSize: 12, color: Color(0xffa1ece6)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
