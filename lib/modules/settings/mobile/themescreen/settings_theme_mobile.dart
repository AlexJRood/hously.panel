import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_theme_tile.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/coloschemepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsThemeMobile extends ConsumerWidget {
  const SettingsThemeMobile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final currentthememode = ref.watch(themeProvider);
    final colorScheme = ref.watch(colorSchemeProvider);
    final themeModeNotifier = ref.read(themeProvider.notifier);
    final themeContext = Theme.of(context);
    final scheme = themeContext.colorScheme;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient:
                CustomBackgroundGradients.getMainMenuBackground(context, ref)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MobileSettingsAppbar(
              title: "Motyw".tr,
              onPressed: () {
                Navigator.pop(context);
              }),
          Expanded(
            child: Container(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wyświetlacz'.tr,
                        style: TextStyle(
                            color: theme.mobileTextcolor, fontSize: 20),
                      ),
                      const SizedBox(height: 13),
                      Text(
                          'Wybierz opcję, która odpowiada Twoim preferencjom'
                              .tr,
                          style: TextStyle(
                              color: theme.mobileTextcolor, fontSize: 12)),
                      const SizedBox(
                        height: 20,
                      ),
                      ThemetileMobile(
                          gradient: BackgroundGradients.backgroundGradientRight,
                          currentheme: ThemeMode.system,
                          containercolor: Colors.white,
                          secondcolor: Colors.black,
                          title: 'Motyw systemowy'.tr,
                          isSelected: currentthememode == ThemeMode.system,
                          groupValue: currentthememode!,
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove('colorScheme');
                            final colorSchemeNotifier =
                                ref.read(colorSchemeProvider.notifier);
                            colorSchemeNotifier.state = null;
                            themeModeNotifier.state = ThemeMode.system;
                            savecurrenttheme(ThemeMode.system);
                          }),
                      const SizedBox(
                        height: 5,
                      ),
                      ThemetileMobile(
                          gradient: LinearGradient(
                            colors: [
                              scheme.primary.withOpacity(0.5),
                              scheme.secondary.withOpacity(0.5),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          title: 'Ciemny motyw'.tr,
                          containercolor: Colors.white,
                          secondcolor: Colors.grey,
                          currentheme: ThemeMode.light,
                          isSelected: currentthememode == ThemeMode.light,
                          groupValue: currentthememode,
                          onTap: () {
                            themeModeNotifier.state = ThemeMode.light;
                            savecurrentthemeDark(ref);
                          }),
                      const SizedBox(height: 5),
                      if (currentthememode != ThemeMode.system &&
                          colorScheme != null) ...[
                        ThemetileMobile(
                            title: 'Light Theme'.tr,
                            gradient: currentthememode == ThemeMode.dark &&
                                    colorScheme == null
                                ? const LinearGradient(
                                    colors: [Colors.black, Colors.black],
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                  )
                                : LinearGradient(
                                    colors: [scheme.primary, Colors.black],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                            containercolor: Colors.black,
                            secondcolor: Colors.white,
                            currentheme: ThemeMode.dark,
                            isSelected: currentthememode == ThemeMode.dark,
                            groupValue: currentthememode,
                            onTap: () {
                              themeModeNotifier.state = ThemeMode.dark;
                              savecurrenttheme(ThemeMode.dark);
                            }),
                      ],
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomProThemeMobile(),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
