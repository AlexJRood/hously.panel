import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/modules/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/modules/notification/notification_screen.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/widgets/appbar/components/logo_hously.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import '../side_menu/slide_rotate_menu.dart';
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
    double iconsize = screenWidth > 400 ? 30 : 25;
    double logosecondsize = screenWidth > 400 ? logoSize : 15;
    double textsize = screenWidth > 400 ? 28 : 23;
    return Container(
        height: 60,
        width: screenWidth,
        color: Colors.transparent,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                color: (currentthememode == ThemeMode.system ||
                        currentthememode == ThemeMode.light)
                    ? Colors.black.withOpacity(0.1)
                    : Colors.white.withOpacity(0.1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: elevatedButtonStyleRounded10,
                    onPressed: () {
                      SideMenuManager.toggleMenu(
                          ref: ref, menuKey: sideMenuKey);
                    },
                    child: SizedBox(
                      height: 60,
                      width: 45,
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.menu,
                          color: color,
                          height: 30.0,
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: elevatedButtonStyleRounded10,
                    onPressed: () {
                      
                    },
                    child: Hero(
                      tag: 'MobilePopAppBar_${UniqueKey()}',
                      child: SizedBox(
                        height: 60,
                        width: 45,
                        child: Center(
                          child: Icon(Icons.view_comfortable_rounded,
                              size: iconsize, color: color),
                        ),
                      ),
                    ),
                  ),
                  if (isUserLoggedIn) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: ElevatedButton(
                          style: elevatedButtonStyleRounded10.copyWith(
                            backgroundColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                          ),
                          onPressed: () => ref
                              .read(navigationService)
                              .pushNamedScreen(Routes.chatWrapper),
                          child: SizedBox(
                            height: 60,
                            width: 45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Transform.rotate(
                                  angle: -30 * 3.141592653589793238 / 180,
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                      AppIcons.send,
                                      color: Theme.of(context).iconTheme.color,
                                      height: 25.0,
                                      width: 25,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder: (_, __, ___) =>
                                              const ChatPage(),
                                          transitionsBuilder:
                                              (_, anim, __, child) {
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
                          )),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (_, __, ___) =>
                                const NotificationScreen(),
                            transitionsBuilder: (_, anim, __, child) {
                              return FadeTransition(
                                  opacity: anim, child: child);
                            },
                          ),
                        );
                      },
                      style: elevatedButtonStyleRounded10,
                      child: Icon(Icons.notifications_active_outlined,
                          size: textsize, color: color),
                    ),
                  ],
                  const Spacer(),
                  TextButton(
                    style: elevatedButtonStyleRounded10,
                    onPressed: () {
                      BetterFeedback.of(context).show((feedback) async {
                        // upload to server, share whatever
                      });
                    },
                    child: SizedBox(
                      height: 60,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'HOUSLY',
                            style: AppTextStyles.houslyAiLogo.copyWith(
                                fontSize: logosecondsize, color: color),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
