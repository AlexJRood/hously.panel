import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/apptheme.dart';

class QuickAccessOption extends ConsumerWidget {
  const QuickAccessOption(this.title, this.child, {super.key});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: theme.textFieldColor),
            ),
            child,
          ],
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
