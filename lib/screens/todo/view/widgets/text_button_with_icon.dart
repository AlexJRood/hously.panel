import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';

class TextButtonWithIcon extends ConsumerWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? iconColor;
  final double verticalPadding;

  const TextButtonWithIcon({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.iconColor,
    this.verticalPadding = 4,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: TextButton(
        style: textButtonWithButtonStyle.copyWith(
            backgroundColor: WidgetStatePropertyAll(theme.textButtonColor)),
        onPressed:onTap,
        child: Row(
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 5, vertical: verticalPadding),
                child: Icon(
                  icon,
                  color: iconColor ?? theme.taskHeaderColor,
                  size: 20,
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                label,
                style: AppTextStyles.interSemiBold14
                    .copyWith(color: theme.taskHeaderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
