import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/settings/components/settings_button.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class SettingsLogoutMobile extends ConsumerWidget {
  const SettingsLogoutMobile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.read(themeColorsProvider);

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5), // Dim background
      body: Stack(
        children: [
          // Blur Effect
        
        ],
      ),
    );
  }
}
