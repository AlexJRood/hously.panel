import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/modules/settings/components/gradient_dropdown.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_notification_components.dart';
import 'package:hously_flutter/modules/settings/components/pc/components/settings_tile_providers.dart';
import 'package:hously_flutter/modules/settings/components/security_screen_button.dart';
import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/modules/settings/provider/notification_providers.dart';
import 'package:hously_flutter/modules/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:get/get_utils/get_utils.dart';

class SettingsNotificationMobile extends ConsumerStatefulWidget {
  const SettingsNotificationMobile({super.key});

  @override
  ConsumerState<SettingsNotificationMobile> createState() =>
      _SettingsNotificationMobileState();
}

String? selectedItem;

class _SettingsNotificationMobileState
    extends ConsumerState<SettingsNotificationMobile> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    final notificationSettings = ref.watch(notificationSettingsProvider);
    final proTheme = ref.watch(isDefaultDarkSystemProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    final isToggled = ref.watch(toggleProvider);
    final colorScheme = ref.watch(colorSchemeProvider);
   
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:
              CustomBackgroundGradients.getMainMenuBackground(context, ref),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            MobileSettingsAppbar(
                title: "Powiadomienia".tr,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Ustawienia globalne'.tr,
                        style: TextStyle(
                            color: theme.mobileTextcolor, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      NotificationToggleTileMobile(
                        togglevalue: notificationSettings
                            .settings['desktopNotification']!,
                        subtitle:
                            'Bądź na bieżąco z powiadomieniami w czasie rzeczywistym na swoim ekranie'
                                .tr,
                        onChanged: (togglevalue) {
                          ref
                              .read(notificationSettingsProvider.notifier)
                              .toggleSetting('desktopNotification');
                        },
                        title: 'Powiadomienia na pulpicie'.tr,
                      ),
                      const SizedBox(height: 4),
                      Divider(color: theme.themeTextColor),
                      const SizedBox(height: 12),
                      NotificationToggleTileMobile(
                        togglevalue: notificationSettings
                            .settings['mobileNotification']!,
                        subtitle:
                            'Bądź na bieżąco z powiadomieniami w czasie rzeczywistym na swoim ekranie'
                                .tr,
                        onChanged: (togglevalue) {
                          ref
                              .read(notificationSettingsProvider.notifier)
                              .toggleSetting('mobileNotification');
                        },
                        title: 'Powiadomienia mobilne'.tr,
                      ),
                      const SizedBox(height: 4),
                      Divider(color: theme.themeTextColor),
                      const SizedBox(height: 12),
                      NotificationToggleTileMobile(
                        togglevalue:
                            notificationSettings.settings['emailNotification']!,
                        subtitle:
                            'Bądź na bieżąco z powiadomieniami w czasie rzeczywistym na swoim ekranie'
                                .tr,
                        onChanged: (togglevalue) {
                          ref
                              .read(notificationSettingsProvider.notifier)
                              .toggleSetting('emailNotification');
                        },
                        title: 'Powiadomienia e-mail'.tr,
                      ),
                      const SizedBox(height: 4),
                      Divider(color: theme.themeTextColor),
                      const SizedBox(height: 12),
                      NotificationToggleTileMobile(
                        togglevalue:
                            notificationSettings.settings['allowSound']!,
                        title: 'Włącz dźwięk',
                        subtitle:
                            'Włącz powiadomienia dźwiękowe dla bardziej interaktywnego doświadczenia'
                                .tr,
                        onChanged: (value) {
                          ref
                              .read(notificationSettingsProvider.notifier)
                              .toggleSetting('allowSound');
                        },
                      ),
                      const SizedBox(height: 4),
                      Divider(color: theme.themeTextColor),
                      const SizedBox(height: 12),
                      NotificationToggleTileMobile(
                        togglevalue:
                            notificationSettings.settings['flashTaskbar']!,
                        title: 'Mignij paskiem zadań'.tr,
                        subtitle:
                            'Powiadom cię o pilnych aktualizacjach lub alertach za pomocą migającego paska zadań'
                                .tr,
                        onChanged: (value) {
                          ref
                              .read(notificationSettingsProvider.notifier)
                              .toggleSetting('flashTaskbar');
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Dźwięki'.tr,
                        style: TextStyle(
                            color: theme.mobileTextcolor, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      NotificationToggleTileMobile(
                        title: 'Wiadomości',
                        subtitle:
                            'Zachowaj ważne wiadomości łatwo dostępne na górze czatu',
                        onChanged: (value) {
                          ref
                              .read(notificationSettingsProvider.notifier)
                              .toggleSetting('messages');
                        },
                        togglevalue: notificationSettings.settings['messages']!,
                      ),
                      const SizedBox(height: 4),
                      Divider(color: theme.themeTextColor),
                      const SizedBox(height: 12),
                      NotificationToggleTileMobile(
                        title: 'Przypięte wiadomości',
                        subtitle:
                            'Zachowaj ważne wiadomości łatwo dostępne na górze czatu',
                        onChanged: (value) {
                          ref
                              .read(notificationSettingsProvider.notifier)
                              .toggleSetting('pinnedMessages');
                        },
                        togglevalue:
                            notificationSettings.settings['pinnedMessages']!,
                      ),
                      const SizedBox(
                        height: 25,
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
                              text: 'Godziny nie przeszkadzać'.tr,
                              color: proTheme
                                  ? theme.bordercolor
                                  : colorscheme == FlexScheme.blackWhite
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                      : Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Dostosuj godziny ciszy, aby skupić się bez zakłóceń'
                                  .tr,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .iconTheme
                                    .color!
                                    .withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            HeadingText(
                              text: 'WYBIERZ CZAS'.tr,
                              fontsize: 12,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: GradientDropdown(
                                        isPc: false,
                                        value: "",
                                        gradientcontroller: false,
                                        hintText: 'Select a time',
                                        items: const [
                                          '50 minutes',
                                          '30 minutes',
                                          '10 minutes',
                                          '5 minutes',
                                        ],
                                        selectedItem: selectedItem,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedItem = value;
                                          });
                                        })),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            HeadingText(
                              text: 'Niestandardowe filtry powiadomień'.tr,
                              color: proTheme
                                  ? theme.bordercolor
                                  : colorscheme == FlexScheme.blackWhite
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                      : Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Dostosuj, które zdarzenia lub wiadomości będą wyzwalały powiadomienia, aby pomóc Ci być na bieżąco'
                                  .tr,
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .iconTheme
                                    .color!
                                    .withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            NotificationToggleTileMobile(
                              onGradient: true,
                              title: 'Nowe prośby klientów',
                              subtitle:
                                  'Otrzymuj powiadomienia, gdy klient złoży nowe zapytanie (np. przez formularze lub e-maile)',
                              onChanged: (value) {
                                ref
                                    .read(notificationSettingsProvider.notifier)
                                    .toggleSetting('clientRequest');
                              },
                              togglevalue: notificationSettings
                                  .settings['clientRequest']!,
                            ),
                            const SizedBox(height: 4),
                            Divider(color: theme.themeTextColor),
                            const SizedBox(height: 12),
                            NotificationToggleTileMobile(
                              onGradient: true,
                              title: 'Nowe możliwości',
                              subtitle:
                                  'Powiadom, gdy zostanie zidentyfikowana nowa szansa sprzedaży dla klienta',
                              onChanged: (value) {
                                ref
                                    .read(notificationSettingsProvider.notifier)
                                    .toggleSetting('newOpertunities');
                              },
                              togglevalue: notificationSettings
                                  .settings['newOpertunities']!,
                            ),
                            const SizedBox(height: 4),
                            Divider(color: theme.themeTextColor),
                            const SizedBox(height: 12),
                            NotificationToggleTileMobile(
                              onGradient: true,
                              title: 'Przypomnienia o zadaniach',
                              subtitle:
                                  'Powiadomienia o nadchodzących zadaniach lub terminach (np. przypomnienia o telefonach lub e-mailach do wykonania)',
                              onChanged: (value) {
                                ref
                                    .read(notificationSettingsProvider.notifier)
                                    .toggleSetting('taskManager');
                              },
                              togglevalue:
                                  notificationSettings.settings['taskManager']!,
                            ),
                            const SizedBox(height: 4),
                            Divider(color: theme.themeTextColor),
                            const SizedBox(height: 12),
                            NotificationToggleTileMobile(
                              onGradient: true,
                              title: 'Zaprogramowane spotkania',
                              subtitle:
                                  'Otrzymuj przypomnienia o nadchodzących spotkaniach lub rozmowach z klientami',
                              onChanged: (value) {
                                ref
                                    .read(notificationSettingsProvider.notifier)
                                    .toggleSetting('meetings');
                              },
                              togglevalue:
                                  notificationSettings.settings['meetings']!,
                            ),
                            const SizedBox(height: 4),
                            Divider(color: theme.themeTextColor),
                            const SizedBox(height: 12),
                            NotificationToggleTileMobile(
                              onGradient: true,
                              title: 'Aktywność klienta',
                              subtitle:
                                  'Powiadomienia, gdy klient podejmie działanie, takie jak kliknięcie w propozycję, dokonanie płatności lub zgłoszenie prośby o pomoc',
                              onChanged: (value) {
                                ref
                                    .read(notificationSettingsProvider.notifier)
                                    .toggleSetting('activity');
                              },
                              togglevalue:
                                  notificationSettings.settings['activity']!,
                            ),
                            const SizedBox(height: 4),
                            Divider(color: theme.themeTextColor),
                            const SizedBox(height: 12),
                            NotificationToggleTileMobile(
                              onGradient: true,
                              title: 'Klienci z prośbami o wsparcie',
                              subtitle:
                                  'Otrzymuj powiadomienia, gdy klient zgłosi prośbę o pomoc lub problem',
                              onChanged: (value) {
                                ref
                                    .read(notificationSettingsProvider.notifier)
                                    .toggleSetting('clientActivity');
                              },
                              togglevalue: notificationSettings
                                  .settings['clientActivity']!,
                            ),
                            const SizedBox(height: 4),
                            Divider(color: theme.themeTextColor),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Settingsbutton(
                                      icon: Icons.auto_awesome,
                                      hasIcon: true,
                                      isPc: false,
                                      isborder:
                                          colorScheme == FlexScheme.blackWhite,
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
                        height: 10,
                      ),
                    ],
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
