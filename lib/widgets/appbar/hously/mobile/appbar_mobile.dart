
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/screens/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/screens/notification/notification_screen.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/appbar/widgets/logo_hously.dart';
import 'package:hously_flutter/widgets/screens/ai/ai_page.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import '../../../side_menu/slide_rotate_menu.dart';
import 'dart:ui' as ui;

class AppBarMobile extends ConsumerWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  const AppBarMobile({super.key, required this.sideMenuKey});

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
      height:60,
      width: screenWidth,
      color: Colors.transparent,
      child: ClipRRect(
        child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
            decoration: BoxDecoration(
                color: currentthememode == ThemeMode.system ||
                        currentthememode == ThemeMode.light
                    ? Colors.black.withOpacity(0.1)
                    : Colors.white.withOpacity(0.1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: elevatedButtonStyleRounded10,
                  onPressed: () {
                    SideMenuManager.toggleMenu(ref: ref, menuKey: sideMenuKey);
                  },
                  child: Container(
                      height: 60,
                      width:45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.menu_rounded, color: color, size: 30.0),
                      ],
                    ),
                  ),
                ),
                if (isUserLoggedIn) ...[
                  ElevatedButton(
                    style: elevatedButtonStyleRounded10.copyWith(
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.transparent)),
                    onPressed: () => ref
                        .read(navigationService)
                        .pushNamedScreen(Routes.chatWrapper),
                    child: SizedBox(
                      height: 60,
                      width:45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: -30 * 3.141592653589793238 / 180,
                            child: IconButton(
                              icon: Icon(Icons.send_rounded,
                                  color: Theme.of(context).iconTheme.color,
                                  size: 25.0),
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (_, __, ___) => const ChatPage(),
                                    transitionsBuilder: (_, anim, __, child) {
                                      return FadeTransition(
                                          opacity: anim, child: child);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                   Container(                   
                      height: 60,
                      width: 60,
                     child: ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (_, __, ___) => const AiPage(),
                                    transitionsBuilder: (_, anim, __, child) {
                                      return FadeTransition(opacity: anim, child: child);
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'AI',
                                style: AppTextStyles.interLight.copyWith(
                                    fontSize: 18,
                                    color:  AppColors.light,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                   ),
                  Container(
                      height: 60,
                      width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (_, __, ___) => const NotificationScreen(),
                            transitionsBuilder: (_, anim, __, child) {
                              return FadeTransition(opacity: anim, child: child);
                            },
                          ),
                        );
                      },
                      style: elevatedButtonStyleRounded10,
                      child: Icon(Icons.notifications_active_outlined,
                          size: 25, color: color),
                    ),
                  ),
                ],
                const Spacer(),
                const LogoHouslyWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
