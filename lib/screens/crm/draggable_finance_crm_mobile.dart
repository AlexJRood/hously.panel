import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';

import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';

import 'package:hously_flutter/widgets/crm/apptour_crm_bottombar.dart';
import 'package:hously_flutter/widgets/crm/bottombar_crm.dart';
import 'package:hously_flutter/widgets/crm/finance/page/expenses_board.dart';
import 'package:hously_flutter/widgets/crm/finance/page/revenue_board.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';

import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class DraggableFinanceCrmMobile extends ConsumerStatefulWidget {
  DraggableFinanceCrmMobile({super.key});

  @override
  _DraggableFinanceCrmMobileState createState() =>
      _DraggableFinanceCrmMobileState();
}

// Listy widgetów dla PageView

class _DraggableFinanceCrmMobileState
    extends ConsumerState<DraggableFinanceCrmMobile> {
  String _selectedSegment = '/revenue'; // Przechowujemy wybrany segment

  void updateSelected(Set<String> selected) {
    setState(() {
      _selectedSegment = selected.first; // Set ma tylko jeden wybrany element
    });
  }
  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    final currentthememode = ref.watch(themeProvider);
    return PopupListener(
        child: SafeArea(
          child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
              decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.customcrmright(context, ref),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                       AppBarMobile(sideMenuKey: sideMenuKey,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Container(
                                    width: 500,
                                    height: 50,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      gradient:
                                          CustomBackgroundGradients.crmadgradient(
                                              context, ref),
                                      color: AppColors.light,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: SegmentedButton<String>(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (states) {
                                            if (states
                                                .contains(MaterialState.selected)) {
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
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        backgroundColor:
                                            WidgetStateProperty.resolveWith<Color>(
                                          (states) {
                                            if (states
                                                .contains(WidgetState.selected)) {
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
                                        side: WidgetStateProperty.all<BorderSide>(
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
                                            color: _selectedSegment == '/revenue'
                                                ? Colors.white
                                                : Colors.transparent,
                                          ),
                                        ),
                                        ButtonSegment(
                                          label: Text(
                                            'Koszty'.tr,
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight:
                                                  _selectedSegment == '/expenses'
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          value: '/expenses',
                                          icon: Icon(
                                            Icons.check,
                                            color: _selectedSegment == '/expenses'
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
                            const BottombarCrm(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
                ),
        ),
    );
  }

  Future<void> _checkForToken() async {
    if (ApiServices.token != null) {
      // Usunięcie stron logowania i rejestracji z historii nawigacji
      ref
          .read(navigationHistoryProvider.notifier)
          .removeSpecificPages(['/login', '/register']);

      // Przekierowanie na ostatnią stronę w historii nawigacji
      final lastPage = ref.read(navigationHistoryProvider.notifier).lastPage;
      ref.read(navigationService).pushNamedReplacementScreen(lastPage);
    }
  }
}
