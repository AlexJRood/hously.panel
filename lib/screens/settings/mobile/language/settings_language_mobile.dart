import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/language/language_provider.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_appbar.dart';

import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/screens/settings/components/pc/components/settings_tile_providers.dart';
import 'package:hously_flutter/screens/settings/components/pc/language%20components%20pc/language_pc_components.dart';

import 'package:hously_flutter/theme/apptheme.dart';

class SettingsLanguageMobile extends ConsumerWidget {
  const SettingsLanguageMobile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final language = ref.watch(languageProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient:
                CustomBackgroundGradients.getMainMenuBackground(context, ref)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            MobileSettingsAppbar(
                title: "Język".tr,
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
                      const SizedBox(height: 15),
                      Text(
                        'Język'.tr,
                        style: TextStyle(
                          color: theme.mobileTextcolor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Wybierz preferowaną opcję wyświetlania i komunikacji'
                            .tr,
                        style: TextStyle(
                            color: theme.mobileTextcolor, fontSize: 12),
                      ),
                      const SizedBox(height: 15),
                      LanguageTile(
                        isPc: false,
                        onTap: () {
                          ref.read(languageProvider.notifier).setLanguage('en');
                          //widget.languageindex = 0;
                          toggleBoolean(ref);
                        },
                        index: 0,
                        groupValue: language.languageCode == 'en' ? 0 : 1,
                        countryname: 'English,UK',
                        countrycode: 'GB',
                      ),
                      const SizedBox(height: 15),
                      LanguageTile(
                        isPc: false,
                        onTap: () {
                          ref.read(languageProvider.notifier).setLanguage('pl');

                          // widget.languageindex = 1;
                          toggleBoolean(ref);
                        },
                        index: 1,
                        groupValue: language.languageCode == 'pl' ? 1 : 0,
                        countryname: 'Poland,PL',
                        countrycode: 'PL',
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
