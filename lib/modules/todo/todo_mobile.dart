import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/modules/todo/view/crm_tms_board.dart';
import 'package:hously_flutter/utils/Keyboardshortcuts.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/widgets/bars/bottom_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import '../../widgets/side_menu/slide_rotate_menu.dart';
import 'board/provider/board_details_provider.dart';
import 'board/provider/board_provider.dart';

final isDropdownExpandedProvider = StateProvider<bool>((ref) => false);
final selectedBoardProvider = StateProvider<int?>((ref) => null);

class ToDoMobile extends ConsumerStatefulWidget {
  const ToDoMobile({super.key});

  @override
  ConsumerState<ToDoMobile> createState() => _ToDoMobileState();
}

class _ToDoMobileState extends ConsumerState<ToDoMobile> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      ref.read(boardManagementProvider.notifier).fetchBoards(ref);
    });
  }

  void _toggleDropdown(WidgetRef ref) {
    ref.read(isDropdownExpandedProvider.notifier).state =
        !ref.read(isDropdownExpandedProvider);
  }

  void _selectBoard(int boardId, WidgetRef ref) {
    ref.read(selectedBoardProvider.notifier).state = boardId;
    ref.read(boardIdProvider.notifier).state = boardId;
    ref
        .read(boardDetailsManagementProvider.notifier)
        .fetchBoardDetails(boardId.toString());

    ref.read(isDropdownExpandedProvider.notifier).state =
        false; // Close dropdown
  }

  @override
  Widget build(BuildContext context) {
    final boardData = ref.watch(boardManagementProvider);
    final sideMenuKey = GlobalKey<SideMenuState>();
    final selectedBoardId = ref.watch(boardIdProvider);
    final selectedBoard = boardData.results?.isNotEmpty == true
        ? boardData.results!.firstWhere(
            (board) => board.id == selectedBoardId,
            orElse: () => boardData.results!.first,
          )
        : null;

    final isDropdownExpanded = ref.watch(isDropdownExpandedProvider);

    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        KeyBoardShortcuts().handleKeyNavigation(event, ref, context);
        final Set<LogicalKeyboardKey> pressedKeys =
            HardwareKeyboard.instance.logicalKeysPressed;
        final LogicalKeyboardKey? shiftKey = ref.watch(togglesidemenu1);
        if (pressedKeys.contains(ref.watch(adclientprovider)) &&
            !pressedKeys.contains(shiftKey)) {
          ref
              .read(navigationService)
              .pushNamedScreen(Routes.proFinanceRevenueAdd);
        }
        if (ref.read(navigationService).canBeamBack()) {
          KeyBoardShortcuts().handleBackspaceNavigation(event, ref);
        }
      },
      child: Scaffold(
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage("assets/images/To-do-background.png"),
                fit: BoxFit
                    .cover, // Adjust based on how you want the image to scale
              ),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      color: const Color.fromRGBO(0, 0, 0, 0.2),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                SideMenuManager.toggleMenu(
                                    ref: ref, menuKey: sideMenuKey);
                              },
                              icon: const Icon(Icons.menu)),
                          Expanded(
                            child: Center(
                              child: InkWell(
                                onTap: () => _toggleDropdown(ref),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      selectedBoard?.name ?? "Select Board",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      isDropdownExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.add))
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CrmToDoBoard(),
                      ),
                    ),
                    const BottomBarMobile(),
                  ],
                ),
                if (isDropdownExpanded)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () => _toggleDropdown(ref),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: MediaQuery.of(context).size.height / 2,
                          color: Colors.black.withOpacity(0.6),
                          child: Column(
                            children: [
                              const SizedBox(height: 80),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: boardData.count,
                                  itemBuilder: (context, index) {
                                    final data = boardData.results?[index];
                                    final isSelected =
                                        data?.id == selectedBoardId;

                                    return InkWell(
                                      onTap: () =>
                                          _selectBoard(data!.id!.toInt(), ref),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.blue.withOpacity(0.3)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: isSelected
                                                  ? Colors.blue
                                                  : Colors.white
                                                      .withOpacity(0.5)),
                                        ),
                                        child: Text(
                                          data?.name ?? "",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
