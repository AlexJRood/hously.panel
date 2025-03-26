import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class CustomListTile extends ConsumerWidget {
  final String title;
  final VoidCallback onTap;
  final bool tilecheck;

  const CustomListTile({
    super.key,
    this.tilecheck = true,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient: CustomBackgroundGradients.textFieldGradient(context, ref),
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  title,
                  style: TextStyle(
                    color: theme.themeTextColor, // Subtle white text
                    fontSize: 16,
                  ),
                ),
              ),
              tilecheck
                  ? Icon(
                      Icons.chevron_right,
                      color: theme.themeTextColor,
                    )
                  : SizedBox(
                      width: 40,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("4",
                              style: TextStyle(color: theme.themeTextColor)),
                          Icon(
                            Icons.chevron_right,
                            color: theme.themeTextColor,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
