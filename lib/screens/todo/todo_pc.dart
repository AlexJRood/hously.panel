// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables

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
        if (ref.read(navigationService).canBeamBack()) {
          KeyBoardShortcuts().handleBackspaceNavigation(event, ref);
        }
      },
      child: Scaffold(
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Container(
            decoration: BoxDecoration(
              gradient: CustomBackgroundGradients.customcrmright(context, ref),
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
                                width: 80,
                                color: Colors.transparent,
                                child: ListView.builder(
                                  itemCount: boardData.count,
                                  itemBuilder: (context, index) {
                                    final data = boardData.results?[index];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 18),
                                      child: InkWell(
                                        onTap: () {
                                          ref
                                              .read(boardIdProvider.notifier)
                                              .state = data!.id!.toInt();
                                          ref
                                              .read(
                                                  boardDetailsManagementProvider
                                                      .notifier)
                                              .fetchBoardDetails(
                                                  data.id.toString());
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 80,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              180))),
                                            ),
                                            Text(
                                              '${data?.name}',
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.textColorLight,
                                                  fontSize: 18),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
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
