import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class MobileSettingsAppbar extends ConsumerWidget {
  final String title;
  final void Function()? onPressed;
  const MobileSettingsAppbar(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Column(
      children: [
        const SizedBox(height: kIsWeb ? 10 : 30),
        Row(
          children: [
            const SizedBox(width: 10),
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.whitewhiteblack,
              ),
              onPressed: onPressed,
            ),
            const Spacer(),
            Text(
              overflow: TextOverflow.ellipsis,
              title,
              style: TextStyle(
                  color: theme.whitewhiteblack,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 30),
            const Spacer(),
          ],
        ),
        Divider(
            color: const Color.fromARGB(255, 152, 152, 152).withOpacity(0.2)),
      ],
    );
  }
}
