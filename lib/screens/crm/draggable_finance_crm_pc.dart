import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
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
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
              decoration: BoxDecoration(
                gradient:
                    CustomBackgroundGradients.customcrmright(context, ref),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TopAppBarCRM(routeName: Routes.proFinance),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Container(
                                    width: 500,
                                    // height: 42,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      gradient: CustomBackgroundGradients
                                          .crmadgradient(context, ref),
                                      color: AppColors.light,
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    child: SegmentedButton<String>(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return Theme.of(context)
                                                  .iconTheme
                                                  .color!;
                                            }
                                            return Theme.of(context)
                                                .iconTheme
                                                .color!;
                                          },
                                        ),
                                        padding:
                                            WidgetStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 0),
                                        ),
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        backgroundColor: WidgetStateProperty
                                            .resolveWith<Color>(
                                          (states) {
                                            if (states.contains(
                                                WidgetState.selected)) {
                                              return (currentthememode ==
                                                          ThemeMode.system ||
                                                      currentthememode ==
                                                          ThemeMode.light)
                                                  ? AppColors.dark50
                                                  : AppColors.light50;
                                            }
                                            return Colors.transparent;
                                          },
                                        ),
                                        side:
                                            WidgetStateProperty.all<BorderSide>(
                                          BorderSide.none,
                                        ),
                                      ),
                                      multiSelectionEnabled: false,
                                      selected: {_selectedSegment},
                                      onSelectionChanged: updateSelected,
                                      segments: <ButtonSegment<String>>[
                                        ButtonSegment(
                                          label: Text(
                                            'Przychody'.tr,
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight:
                                                  _selectedSegment == '/revenue'
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          value: '/revenue',
                                          icon: Icon(
                                            Icons.check,
                                            color:
                                                _selectedSegment == '/revenue'
                                                    ? Colors.white
                                                    : Colors.transparent,
                                          ),
                                        ),
                                        ButtonSegment(
                                          label: Text(
                                            'Koszty'.tr,
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: _selectedSegment ==
                                                      '/expenses'
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          value: '/expenses',
                                          icon: Icon(
                                            Icons.check,
                                            color:
                                                _selectedSegment == '/expenses'
                                                    ? Colors.white
                                                    : Colors.transparent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                // Wyświetlanie odpowiedniego widżetu w zależności od wybranego segmentu
                                child: Center(
                                  child: _selectedSegment == '/revenue'
                                      ? CrmRevenueBoard(ref: ref)
                                      : CrmExpensesBoard(ref: ref),
                                ),
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
