import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/screens/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import '../../../side_menu/slide_rotate_menu.dart';

class ClientviewAppbar extends ConsumerWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  const ClientviewAppbar({super.key, required this.sideMenuKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUserLoggedIn = ApiServices.isUserLoggedIn();

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
    final color = Theme.of(context).iconTheme.color;

    final currentthememode = ref.watch(themeProvider);

    return Container(
      decoration: BoxDecoration(
          color: currentthememode == ThemeMode.system ||
                  currentthememode == ThemeMode.light
              ? Colors.black.withOpacity(0.1)
              : Colors.white.withOpacity(0.1)),
      padding: const EdgeInsets.only(left: 0, right: 5, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            style: elevatedButtonStyleRounded10,
            onPressed: () {
              SideMenuManager.toggleMenu(ref: ref, menuKey: sideMenuKey);
            },
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SvgPicture.asset(AppIcons.menu, color: color, height: 30.0,width: 30,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
