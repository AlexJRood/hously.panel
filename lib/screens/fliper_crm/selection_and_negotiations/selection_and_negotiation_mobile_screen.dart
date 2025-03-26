import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/fliper_crm/refurbishment/refurbishment_mobile_screen.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/sale_mobile_screen.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/selection_and_negotiation_pc_screen.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/flipper_custom_tap_bar.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/negotiation_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/nigotiation_header_widget.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class SelectionAndNegotiationMobileScreen extends ConsumerWidget {
  const SelectionAndNegotiationMobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabIndexProvider);
    final sideMenuKey = GlobalKey<SideMenuState>();

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
                  spacing: 20,
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
                              'Negotiations',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Refurbishment',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Negotiations',
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
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: IndexedStack(
                          index: tabIndex,
                          children: const [
                            Center(
                              child: NegotiationWidget(
                                isMobile: true,
                              ),
                            ),
                            Center(
                              child: RefurbishmentMobileScreen(),
                            ),
                            Center(
                              child: SaleMobileScreen(),
                            ),
                          ],
                        ),
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
                      child: FlipperCustomTapBar(),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
