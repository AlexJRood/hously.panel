import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class SettingslogoutPc extends ConsumerWidget {
  const SettingslogoutPc({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);

    return Container(
      color: Colors.transparent,
    );
  }
}
