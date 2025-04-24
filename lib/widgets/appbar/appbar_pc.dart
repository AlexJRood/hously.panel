import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/modules/leads/components/view_pop_changer_page.dart';
import 'package:hously_flutter/modules/leads/utils/lead_filters.dart';
import 'package:hously_flutter/modules/leads/utils/lead_sort.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
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
    final bool isMobile = screenWidth < 800;
    final double boxSize= isMobile ? 45 : 60;
    final double boxHeight= isMobile ? 60 : 60;
    final double iconSize =  isMobile ? 25 : 30;

    return Container(
      height: 60,
      width: screenWidth - boxSize,
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
                      height: boxHeight,
                      width: boxSize,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.add, height: iconSize,width: iconSize, color: iconcolor),
                        ],
                      ),
                    ),
                  ),
                ),



                ElevatedButton(
                  style: elevatedButtonStyleRounded10,
                  onPressed: () {
                     
                  },
                  child: Hero(
                    tag:
                        'CoToMaRobic-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag
                    child: Container(
                      key: coToMaRobicTopAppBar,
                      height: boxHeight,
                      width: boxSize,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.pie, height: iconSize,width: iconSize, color: iconcolor),
                        ],
                      ),
                    ),
                  ),
                ),

                
                    ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: () {
                        
    showDialog(context: context, builder: (_) => const LeadSortingDialog());
                        
                      },
                      child: Hero(
                        tag:
                            'SortBarButton-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag
                        child: Container(
                          key: sortButtonTopAppBar,
                          height: boxHeight,
                          width: boxSize,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.sort, height: iconSize,width: iconSize, color: iconcolor),
                            ],
                          ),
                        ),
                      ),
                    ),

                
                    ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const LeadFilterDialog(),
                          );
                      },
                      child: Hero(
                        tag:'searchbar-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag
                        child: Container(
                          key: searchbarKey,
                          height: boxHeight,
                          width: boxSize,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.search, height: iconSize,width: iconSize, color: iconcolor),
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
