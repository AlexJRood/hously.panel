import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class MessageWidget extends ConsumerWidget {
  final String message;

  const MessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Container(
        height: 40,
       // padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: theme.fillColor,
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.error_outline_sharp,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(flex: 1,
              child: Text(
                message,
                style: TextStyle(fontSize: 12.0, color: theme.textFieldColor),
              ),
            ),
            Spacer(),
            TextButton(onPressed: () {}, child: const Text('Edit')),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                ))
          ],
        ));
  }
}
