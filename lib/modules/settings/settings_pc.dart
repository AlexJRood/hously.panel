import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/modules/settings/components/gradient_dropdown.dart';
import 'package:hously_flutter/modules/settings/components/pc/components/settings_provider.dart';

import 'package:hously_flutter/modules/settings/components/pc/components/settings_tile_providers.dart';
import 'package:hously_flutter/modules/settings/components/pc/components/user_tile.dart';

import 'package:hously_flutter/modules/settings/components/pc/components/settings_tiles.dart';
import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/modules/settings/provider/logout_provider.dart';

import 'package:hously_flutter/routing/navigation_service.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/widgets/appbar/appbar_pc.dart';

import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/bars/sidebar.dart';

import '../../../../widgets/side_menu/slide_rotate_menu.dart';

class SettingsPc extends ConsumerStatefulWidget {
  final Widget page;
  final int currentindex;
  const SettingsPc({super.key, required this.page, required this.currentindex});

  @override
  ConsumerState<SettingsPc> createState() => _SettingsPcState();
}

class _SettingsPcState extends ConsumerState<SettingsPc> {
  GlobalKey iconButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    bool isclick = ref.watch(isClickprovider);
    final theme = ref.watch(themeColorsProvider);
    final isToggled = ref.watch(toggleProvider);
    final navService = ref.read(navigationService);

    return Scaffold(
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Sidebar(
                  sideMenuKey: sideMenuKey,
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient:
                            CustomBackgroundGradients.getMainMenuBackground(
                                context, ref)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isToggled == true) ...[
                            const SizedBox(
                              height: 1,
                            ),
                          ],
                          const TopAppBar(),
                          const SizedBox(height: 20.0),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            child: UserTile(
                                              widget: IconButton(
                                                key: iconButtonKey,
                                                icon: Icon(
                                                    Icons.more_vert_outlined,
                                                    color:
                                                        theme.mobileTextcolor),
                                                onPressed: () {
                                                  showCustomMenu(context,
                                                      iconButtonKey, ref);
                                                  setState(() {
                                                    ref
                                                        .watch(isClickprovider
                                                            .notifier)
                                                        .toggle();
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Column(
                                            children: [
                                              ListTileWidget(
                                                title: 'Profile'.tr,
                                                index: 0,
                                                onTap: () {
                                                  navService
                                                      .pushNamedReplacementScreen(
                                                          Routes
                                                              .settingsprofile);
                                                  ref
                                                      .read(
                                                          isDropdownOpenProvider
                                                              .notifier)
                                                      .closeDropdown();
                                                },
                                                selectedIndex:
                                                    widget.currentindex,
                                              ),
                                              ListTileWidget(
                                                title: 'Powiadomienia'.tr,
                                                index: 1,
                                                onTap: () {
                                                  navService
                                                      .pushNamedReplacementScreen(
                                                          Routes
                                                              .settingsnotification);
                                                },
                                                selectedIndex:
                                                    widget.currentindex,
                                              ),
                                              ListTileWidget(
                                                title:
                                                    'Bezpieczeństwo i Prywatność'
                                                        .tr,
                                                index: 2,
                                                onTap: () {
                                                  navService
                                                      .pushNamedReplacementScreen(
                                                          Routes
                                                              .settingssecurity);
                                                },
                                                selectedIndex:
                                                    widget.currentindex,
                                              ),
                                              ListTileWidget(
                                                title: 'Payments'.tr,
                                                index: 3,
                                                onTap: () {
                                                  navService
                                                      .pushNamedReplacementScreen(
                                                          Routes
                                                              .settingspayments);
                                                },
                                                selectedIndex:
                                                    widget.currentindex,
                                              ),
                                              ListTileWidget(
                                                title: 'Język'.tr,
                                                index: 4,
                                                onTap: () {
                                                  navService
                                                      .pushNamedReplacementScreen(
                                                          Routes
                                                              .settingslanguage);
                                                },
                                                selectedIndex:
                                                    widget.currentindex,
                                              ),
                                              ListTileWidget(
                                                title: 'Motyw'.tr,
                                                index: 5,
                                                onTap: () {
                                                  navService
                                                      .pushNamedReplacementScreen(
                                                          Routes.settingstheme);
                                                },
                                                selectedIndex:
                                                    widget.currentindex,
                                              ),
                                              ListTileWidget(
                                                title: 'Czat'.tr,
                                                index: 6,
                                                onTap: () {
                                                  navService
                                                      .pushNamedReplacementScreen(
                                                          Routes.settingschat);
                                                },
                                                selectedIndex:
                                                    widget.currentindex,
                                              ),
                                              ListTileWidget(
                                                title: 'Wsparcie'.tr,
                                                index: 7,
                                                onTap: () {
                                                  navService
                                                      .pushNamedReplacementScreen(
                                                          Routes
                                                              .settingsupport);
                                                },
                                                selectedIndex:
                                                    widget.currentindex,
                                              ),
                                              ListTileWidget(
                                                title: 'Wyloguj się'.tr,
                                                index: 8,
                                                onTap: () {
                                                  ref
                                                      .read(toggleProviderlogout
                                                          .notifier)
                                                      .toggle();
                                                  navService
                                                      .pushNamedReplacementScreen(
                                                          Routes.settinglogout);
                                                },
                                                selectedIndex:
                                                    widget.currentindex,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 4, child: widget.page),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            isclick == true
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                : const SizedBox(),
            if (widget.currentindex == 8) ...[
              // Blur Effect
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),

              // Centered Logout Container
              Center(
                child: Container(
                  width: 400.0,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: theme.popupcontainercolor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title & Close Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Log Out',
                            style: TextStyle(
                              color: theme.popupcontainertextcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(AppIcons.close,
                                color: theme.popupcontainertextcolor),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),

                      // Confirmation Text
                      Text(
                        'Are you sure you want to logout?',
                        style: TextStyle(
                          color: theme.popupcontainertextcolor,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24.0),

                      // Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomElevatedButton(
                            text: 'Cancel',
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const SizedBox(width: 10),
                          Settingsbutton(
                            isPc: true,
                            buttonheight: 30,
                            onTap: () {
                              // Add your logout logic here
                              Navigator.of(context).pop();
                            },
                            text: 'Log out',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
