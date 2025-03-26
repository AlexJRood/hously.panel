import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_logo.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/Draft/edit_offer_mobile_page.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/Draft/edit_sell_offer_pc.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import '../../../../../../side_menu/slide_rotate_menu.dart';

class CrmEditSellOfferPage extends ConsumerWidget {
  final int? offerId;

  const CrmEditSellOfferPage({super.key, required this.offerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.85),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 1200) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40, right: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const TopAppBarLogoRegisterPage(),
                            CrmEditSellOfferPc(offerId: offerId),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return CrmEditOfferMobilePage(offerId: offerId);
              }
            }),
          ],
        ),
      ),
    );
  }
}
