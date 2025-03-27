import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/modules/ads_managment/pop_pages/sort_pop_page.dart';
import 'package:hously_flutter/modules/ads_managment/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/modules/ads_managment/pop_pages/view_settings_page.dart';
import 'package:hously_flutter/widgets/appbar/components/logo_hously.dart';
import 'dart:ui' as ui;

class TopAppBar extends ConsumerWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey coToMaRobicTopAppBar = GlobalKey();
    final GlobalKey leadAdd = GlobalKey();
    final GlobalKey viewChangerButtonTopAppBar = GlobalKey();
    final GlobalKey sortButtonTopAppBar = GlobalKey();
    final GlobalKey searchbarKey = GlobalKey();
    double screenWidth = MediaQuery.of(context).size.width;
    final iconcolor = Theme.of(context).iconTheme.color;
    const double maxWidth = 1920;
    const double minWidth = 480;
    const double maxLogoSize = 30;
    const double minLogoSize = 16;
    double logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) +
        minLogoSize;
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);

    return Container(
      height: 60,
      width: screenWidth - 60,
      color: Colors.transparent,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            // color: theme.adPopBackground.withOpacity(0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                ElevatedButton(
                  style: elevatedButtonStyleRounded10,
                  onPressed: () {

                    ref.read(navigationService).pushNamedScreen('${Routes.addLead}');

                  },
                  child: Hero(
                    tag: '${UniqueKey().toString()}', // need to be change both sides of hero need the same tag
                    child: Container(
                      key: leadAdd,
                      height: 60,
                      width: 60,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.add, height: 30.0,width: 30, color: iconcolor),
                        ],
                      ),
                    ),
                  ),
                ),


                    ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (_, __, ___) =>
                                const ViewPopChangerPage(),
                            transitionsBuilder: (_, anim, __, child) {
                              return FadeTransition(
                                  opacity: anim, child: child);
                            },
                          ),
                        );
                      },
                      child: Hero(
                        tag:
                            'ViewChangerBarButton-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag
                        child: Container(
                          key: viewChangerButtonTopAppBar,
                          height: 60,
                          width: 60,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.view_comfortable_rounded,
                                  size: 30.0, color: iconcolor),
                            ],
                          ),
                        ),
                      ),
                    ),


                ElevatedButton(
                  style: elevatedButtonStyleRounded10,
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const ViewSettingsPage(),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    );
                  },
                  child: Hero(
                    tag:
                        'CoToMaRobic-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag
                    child: Container(
                      key: coToMaRobicTopAppBar,
                      height: 60,
                      width: 60,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.pie, height: 30.0,width: 30, color: iconcolor),
                        ],
                      ),
                    ),
                  ),
                ),

                
                    ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (_, __, ___) => const SortPopPage(),
                            transitionsBuilder: (_, anim, __, child) {
                              return FadeTransition(
                                  opacity: anim, child: child);
                            },
                          ),
                        );
                      },
                      child: Hero(
                        tag:
                            'SortBarButton-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag
                        child: Container(
                          key: sortButtonTopAppBar,
                          height: 60,
                          width: 60,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.sort, height: 30.0,width: 30, color: iconcolor),
                            ],
                          ),
                        ),
                      ),
                    ),

                
                    ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   PageRouteBuilder(
                        //     opaque: false,
                        //     pageBuilder: (_, __, ___) => FiltersPage(),
                        //     transitionsBuilder: (_, anim, __, child) {
                        //       return FadeTransition(
                        //           opacity: anim, child: child);
                        //     },
                        //   ),
                        // );
                      },
                      child: Hero(
                        tag:'searchbar-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag
                        child: Container(
                          key: searchbarKey,
                          height: 60,
                          width: 60,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.search, height: 30.0,width: 30, color: iconcolor),
                            ],
                          ),
                        ),
                      ),
                    ),

                Spacer(),

              
                const LogoHouslyWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
