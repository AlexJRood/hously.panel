import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/profile/add_offer/widget/add_offer_mobile_stack_widget.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

// ignore: must_be_immutable
class AddOfferMobilePage extends StatelessWidget {
  const AddOfferMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sideMenuKey = GlobalKey<SideMenuState>();


    return PopupListener(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: AddOfferMobileStackWidget(
              sideMenuKey: sideMenuKey,
            ),
          ),
        ),
      ),
    );
  }
}
