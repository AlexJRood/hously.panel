import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/screens/settings/settings_mobile.dart';
import 'package:hously_flutter/screens/settings/settings_pc.dart';
import 'package:hously_flutter/screens/settings/settings_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

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
          return const SettingsMobile();
        }
      },
    );
  }
}
