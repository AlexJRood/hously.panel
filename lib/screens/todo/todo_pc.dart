// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/todo/view/crm_tms_board.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm.dart';
import 'package:hously_flutter/widgets/drad_scroll_widget.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_crm.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';
import 'board/provider/board_details_provider.dart';
import 'board/provider/board_provider.dart';

class ToDoPc extends ConsumerStatefulWidget {
  const ToDoPc({super.key});

  @override
  ConsumerState<ToDoPc> createState() => _ToDoPcState();
}

class _ToDoPcState extends ConsumerState<ToDoPc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() async {
      ref.read(boardManagementProvider.notifier).fetchBoards(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final boardData = ref.watch(boardManagementProvider);
    final sideMenuKey = GlobalKey<SideMenuState>();
    final selectedBoardId = ref.watch(boardIdProvider);
    final _scrollControllervertical = ScrollController();
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        // Check if the pressed key matches the stored pop key
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
            child: Row(
              children: [
                SidebarAgentCrm(
                  sideMenuKey: sideMenuKey,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TopAppBarCRM(routeName: Routes.proTodo),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                  width: 120,
                                  color: Colors.transparent,
                                  child: DragScrollView(
                                    controller: _scrollControllervertical,
                                    scrollDirection: Axis.vertical,
                                    child: ListView.builder(
                                      itemCount: boardData.count,
                                      itemBuilder: (context, index) {
                                        final data = boardData.results?[index];
                                        final isSelected =
                                            data?.id == selectedBoardId;

                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 18),
                                          child: InkWell(
                                            onTap: () {
                                              ref
                                                  .read(
                                                      boardIdProvider.notifier)
                                                  .state = data!.id!.toInt();
                                              ref
                                                  .read(
                                                      boardDetailsManagementProvider
                                                          .notifier)
                                                  .fetchBoardDetails(
                                                      data.id.toString());
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: isSelected
                                                      ? const Color.fromRGBO(
                                                          255, 255, 255, 0.2)
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: isSelected
                                                      ? Border.all(
                                                          color: const Color
                                                              .fromRGBO(
                                                              145, 145, 145, 1))
                                                      : null),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 15),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaX:
                                                                    isSelected
                                                                        ? 0
                                                                        : 5,
                                                                sigmaY:
                                                                    isSelected
                                                                        ? 0
                                                                        : 5),
                                                        child: Container(
                                                          height: 80,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isSelected
                                                                ? Colors.white
                                                                : Colors.white
                                                                    .withOpacity(
                                                                        0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      '${data?.name}',
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .textColorLight,
                                                        fontSize: 16,
                                                        fontWeight: isSelected
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                              const Expanded(flex: 9, child: CrmToDoBoard()),
                            ],
                          ),
                        ),
                      ),
                    ],
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
