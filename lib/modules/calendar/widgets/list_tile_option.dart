import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class ListTileOption extends ConsumerWidget {
  const ListTileOption({
    super.key,
    required this.title,
    required this.details,
    required this.onTapped,
  });

  final String title;
  final String details;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final deviceWidth = MediaQuery.of(context).size.width;
    final detailsTextStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 17, color: theme.textFieldColor);

    return ListTile(
      title: Text(title, style: detailsTextStyle),
      onTap: onTapped,
      contentPadding: EdgeInsets.zero,
      trailing: SizedBox(
        width: deviceWidth * 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              details,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 3),
             Icon(
              Icons.arrow_forward_ios,
              color:theme.textFieldColor.withOpacity(0.5),
              size: 16,
            ),
          ],
        ),
      ),
      minLeadingWidth: 20,
    );
  }
}
