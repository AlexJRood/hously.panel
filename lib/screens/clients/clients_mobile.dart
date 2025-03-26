import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/crm/bottombar_crm.dart';
import 'package:hously_flutter/widgets/crm/clients/clients_list.dart';
import 'package:hously_flutter/widgets/crm/clients/search_buttons_mobile.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class ClientsMobile extends ConsumerWidget {
  const ClientsMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();

    return PopupListener(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
              color: const Color.fromRGBO(19, 19, 19, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarMobile(
                    sideMenuKey: sideMenuKey,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Clients',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 70, child: StatusFilterWidgetMobile())
                      ],
                    ),
                  ),
                  const Flexible(
                      child: ClientList(
                    isMobile: true,
                  )),
                  const BottombarCrm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
