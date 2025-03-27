import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/modules/settings/components/security_screen_button.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class PopupContainer extends ConsumerWidget {
  final List<Widget> widgets;
  final String text;
  final String subtext;
  final bool iscancel;
  final bool isbuttonvisible;
  final void Function()? onConfirm;
  final void Function()? onCancel;
  const PopupContainer(
      {super.key,
      required this.onCancel,
      required this.onConfirm,
      this.iscancel = true,
      this.isbuttonvisible = true,
      required this.widgets,
      required this.text,
      required this.subtext});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return GestureDetector(
      onTap: () {},
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 450,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.popupcontainercolor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text,
                style: TextStyle(color: theme.whitewhiteblack, fontSize: 15)),
            const SizedBox(height: 15),
            SubtitleText(
              text: subtext,
              color: theme.whitewhiteblack,
            ),
            const SizedBox(
              height: 15,
            ),
            ...widgets,
            SizedBox(
              height: 20,
            ),
            isbuttonvisible
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (iscancel)
                        Material(
                          color: Colors.transparent,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              overlayColor: const WidgetStatePropertyAll(
                                  Color.fromARGB(255, 91, 89, 89)),
                              elevation: const WidgetStatePropertyAll(0),
                              backgroundColor: WidgetStatePropertyAll(
                                  theme.popupcontainercolor),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            onPressed: onCancel,
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                color: theme.popupcontainertextcolor,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        )
                      else
                        const SizedBox(),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomElevatedButton(text: 'Confirm', onTap: onConfirm)
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
