import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/settings/components/gradient_dropdown.dart';
import 'package:hously_flutter/screens/settings/components/pc/components/settings_tile_providers.dart';
import 'package:hously_flutter/screens/settings/components/pc/notifcation%20components%20pc/notification_pc_components.dart';
import 'package:hously_flutter/screens/settings/components/security_screen_button.dart';
import 'package:hously_flutter/screens/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';

import 'package:hously_flutter/theme/apptheme.dart';

import '../../provider/notification_providers.dart';

class NotificationScreenPc extends ConsumerStatefulWidget {
  const NotificationScreenPc({super.key});

  @override
  ConsumerState<NotificationScreenPc> createState() =>
      _NotificationScreenPcState();
}

String? selectedItem;

class _NotificationScreenPcState extends ConsumerState<NotificationScreenPc> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    final notificationSettings = ref.watch(notificationSettingsProvider);
    final proTheme = ref.watch(isDefaultDarkSystemProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    final isToggled = ref.watch(toggleProvider);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isToggled == true) ...[
              const SizedBox(
                height: 1,
              ),
            ],
            HeadingText(text: 'Ustawienia globalne'.tr),
            const SizedBox(height: 15),
            NotificationToggleTilePc(
              togglevalue:
                  notificationSettings.settings['desktopNotification']!,
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
            Divider(color: theme.themeTextColor.withOpacity(0.5)),
            const SizedBox(height: 12),
            NotificationToggleTilePc(
              togglevalue: notificationSettings.settings['mobileNotification']!,
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
            Divider(color: theme.themeTextColor.withOpacity(0.5)),
            const SizedBox(height: 12),
            NotificationToggleTilePc(
              togglevalue: notificationSettings.settings['emailNotification']!,
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
            Divider(color: theme.themeTextColor.withOpacity(0.5)),
            const SizedBox(height: 12),
            NotificationToggleTilePc(
              togglevalue: notificationSettings.settings['allowSound']!,
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
            Divider(color: theme.themeTextColor.withOpacity(0.5)),
            const SizedBox(height: 12),
            NotificationToggleTilePc(
              togglevalue: notificationSettings.settings['flashTaskbar']!,
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
            HeadingText(text: 'Dźwięki'.tr),
            const SizedBox(
              height: 15,
            ),
            NotificationToggleTilePc(
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
            Divider(color: theme.themeTextColor.withOpacity(0.5)),
            const SizedBox(height: 12),
            NotificationToggleTilePc(
              title: 'Przypięte wiadomości',
              subtitle:
                  'Zachowaj ważne wiadomości łatwo dostępne na górze czatu',
              onChanged: (value) {
                ref
                    .read(notificationSettingsProvider.notifier)
                    .toggleSetting('pinnedMessages');
              },
              togglevalue: notificationSettings.settings['pinnedMessages']!,
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 810,
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
                    text: 'Godziny nie przeszkadzać'.tr,
                    color: proTheme
                        ? theme.bordercolor
                        : colorscheme == FlexScheme.blackWhite
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SubtitleText(
                      text:
                          'Dostosuj godziny ciszy, aby skupić się bez zakłóceń'
                              .tr),
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
                              isPc: true,
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
                            ? Theme.of(context).colorScheme.onSecondary
                            : Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SubtitleText(
                      text:
                          'Dostosuj, które zdarzenia lub wiadomości będą wyzwalały powiadomienia, aby pomóc Ci być na bieżąco'
                              .tr),
                  const SizedBox(
                    height: 25,
                  ),
                  NotificationToggleTilePc(
                    fontsize: 17,
                    title: 'Nowe prośby klientów',
                    subtitle:
                        'Otrzymuj powiadomienia, gdy klient złoży nowe zapytanie (np. przez formularze lub e-maile)',
                    onChanged: (value) {
                      ref
                          .read(notificationSettingsProvider.notifier)
                          .toggleSetting('clientRequest');
                    },
                    togglevalue:
                        notificationSettings.settings['clientRequest']!,
                  ),
                  const SizedBox(height: 4),
                  Divider(color: theme.themeTextColor.withOpacity(0.5)),
                  const SizedBox(height: 12),
                  NotificationToggleTilePc(
                    fontsize: 17,
                    title: 'Nowe możliwości',
                    subtitle:
                        'Powiadom, gdy zostanie zidentyfikowana nowa szansa sprzedaży dla klienta',
                    onChanged: (value) {
                      ref
                          .read(notificationSettingsProvider.notifier)
                          .toggleSetting('newOpertunities');
                    },
                    togglevalue:
                        notificationSettings.settings['newOpertunities']!,
                  ),
                  const SizedBox(height: 4),
                  Divider(color: theme.themeTextColor.withOpacity(0.5)),
                  const SizedBox(height: 12),
                  NotificationToggleTilePc(
                    fontsize: 17,
                    title: 'Przypomnienia o zadaniach',
                    subtitle:
                        'Powiadomienia o nadchodzących zadaniach lub terminach (np. przypomnienia o telefonach lub e-mailach do wykonania)',
                    onChanged: (value) {
                      ref
                          .read(notificationSettingsProvider.notifier)
                          .toggleSetting('taskManager');
                    },
                    togglevalue: notificationSettings.settings['taskManager']!,
                  ),
                  const SizedBox(height: 4),
                  Divider(color: theme.themeTextColor.withOpacity(0.5)),
                  const SizedBox(height: 12),
                  NotificationToggleTilePc(
                    fontsize: 17,
                    title: 'Zaprogramowane spotkania',
                    subtitle:
                        'Otrzymuj przypomnienia o nadchodzących spotkaniach lub rozmowach z klientami',
                    onChanged: (value) {
                      ref
                          .read(notificationSettingsProvider.notifier)
                          .toggleSetting('meetings');
                    },
                    togglevalue: notificationSettings.settings['meetings']!,
                  ),
                  const SizedBox(height: 4),
                  Divider(color: theme.themeTextColor.withOpacity(0.5)),
                  const SizedBox(height: 12),
                  NotificationToggleTilePc(
                    fontsize: 17,
                    title: 'Aktywność klienta',
                    subtitle:
                        'Powiadomienia, gdy klient podejmie działanie, takie jak kliknięcie w propozycję, dokonanie płatności lub zgłoszenie prośby o pomoc',
                    onChanged: (value) {
                      ref
                          .read(notificationSettingsProvider.notifier)
                          .toggleSetting('activity');
                    },
                    togglevalue: notificationSettings.settings['activity']!,
                  ),
                  const SizedBox(height: 4),
                  Divider(color: theme.themeTextColor.withOpacity(0.5)),
                  const SizedBox(height: 12),
                  NotificationToggleTilePc(
                    fontsize: 17,
                    title: 'Klienci z prośbami o wsparcie',
                    subtitle:
                        'Otrzymuj powiadomienia, gdy klient zgłosi prośbę o pomoc lub problem',
                    onChanged: (value) {
                      ref
                          .read(notificationSettingsProvider.notifier)
                          .toggleSetting('clientActivity');
                    },
                    togglevalue:
                        notificationSettings.settings['clientActivity']!,
                  ),
                  const SizedBox(height: 4),
                  Divider(color: theme.themeTextColor.withOpacity(0.5)),
                  const SizedBox(height: 12),
                  SizedBox(height: 30),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
