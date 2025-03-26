import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/screens/settings/components/pc/chats%20components%20pc/chats_pc_components.dart';
import 'package:hously_flutter/screens/settings/provider/chats_providers.dart';


import 'package:hously_flutter/screens/settings/components/pc/chats%20components%20pc/message_widget.dart';
import 'package:hously_flutter/screens/settings/components/pc/chats%20components%20pc/outofoffice_tile.dart';
import 'package:hously_flutter/screens/settings/components/settings_button.dart';
import 'package:hously_flutter/screens/settings/components/pc/components/settings_tile_providers.dart';
import 'package:hously_flutter/screens/settings/components/pc/components/settings_tiles.dart';
import 'package:hously_flutter/screens/settings/components/pc/notifcation%20components%20pc/notification_pc_components.dart';
import 'package:hously_flutter/screens/settings/components/security_screen_button.dart';

import 'package:hously_flutter/screens/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:hously_flutter/screens/settings/components/pc/theme%20components%20pc/theme_pc_components.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/theme/coloschemepicker.dart';

class SettingsChatsPc extends ConsumerWidget {
  const SettingsChatsPc({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final chatsSettings = ref.watch(chatsSettingsProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    final proTheme = ref.watch(isDefaultDarkSystemProvider);
    final isToggled = ref.watch(toggleProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isToggled == true) ...[
              const SizedBox(
                height: 1,
              ),
            ],
            HeadingText(text: 'Zablokowani użytkownicy'.tr),
            const SizedBox(
              height: 15,
            ),
            SubtitleText(
                text:
                    'Zapobiegaj niechcianym interakcjom, blokując użytkowników. Zablokowani użytkownicy nie będą widzieć Twojego profilu ani aktywności'
                        .tr),
            const SizedBox(
              height: 15,
            ),
            const BlockedUserTile(
                imageurl: 'assets/images/image.png',
                email: 'Muhammedansaf44@gmail.com',
                name: 'Muahmmed Ansaf'),
            const SizedBox(
              height: 15,
            ),
            const BlockedUserTile(
                imageurl: 'assets/images/image.png',
                email: 'Muhammedansaf44@gmail.com',
                name: 'Muahmmed Ansaf'),
            const SizedBox(
              height: 15,
            ),
            const BlockedUserTile(
                imageurl: 'assets/images/image.png',
                email: 'Muhammedansaf44@gmail.com',
                name: 'Muahmmed Ansaf'),
            const SizedBox(
              height: 15,
            ),
            Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 700,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient:
                        CustomBackgroundGradients.getSideMenuBackgroundcustom(
                            context, ref),
                    border: Border.all(
                        color: proTheme
                            ? theme.bordercolor
                            : colorscheme == FlexScheme.blackWhite
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).colorScheme.secondary,
                        width: 2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    HeadingText(
                      text: 'PRO Funkcje'.tr,
                      color: proTheme
                          ? theme.bordercolor
                          : colorscheme == FlexScheme.blackWhite
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    HeadingText(
                      text: 'Wiadomość poza biurem'.tr,
                      fontsize: 15,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SubtitleText(
                        text:
                            'Powiadom klientów o swojej niedostępności za pomocą dostosowywanej wiadomości'
                                .tr),
                    const SizedBox(
                      height: 20,
                    ),
                    const Outofofficetile(),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(color: theme.themeTextColor.withOpacity(0.5)),
                    const SizedBox(
                      height: 10,
                    ),
                    HeadingText(
                      text: 'Automatyczna odpowiedź'.tr,
                      fontsize: 15,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SubtitleText(
                        text:
                            'Skonfiguruj natychmiastowe odpowiedzi na najczęstsze pytania lub zgłoszenia'
                                .tr),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Expanded(
                            child: const MessageWidget(
                          message:
                              'Respond with: Thank you for contacting us we well get back to you shortly',
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(color: theme.themeTextColor.withOpacity(0.5)),
                    const SizedBox(
                      height: 10,
                    ),
                    NotificationToggleTilePc(
                      onChanged: (value) {
                        ref
                            .read(chatsSettingsProvider.notifier)
                            .toggleSetting('activestatus');
                      },
                      title: 'Status aktywności',
                      subtitle:
                          'Pokaż swoją dostępność klientom za pomocą wskaźników statusu w czasie rzeczywistym',
                      togglevalue: chatsSettings.settings['activestatus']!,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/status.png',
                      width: 214,
                      height: 132,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(color: theme.themeTextColor.withOpacity(0.5)),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRect(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Media'.tr,
                                  style: TextStyle(
                                      color: Theme.of(context).iconTheme.color,
                                      fontSize: 15),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Udostępniaj pliki, obrazy lub filmy bezproblemowo podczas rozmów'
                                      .tr,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .iconTheme
                                          .color!
                                          .withOpacity(0.5)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          CustomElevatedButton(
                              isicon: true, text: 'Media', onTap: () {})
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(color: theme.themeTextColor.withOpacity(0.5)),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
