import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/widget/finance_custom_tap_bar.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/widget/revenues_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/nigotiation_header_widget.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_network_monitoring.dart';

class FinancePcScreen extends ConsumerWidget {
  const FinancePcScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    final tabIndex = ref.watch(financeTabIndexProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Container(
          color: Colors.black,
          child: Row(
            children: [
              SidebarNetworkMonitoring(
                sideMenuKey: sideMenuKey,
              ),
              Expanded(
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(),
                    const NegotiationHeaderWidget(),
                    const FinanceCustomTapBar(),
                    Expanded(
                      child: IndexedStack(
                        index: tabIndex,
                        children: const [
                          Center(
                            child: RevenuesWidget(),
                          ),
                          Center(
                            child: RevenuesWidget(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
