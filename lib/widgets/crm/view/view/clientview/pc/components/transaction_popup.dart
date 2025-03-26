import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

void showCustomMenutransaction(
    BuildContext context, GlobalKey transactionkey, WidgetRef ref) {
  final RenderBox button =
      transactionkey.currentContext!.findRenderObject() as RenderBox;

  if (button == null) return; // Handle null scenario

  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  final Offset buttonPosition =
      button.localToGlobal(Offset.zero, ancestor: overlay);

  final double leftPosition = buttonPosition.dx;
  final double topPosition = buttonPosition.dy + button.size.height;
final theme=ref.watch(themeColorsProvider);
  showMenu(
    menuPadding: const EdgeInsets.symmetric(vertical: 4),
    context: context,
    position: RelativeRect.fromLTRB(
      leftPosition,
      topPosition,
      leftPosition,
      topPosition,
    ),
    color: theme.fillColor,
    items: [
      PopupMenuItem(
        enabled: false,
        child: IconTheme(
          data:  IconThemeData(color:theme.textFieldColor),
          child: DefaultTextStyle(
            style:  TextStyle(fontSize: 12, color: theme.textFieldColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Row(
                    children: [
                      Icon(Icons.tune, size: 15),
                      SizedBox(width: 4),
                      Text("View details"),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () {
                    // Handle "Edit" tap
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.mode_edit_outlined, size: 15),
                      SizedBox(width: 4),
                      Text("Edit"),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: () {
                    // Handle "Send Invoice" tap
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.subdirectory_arrow_right_rounded, size: 15),
                      SizedBox(width: 4),
                      Text("Send Invoice"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}

class Customiconbuttom extends ConsumerWidget {
  const Customiconbuttom({super.key});

  @override
  Widget build(BuildContext context, ref) {
    GlobalKey transactionedit = GlobalKey();
    final theme = ref.watch(themeColorsProvider);
    return IconButton(
        key: transactionedit,
        onPressed: () {
          showCustomMenutransaction(context, transactionedit, ref);
        },
        icon: Icon(
          Icons.more_horiz_outlined,
          color: theme.whitewhiteblack,
        ));
  }
}
