import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/settings/pc/mail/settings_mail_pc.dart';
import 'package:hously_flutter/widgets/language/values.dart';
import 'package:hously_flutter/modules/settings/mobile/chats/settings_chats_mobile.dart';
import 'package:hously_flutter/modules/settings/mobile/language/settings_language_mobile.dart';
import 'package:hously_flutter/modules/settings/mobile/logout/settings_logout_mobile.dart';
import 'package:hously_flutter/modules/settings/mobile/notification/settings_notification_mobile.dart';
import 'package:hously_flutter/modules/settings/mobile/payments/settings_payments_mobile.dart';
import 'package:hously_flutter/modules/settings/mobile/profile/settings_profile_mobile.dart';
import 'package:hously_flutter/modules/settings/mobile/security%20&%20privacy/security_privacy_mobile.dart';
import 'package:hously_flutter/modules/settings/mobile/themescreen/settings_theme_mobile.dart';
import 'package:hously_flutter/modules/settings/pc/Notifications/settings_notification_pc.dart';
import 'package:hously_flutter/modules/settings/pc/Security&privacy/settings_securityprivacy_pc.dart';
import 'package:hously_flutter/modules/settings/pc/chats/settings_chats_pc.dart';
import 'package:hously_flutter/modules/settings/pc/language/settings_language_pc.dart';
import 'package:hously_flutter/modules/settings/pc/logout/settings_lopgout_pc.dart';
import 'package:hously_flutter/modules/settings/pc/payments/settings_payment_pc.dart';
import 'package:hously_flutter/modules/settings/pc/profile/settings_profile_pc.dart';
import 'package:hously_flutter/modules/settings/pc/support/settings_support_pc.dart';
import 'package:hously_flutter/modules/settings/pc/themescreen/settings_theme_pc.dart';
import 'package:hously_flutter/modules/settings/pc/mail/settings_mail_pc.dart';
import 'package:hously_flutter/modules/settings/settings_mobile.dart';

import 'package:hously_flutter/modules/settings/settings_pc.dart';

class ProfilePageRouter extends ConsumerWidget {
  const ProfilePageRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          // Jeśli jest to aplikacja webowa lub aplikacja desktopowa z szerokością większą niż 1420
          return SettingsPc(
            currentindex: 0,
            page: settingsPages[0],
          );
        } else {
          // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
          return const SettingsProfileMobile();
        }
      },
    );
  }
}

class NotificationPageRouter extends ConsumerWidget {
  const NotificationPageRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          // Jeśli jest to aplikacja webowa lub aplikacja desktopowa z szerokością większą niż 1420
          return SettingsPc(
            currentindex: 1,
            page: settingsPages[1],
          );
        } else {
          // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
          return const SettingsNotificationMobile();
        }
      },
    );
  }
}

class SecurityPageRouter extends ConsumerWidget {
  const SecurityPageRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          // Jeśli jest to aplikacja webowa lub aplikacja desktopowa z szerokością większą niż 1420
          return SettingsPc(
            currentindex: 2,
            page: settingsPages[2],
          );
        } else {
          // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
          return const SecurityPrivacyMobile();
        }
      },
    );
  }
}

class SettingsPaymentPageRouter extends ConsumerWidget {
  const SettingsPaymentPageRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return SettingsPc(
            currentindex: 3,
            page: settingsPages[3],
          );
        } else {
          return const SettingsPaymentsMobile();
        }
      },
    );
  }
}

class SettingsLanguagePageRouter extends ConsumerWidget {
  const SettingsLanguagePageRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return SettingsPc(
            currentindex: 4,
            page: settingsPages[4],
          );
        } else {
          return const SettingsLanguageMobile();
        }
      },
    );
  }
}

class SettingsThemePageRouter extends ConsumerWidget {
  const SettingsThemePageRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return SettingsPc(
            currentindex: 5,
            page: settingsPages[5],
          );
        } else {
          return const SettingsThemeMobile();
        }
      },
    );
  }
}

class SettingsChatsPageRouter extends ConsumerWidget {
  const SettingsChatsPageRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return SettingsPc(
            currentindex: 6,
            page: settingsPages[6],
          );
        } else {
          return const SettingsChatsMobile();
        }
      },
    );
  }
}

class SettingsSupportPageRouter extends ConsumerWidget {
  const SettingsSupportPageRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return SettingsPc(
            currentindex: 7,
            page: settingsPages[7],
          );
        } else {
          return Scaffold(
            body: Container(
              color: Colors.red,
              child: const Center(child: Text("NOT MADE YET")),
            ),
          );
        }
      },
    );
  }
}

class SettingsLogoutPageRouter extends ConsumerWidget {
  const SettingsLogoutPageRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return SettingsPc(
            currentindex: 8,
            page: settingsPages[8],
          );
        } else {
          return const SettingsMobile();
        }
      },
    );
  }
}


class SettingsEmailPageRouter extends ConsumerWidget {
  const SettingsEmailPageRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return SettingsPc(
            currentindex: 9,
            page: settingsPages[9],
          );
        } else {
          return const EmailScreenPc();
        }
      },
    );
  }
}

final List<Widget> settingsPages = [
  const ProfileScreenPc(),
  const NotificationScreenPc(),
  const SecurityPrivacyScreenPc(),
  const SettingsPaymentPc(),
  SettingsLanguagePc(),
  const SettingsThemePc(),
  const SettingsChatsPc(),
  const SettingsSupportPc(),
  const SettingslogoutPc(),
  const EmailScreenPc(),
];
