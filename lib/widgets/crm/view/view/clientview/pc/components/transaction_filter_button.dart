import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class TransactionFilterButton extends ConsumerWidget {
  final String text;
  final void Function()? onTap;
  final bool isicon;
  const TransactionFilterButton({
    Key? key,
    required this.text,
    this.isicon = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return isicon
        ? ElevatedButton.icon(
            icon: Icon(
              Icons.tune,
              color: theme.textFieldColor,
            ),
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(theme.fillColor),
            ),
            onPressed: onTap,
            label: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.textFieldColor,
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
              backgroundColor: WidgetStatePropertyAll(theme.fillColor),
            ),
            onPressed: onTap,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.textFieldColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 11,
              ),
            ),
          );
  }
}
