import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm.dart';
import 'package:hously_flutter/widgets/crm/finance/financial_plans/financal_plan_expenses.dart';
import 'package:hously_flutter/widgets/crm/finance/financial_plans/financal_plan_revenue.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_crm.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class AgentFinancialPlanspc extends ConsumerStatefulWidget {
  const AgentFinancialPlanspc({super.key});

  @override
  _AgentFinancalPlansState createState() => _AgentFinancalPlansState();
}

class _AgentFinancalPlansState extends ConsumerState<AgentFinancialPlanspc> {
  bool showExpenses = true; // Przechowuje stan dla przełączania widoków
  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenPadding = screenWidth / 10;
    final theme = ref.watch(themeColorsProvider);
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SidebarAgentCrm(
                  sideMenuKey: sideMenuKey,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const TopAppBarCRM(routeName: Routes.proPlans),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: screenPadding),
                          // Dwa przyciski typu ChoiceChip
                          Container(
                            height: 50,
                            padding: const EdgeInsets.all(5),
                            child: ChoiceChip(
                              checkmarkColor: Theme.of(context).iconTheme.color,
                              selectedColor: Theme.of(context).primaryColor,
                              // Color when selected
                              backgroundColor: theme.fillColor,
                              // selectedColor: Theme.of(context).colorScheme.primary,
                              label: Text(
                                'Show Expenses',
                                style: TextStyle(
                                  color: showExpenses
                                      ? Theme.of(context).iconTheme.color
                                      : theme.textFieldColor,
                                ),
                              ),
                              selected: showExpenses,
                              onSelected: (selected) {
                                setState(() {
                                  showExpenses = true; // Wybierz wydatki
                                });
                              },
                              // backgroundColor: AppColors.light,
                              // selectedColor: AppColors.superbee,
                              labelStyle: const TextStyle(
                                color: // showExpenses ? Colors.white :
                                    Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.all(5),
                            child: ChoiceChip(
                              checkmarkColor: Theme.of(context).iconTheme.color,
                              selectedColor: Theme.of(context).primaryColor,
                              // Color when selected
                              backgroundColor: theme.fillColor,
                              label: Text(
                                'Show Revenue',
                                style: TextStyle(
                                  color: !showExpenses
                                      ? Theme.of(context).iconTheme.color
                                      : theme.textFieldColor,
                                ),
                              ),
                              selected: !showExpenses,
                              onSelected: (selected) {
                                setState(() {
                                  showExpenses = false; // Wybierz przychody
                                });
                              },
                              // backgroundColor: AppColors.light,
                              // selectedColor: AppColors.superbee,
                              labelStyle: TextStyle(
                                  color: // showExpenses ? Colors.white :
                                      Theme.of(context).iconTheme.color),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: showExpenses
                              ? const FinancialPlansExpenses()
                              : const FinancialPlansRevenue(),
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
