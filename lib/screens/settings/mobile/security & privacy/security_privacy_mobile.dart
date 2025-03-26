import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_security_tile.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/screens/settings/components/deviceinfo_widget.dart';
import 'package:hously_flutter/screens/settings/components/settings_button.dart';
import 'package:hously_flutter/screens/settings/mobile/security%20&%20privacy/pages/localsecurity_mobile..dart';
import 'package:hously_flutter/screens/settings/mobile/security%20&%20privacy/pages/password_change_mobile.dart';
import 'package:hously_flutter/screens/settings/mobile/security%20&%20privacy/pages/two_step_mobile.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:get/get_utils/get_utils.dart';

class SecurityPrivacyMobile extends ConsumerWidget {
  const SecurityPrivacyMobile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Scaffold(
      backgroundColor: theme.mobileBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MobileSettingsAppbar(
                title: "Bezpieczeństwo i Prywatność".tr,
                onPressed: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Password & Authentication",
                          style: TextStyle(color: theme.whitewhiteblack)),
                      SizedBox(
                        height: 10,
                      ),
                      CustomListTile(
                        title: "Password",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PasswordChangeMobile()));
                        },
                      ),
                      CustomListTile(
                        title: "Local Sequrity",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LocalsecurityMobile()));
                        },
                      ),
                      CustomListTile(
                        title: "Qr Code Login",
                        onTap: () {
                          print("Password tile tapped!");
                        },
                      ),
                      CustomListTile(
                        title: "Multi-Factor authentication",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TwoStepMobileScreen()));
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Aktywne sesje'.tr,
                        style: TextStyle(
                          color: theme.whitewhiteblack,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Oto wszystkie urządzenia, które są obecnie zalogowane. Możesz wylogować się z każdego z nich indywidualnie lub ze wszystkich innych urządzeń'
                            .tr,
                        style: TextStyle(
                            color: theme.popupcontainertextcolor, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'To urządzenie'.tr,
                        style: TextStyle(
                            color: theme.popupcontainertextcolor, fontSize: 12),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DeviceInfoWidget(
                        isPc: false,
                        ismac: true,
                        deviceName: 'Mac Book',
                        locationAndDate: 'Chisinau, Moldova · 06/08/3024',
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(color: theme.themeTextColor.withOpacity(0.5)),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Aktywne urządzenia'.tr,
                        style: TextStyle(color: theme.popupcontainertextcolor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // First Active Device
                      DeviceInfoWidget(
                        isPc: false,
                        deviceName: 'iPhone 12 Pro',
                        locationAndDate: 'Chisinau, Moldova · 06/08/3024',
                        onPressed: () {},
                      ),

                      const SizedBox(
                        height: 15,
                      ),
                      // Second Active Device
                      DeviceInfoWidget(
                        isPc: false,
                        deviceName: 'iPhone 12 Pro',
                        locationAndDate: 'Chisinau, Moldova · 06/08/3024',
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(color: theme.themeTextColor.withOpacity(0.5)),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Settingsbutton(
                                isPc: false,
                                buttonheight: 48,
                                onTap: () {},
                                text: "Log Out All Known Devices"),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
