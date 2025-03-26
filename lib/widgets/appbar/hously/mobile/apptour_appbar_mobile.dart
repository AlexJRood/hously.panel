import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/screens/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/apptour_sidebar_crm.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../side_menu/slide_rotate_menu.dart';



class ApptourAppbarMobile extends ConsumerWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  const ApptourAppbarMobile({super.key,required this.sideMenuKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    final four = ref.watch(home4);
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
    // final sideMenuKey = GlobalKey<SideMenuState>();

    return Container(
      decoration: BoxDecoration(
          color: currentthememode == ThemeMode.system ||
                  currentthememode == ThemeMode.light
              ? Colors.black.withOpacity(0.1)
              : Colors.white.withOpacity(0.1)),
      padding: const EdgeInsets.only(left: 0, right: 5, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: elevatedButtonStyleRounded10,
            onPressed: () {
              SideMenuManager.toggleMenu(ref: ref,menuKey: sideMenuKey);
            },
            child: Column(
              children: [
                CustomShowcaseWidgetmobile(
                    cont: context,
                    isCrm: false,
                    showkey: four,
                    ref: ref,
                    onSkip: () => ShowCaseWidget.of(context).next(),
                    title: 'Sidebar',
                    description:
                        'sidebar for quick access to login/logout, profile settings, streamlining navigation and account management',
                    child: SvgPicture.asset(AppIcons.menu, color: color,
                        height: 30.0,
                        width: 30.0,
                    )),
              ],
            ),
          ),
          ElevatedButton(
            style: elevatedButtonStyleRounded10,
            onPressed: () {
              ref.read(navigationService).pushNamedScreen(Routes.mobilePop);
            },
            child: Hero(
              tag: 'MobilePopAppBar-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag 
              child: Container(
                color: Colors.transparent,
                child: Icon(Icons.view_comfortable_rounded,
                    size: 25.0, color: color),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.rotate(
                    angle: -30 * 3.141592653589793238 / 180,
                    child: IconButton(icon:SvgPicture.asset(AppIcons.send,
                        color: Theme.of(context).iconTheme.color,
                        height: 25.0,
                        width: 25.0,
                    ),
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
                  const SizedBox(height: 5),
                ],
              ),
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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
              child: Text(
                'HOUSLY.AI',
                style: AppTextStyles.houslyAiLogo
                    .copyWith(fontSize: logoSize, color: color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
