import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/fliper_crm/refurbishment/refurbishment_pc_screen.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/sale_pc_screen.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/flipper_custom_tap_bar.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/negotiation_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/nigotiation_header_widget.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_network_monitoring.dart';

final tabIndexProvider = StateProvider<int>((ref) => 0);

class SelectionAndNegotiationPcScreen extends ConsumerWidget {
  const SelectionAndNegotiationPcScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    double screenWidth = MediaQuery.of(context).size.width;
    const double maxWidth = 1920;
    const double minWidth = 480;
    const double maxLogoSize = 30;
    const double minLogoSize = 22;
    double logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) +
        minLogoSize;
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);
    final tabIndex = ref.watch(tabIndexProvider);

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
                  spacing: 30,
                  children: [
                    const SizedBox(),
                    const NegotiationHeaderWidget(),
                    const FlipperCustomTapBar(),
                    Expanded(
                      child: IndexedStack(
                        index: tabIndex,
                        children: const [
                          Center(
                            child: NegotiationWidget(),
                          ),
                          Center(
                            child: RefurbishmentPcScreen(),
                          ),
                          Center(
                            child: SalePcScreen(),
                          ),
                        ],
                      ),
                    ),
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
