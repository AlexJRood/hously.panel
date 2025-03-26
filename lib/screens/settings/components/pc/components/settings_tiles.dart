import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:hously_flutter/screens/settings/components/pc/components/settings_tile_providers.dart';
import 'package:hously_flutter/screens/settings/components/pc/components/user_tile.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class ListTileWidget extends ConsumerWidget {
  final String title;
  final int index;
  final VoidCallback? onTap;
  final int selectedIndex;
  const ListTileWidget({
    Key? key,
    required this.selectedIndex,
    required this.title,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final currentMode = ref.watch(isDefaultDarkSystemProvider);
    final colorscheme = ref.watch(colorSchemeProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        double padding = constraints.maxWidth < 600 ? 8 : 16;
        double fontSize = constraints.maxWidth < 600 ? 14 : 16;

        // Manage hover state
        ValueNotifier<bool> isHovered = ValueNotifier(false);

        return MouseRegion(
          onEnter: (_) {
            if (selectedIndex != index) isHovered.value = true;
          },
          onExit: (_) {
            if (selectedIndex != index) isHovered.value = false;
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: isHovered,
            builder: (context, hover, child) {
              return InkWell(
                onTap: onTap,
                child: Container(
                  height: 48,
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: hover
                        ? Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5) // Hover color
                        : currentMode
                            ? selectedIndex == index
                                ? theme.settingstile
                                : Colors.transparent
                            : selectedIndex == index
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7)
                                : Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title.tr,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: selectedIndex == index
                            ? colorscheme == FlexScheme.blackWhite
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context).iconTheme.color
                            : Theme.of(context).iconTheme.color,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

void showCustomMenu(
    BuildContext context, GlobalKey iconButtonKey, WidgetRef ref) {
  final theme = ref.watch(themeColorsProvider);
  final RenderBox button =
      iconButtonKey.currentContext!.findRenderObject() as RenderBox;
  // ignore: unnecessary_null_comparison
  if (button == null) return; // Handle null scenario

  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  final Offset buttonPosition =
      button.localToGlobal(Offset.zero, ancestor: overlay);

  final double leftPosition = buttonPosition.dx;
  final double topPosition = buttonPosition.dy + button.size.height;
  final double rightPosition = MediaQuery.of(context).size.width - leftPosition;
  final double bottomPosition =
      MediaQuery.of(context).size.height - topPosition;

  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      leftPosition,
      topPosition,
      rightPosition,
      bottomPosition,
    ),
    color: theme.popupcontainercolor,
    items: [
      PopupMenuItem(
        enabled: false,
        child: AccountSwitcherWidget(),
      ),
    ],
  ).then((value) {
    ref.watch(isClickprovider.notifier).toggle();
  });
}

// The account switcher widget
class AccountSwitcherWidget extends ConsumerStatefulWidget {
  @override
  _AccountSwitcherWidgetState createState() => _AccountSwitcherWidgetState();
}

class _AccountSwitcherWidgetState extends ConsumerState<AccountSwitcherWidget> {
  int selectedAccount = 0;

  final List<Map<String, dynamic>> accounts = [
    {
      'name': 'John Doe',
      'email': 'john@doe.com',
      'image': 'assets/images/image.png',
    },
    {
      'name': 'Company',
      'email': 'john@doe.com',
      'image': 'assets/images/image.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    return Container(
      width: 280, // Set menu width
      decoration: BoxDecoration(
        color: theme.popupcontainercolor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(accounts.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAccount = index;
                  });
                },
                child: SwitchUserTile(
                    selectedindex: selectedAccount,
                    index: index,
                    widget: Radio<int>(
                      value: index,
                      groupValue: selectedAccount,
                      activeColor: Theme.of(context).iconTheme.color,
                      onChanged: (int? value) {
                        setState(() {
                          selectedAccount = value!;
                        });
                      },
                    ),
                    title: accounts[index]['name'],
                    email: accounts[index]['email']),
              ),
            );
          }),
          Divider(color: Colors.grey[700]),
          GestureDetector(
            onTap: () {},
            child: Row(children: [
              const Spacer(),
              Icon(Icons.add, color: theme.whitewhiteblack),
              const SizedBox(
                width: 4,
              ),
              Text(
                'Add account',
                style: TextStyle(color: theme.whitewhiteblack),
              ),
              const Spacer(),
            ]),
          ),
        ],
      ),
    );
  }
}
