import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_notification_components.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_security_tile.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/screens/settings/components/pc/components/settings_tile_providers.dart';
import 'package:hously_flutter/screens/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:hously_flutter/screens/settings/components/settings_button.dart';
import 'package:hously_flutter/screens/settings/mobile/chats/pages/blocked_users.dart';
import 'package:hously_flutter/screens/settings/mobile/security%20&%20privacy/pages/password_change_mobile.dart';
import 'package:hously_flutter/screens/settings/provider/chats_providers.dart';
import 'package:hously_flutter/screens/settings/provider/notification_providers.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:get/get_utils/get_utils.dart';

class SettingsChatsMobile extends ConsumerWidget {
  const SettingsChatsMobile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);

    final chatsSettings = ref.watch(chatsSettingsProvider);
    final proTheme = ref.watch(isDefaultDarkSystemProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    final isToggled = ref.watch(toggleProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient:
                CustomBackgroundGradients.getMainMenuBackground(context, ref)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar Section
            MobileSettingsAppbar(
              title: "Czat".tr,
              onPressed: () {
                Navigator.pop(context);
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
                        Text("Zablokowani użytkownicy".tr,
                            style: TextStyle(color: theme.mobileTextcolor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Zapobiegaj niechcianym interakcjom, blokując użytkowników. Zablokowany nie zobaczy Twojego profilu ani aktywności."
                                .tr
                                .tr,
                            style: TextStyle(
                                color: theme.mobileTextcolor, fontSize: 12)),
                        SizedBox(
                          height: 10,
                        ),
                        CustomListTile(
                          tilecheck: false,
                          title: "Zablokowani użytkownicy".tr,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BlockedUsers()));
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: CustomBackgroundGradients
                                  .getSideMenuBackgroundcustom(context, ref),
                              border: Border.all(
                                  color: proTheme
                                      ? theme.bordercolor
                                      : colorscheme == FlexScheme.blackWhite
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary,
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
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSecondary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              NotificationToggleTileMobile(
                                onGradient: true,
                                title: 'Wiadomość poza biurem'.tr,
                                subtitle:
                                    'Powiadom klientów o swojej niedostępności za pomocą dostosowywanej wiadomości'
                                        .tr,
                                onChanged: (value) {
                                  ref
                                      .read(chatsSettingsProvider.notifier)
                                      .toggleSetting('activestatus');
                                },
                                togglevalue:
                                    chatsSettings.settings['activestatus']!,
                              ),
                              const SizedBox(height: 4),
                              Divider(
                                  color: theme.themeTextColor.withOpacity(0.5)),
                              const SizedBox(height: 12),
                              NotificationToggleTileMobile(
                                onGradient: true,
                                title: 'Automatyczna odpowiedź'.tr,
                                subtitle:
                                    'Set up instant responses to acknowledge or address common queries.',
                                onChanged: (value) {
                                  ref
                                      .read(chatsSettingsProvider.notifier)
                                      .toggleSetting('activestatus');
                                },
                                togglevalue:
                                    chatsSettings.settings['activestatus']!,
                              ),
                              const SizedBox(height: 4),
                              Divider(
                                  color: theme.themeTextColor.withOpacity(0.5)),
                              const SizedBox(height: 12),
                              NotificationToggleTileMobile(
                                onGradient: true,
                                title: 'Status aktywności'.tr,
                                subtitle:
                                    'Pokaż swoją dostępność klientom za pomocą wskaźników statusu w czasie rzeczywistym'
                                        .tr,
                                onChanged: (value) {
                                  ref
                                      .read(chatsSettingsProvider.notifier)
                                      .toggleSetting('activestatus');
                                },
                                togglevalue:
                                    chatsSettings.settings['activestatus']!,
                              ),
                              const SizedBox(height: 4),
                              Divider(
                                  color: theme.themeTextColor.withOpacity(0.5)),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Left side: title and subtitle
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Media',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: theme.themeTextColor
                                                .withOpacity(0.9),
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          'Udostępniaj pliki, obrazy lub filmy bezproblemowo podczas rozmów'
                                              .tr,
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: theme.themeTextColor
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Right side: paperclip icon
                                  Transform.rotate(
                                    angle: 0.9, // radians; ~5.73 degrees
                                    child: Icon(
                                      Icons.attach_file,
                                      color:
                                          theme.themeTextColor.withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              Divider(
                                  color: theme.themeTextColor.withOpacity(0.5)),
                              const SizedBox(height: 200),
                              Row(
                                children: [
                                  Expanded(
                                    child: Settingsbutton(
                                        isborder: colorscheme ==
                                            FlexScheme.blackWhite,
                                        icon: Icons.auto_awesome,
                                        hasIcon: true,
                                        isPc: false,
                                        buttonheight: 48,
                                        onTap: () {},
                                        text: "Upgrade to pro"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Fixed Bottom Button Section
          ],
        ),
      ),
    );
  }
}
