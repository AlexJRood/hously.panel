import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/widget/revenues_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/nigotiation_header_widget.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

import 'widget/finance_custom_tap_bar.dart';

class FinanceMobileScreen extends ConsumerWidget {
  const FinanceMobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    final tabIndex = ref.watch(financeTabIndexProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Container(
            color: Colors.black,
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.menu,
                            size: 38,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                          onPressed: () {
                            SideMenuManager.toggleMenu(
                                ref: ref, menuKey: sideMenuKey);
                          },
                        ),
                        IndexedStack(
                          index: tabIndex,
                          children: const [
                            Text(
                              'Revenues',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Expenses',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.more_horiz,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          size: 38,
                        ),
                      ],
                    ),
                    const NegotiationHeaderWidget(
                      isMobile: true,
                    ),
                    Expanded(
                      child: IndexedStack(
                        index: tabIndex,
                        children: const [
                          Center(
                            child: RevenuesWidget(
                              isMobile: true,
                            ),
                          ),
                          Center(
                            child: RevenuesWidget(
                              isMobile: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const BottomBarMobile()
                  ],
                ),
                const Positioned(
                    bottom: 60,
                    right: 0,
                    left: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: FinanceCustomTapBar(),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
