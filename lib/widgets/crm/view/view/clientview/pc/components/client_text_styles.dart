import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

TextStyle headerStyle(BuildContext context, WidgetRef ref) {
  final theme = ref.watch(themeColorsProvider);
  return TextStyle(
    color: theme.mobileTextcolor,
    fontWeight: FontWeight.bold,
  );
}

TextStyle customtextStyle(BuildContext context, WidgetRef ref) {
  final theme = ref.watch(themeColorsProvider);
  return TextStyle(color: theme.mobileTextcolor);
}

TextStyle textStylesubheading(BuildContext context, WidgetRef ref) {
  final theme = ref.watch(themeColorsProvider);
  return TextStyle(color: theme.mobileTextcolor.withOpacity(0.7), fontSize: 12);
}
