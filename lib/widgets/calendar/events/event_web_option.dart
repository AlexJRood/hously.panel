import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class EventWebOption extends ConsumerWidget {
  final IconData? iconData;
  final Widget secondWidget;
  final CrossAxisAlignment crossAxisAlignment;

  const EventWebOption({
    super.key,
    required this.iconData,
    required this.secondWidget,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Icon(
            iconData,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(child: secondWidget),
      ],
    );
  }
}
