import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/apptheme.dart';

class Textfieldcontainer extends ConsumerWidget {
  final double height;
  final Widget child;

  const Textfieldcontainer(
      {super.key, required this.height, required this.child});

  @override
  Widget build(BuildContext context, ref) {
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    // Set the width conditionally based on screen size
    final responsiveWidth = screenWidth < 1080
        ? screenWidth * 0.55 // For mobile
        : screenWidth * 0.38; // For PC
    final theme = ref.watch(themeColorsProvider);
    return Container(
      width: responsiveWidth, // Use responsive width
      height: height, // Use provided height
      decoration: BoxDecoration(
        color: theme.fillColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class SecondContainer extends ConsumerWidget {
  final Widget child;
  final double height;

  const SecondContainer({super.key, required this.child, required this.height});

  @override
  Widget build(BuildContext context, ref) {
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = ref.watch(themeColorsProvider);
    // Set the width conditionally based on screen size
    final responsiveWidth = screenWidth < 1080
        ? screenWidth * 0.65 // For mobile
        : screenWidth * 0.4; // For PC

    return Container(
      width: responsiveWidth, // Use responsive width
      height: height, // Use provided height
      decoration: BoxDecoration(
        color: theme.fillColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
