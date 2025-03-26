import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/finance2/widget/finance_2_custom_text_field.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/finance2/widget/finance_2_mobile_custom_list_view.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/nigotiation_header_widget.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class Finance2MobileScreen extends ConsumerWidget {
  const Finance2MobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Container(
            color: Colors.black,
            child: Column(
              spacing: 10,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(AppIcons.menu,
                            height: 38,width: 38, color: Colors.white),
                        onPressed: () {
                          SideMenuManager.toggleMenu(
                              ref: ref, menuKey: sideMenuKey);
                        },
                      ),
                      const Text(
                        'Finance',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SvgPicture.asset(AppIcons.moreVertical,
                          color: Colors.white, height: 38,width: 38,),
                    ],
                  ),
                ),
                const NegotiationHeaderWidget(isMobile: true),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Finance2CustomTextField(),
                        Expanded(child: Finance2MobileCustomListView()),
                      ],
                    ),
                  ),
                ),
                const BottomBarMobile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
