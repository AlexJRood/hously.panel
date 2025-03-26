import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/widget/finance_custom_tap_bar.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm.dart';
import 'package:hously_flutter/widgets/crm/finance/page/expenses_board.dart';
import 'package:hously_flutter/widgets/crm/finance/page/revenue_board.dart';
import 'package:hously_flutter/widgets/crm/view/view/buttons.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_crm.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class DraggableFinanceCrmPc extends ConsumerStatefulWidget {
  const DraggableFinanceCrmPc({super.key});

  @override
  ConsumerState<DraggableFinanceCrmPc> createState() =>
      _DraggableFinanceCrmPcState();
}

class _DraggableFinanceCrmPcState extends ConsumerState<DraggableFinanceCrmPc> {
  String _selectedSegment = '/revenue';

  void updateSelected(Set<String> selected) {
    setState(() {
      _selectedSegment = selected.first;
    });
  }

  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    final currentthememode = ref.watch(themeProvider);
    final tabIndex = ref.watch(financeTabIndexProvider);

    return KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        onKeyEvent: (KeyEvent event) {
          // Check if the pressed key matches the stored pop key
          KeyBoardShortcuts().handleKeyNavigation(event, ref, context);
          if (event.logicalKey == ref.watch(adclientprovider) &&
              event is KeyDownEvent) {
            ref
                .read(navigationService)
                .pushNamedScreen(Routes.proFinanceRevenueAdd);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      SidebarAgentCrm(
                        sideMenuKey: sideMenuKey,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const TopAppBarCRM(routeName: Routes.proFinance),
                            const FinanceCustomTapBar(),
                            Expanded(
                              child: IndexedStack(
                                index: tabIndex,
                                children:  [
                                  Center(
                                    child: CrmRevenueBoard(ref: ref),
                                  ),
                                  Center(
                                    child: CrmExpensesBoard(ref: ref),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: FinanceCrmSideButtons(ref: ref),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
