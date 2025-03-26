import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/finance2/widget/finance_2_pc_custom_list_view.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/finance2/widget/finance_2_custom_text_field.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/nigotiation_header_widget.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_network_monitoring.dart';

class Finance2PcScreen extends StatelessWidget {
  const Finance2PcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sideMenuKey = GlobalKey<SideMenuState>();

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
              const Expanded(
                child: Column(
                  spacing: 20,
                  children: [
                    SizedBox(),
                    NegotiationHeaderWidget(),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 160.0),
                        child: SingleChildScrollView(
                          child: Column(
                            spacing: 12,
                            children: [
                              Finance2CustomTextField(),
                              Finance2PcCustomListView()
                            ],
                          ),
                        ),
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
