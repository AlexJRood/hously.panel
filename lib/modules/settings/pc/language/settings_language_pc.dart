import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/language/language_provider.dart';
import 'package:hously_flutter/modules/settings/components/pc/components/settings_tile_providers.dart';

import 'package:hously_flutter/modules/settings/components/security_screen_button.dart';
import 'package:hously_flutter/modules/settings/components/pc/language%20components%20pc/language_pc_components.dart';

import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/modules/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';

class SettingsLanguagePc extends ConsumerStatefulWidget {

  SettingsLanguagePc({super.key, });

  @override
  ConsumerState<SettingsLanguagePc> createState() => _SettingsLanguagePcState();
}

class _SettingsLanguagePcState extends ConsumerState<SettingsLanguagePc> {
  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            HeadingText(text: 'Język'.tr),
            const SizedBox(height: 15),
            SubtitleText(
              text: 'Wybierz preferowaną opcję wyświetlania i komunikacji'.tr,
            ),
            const SizedBox(height: 15),
            LanguageTile(isPc: false,
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
            LanguageTile(isPc: false,
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
    );
  }
}
