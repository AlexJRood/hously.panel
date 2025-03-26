import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class Settingsbutton extends ConsumerWidget {
  final double buttonheight;
  final VoidCallback onTap;
  final String text;
  final bool backgroundcolor;
  final bool isborder;
  final bool hasIcon;
  final bool isPc;
  final IconData icon;
  const Settingsbutton({
    Key? key,
    this.icon = Icons.add,
    required this.isPc,
    this.hasIcon = false,
    required this.buttonheight,
    required this.onTap,
    required this.text,
    this.isborder = false,
    this.backgroundcolor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final currentMode = ref.watch(isDefaultDarkSystemProvider);
    final colorScheme = ref.watch(colorSchemeProvider);

    Color textColor = currentMode
        ? Colors.lightBlueAccent
        : (colorScheme == FlexScheme.blackWhite
            ? Theme.of(context).colorScheme.onSecondary
            : Theme.of(context).iconTheme.color!);

    Color btnBackgroundColor = backgroundcolor
        ? (currentMode
            ? theme.settingsButtoncolor
            : Theme.of(context).colorScheme.primary)
        : (isPc
            ? Colors.transparent
            : theme.popupcontainercolor.withOpacity(0.5));

    BorderSide borderSide = isborder
        ? BorderSide(width: 2, color: textColor)
        : BorderSide.none;

    final shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), side: borderSide);

    return SizedBox(
      height: buttonheight,
      child: hasIcon
          ? ElevatedButton.icon(
              icon: Icon(icon, color: textColor),
              iconAlignment: IconAlignment.start,
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(shape),
                backgroundColor: WidgetStatePropertyAll(btnBackgroundColor),
              ),
              onPressed: onTap,
              label: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: textColor, fontSize: 11),
              ),
            )
          : ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(shape),
                backgroundColor: WidgetStatePropertyAll(btnBackgroundColor),
              ),
              onPressed: onTap,
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isPc || backgroundcolor
                      ? textColor
                      : theme.whitewhiteblack,
                  fontSize: 11,
                ),
              ),
            ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool isicon;
  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.isicon = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isicon
        ? ElevatedButton.icon(
            icon: const Icon(
              Icons.attach_file_outlined,
              color: Colors.black,
            ),
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: const WidgetStatePropertyAll(Color(0xffc8c8c8)),
            ),
            onPressed: onTap,
            label: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
                fontSize: 11,
              ),
            ),
          )
        : ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: const WidgetStatePropertyAll(Color(0xffc8c8c8)),
            ),
            onPressed: onTap,
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
                fontSize: 11,
              ),
            ),
          );
  }
}
