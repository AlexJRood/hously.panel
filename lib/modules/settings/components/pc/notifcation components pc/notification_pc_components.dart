import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class NotificationToggleTilePc extends ConsumerWidget {
  final String title;
  final String subtitle;
  final double fontsize;
  final void Function(bool)? onChanged;
  final bool togglevalue;

  const NotificationToggleTilePc({
    super.key,
    this.fontsize = 15,
    required this.title,
    required this.subtitle,
    required this.onChanged,
    required this.togglevalue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);
    final thememodechecker = ref.watch(isDefaultDarkSystemProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    return ClipRect(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.tr,
                  style: TextStyle(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: fontsize),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle.tr,
                  style: TextStyle(
                      color:
                          Theme.of(context).iconTheme.color!.withOpacity(0.5)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Switch(
            thumbColor: WidgetStatePropertyAll(theme.fillColor),
            activeTrackColor: colorscheme == FlexScheme.blackWhite
                ? Colors.blue
                : Theme.of(context).colorScheme.secondary,
            value: togglevalue,
            onChanged: onChanged,
            activeColor: thememodechecker
                ? theme.togglebuttoncolor
                : colorscheme == FlexScheme.blackWhite
                    ? Colors.lightBlueAccent
                    : Theme.of(context).colorScheme.primary,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
