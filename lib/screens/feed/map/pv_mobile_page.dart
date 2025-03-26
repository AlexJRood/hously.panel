import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/feed/map/filters_pv_mobile_page.dart';
import 'package:hously_flutter/widgets/screens/feed/ads_pv_mobile.dart';
import 'package:hously_flutter/widgets/screens/feed/map_pv_mobile.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../widgets/side_menu/slide_rotate_menu.dart';

class PvMobilePage extends ConsumerStatefulWidget {
  const PvMobilePage({super.key});

  @override
  ConsumerState<PvMobilePage> createState() => _PvMobilePageState();
}

class _PvMobilePageState extends ConsumerState<PvMobilePage>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PieCanvas(
      theme: const PieTheme(
        rightClickShowsMenu: true,
        leftClickShowsMenu: false,
        buttonTheme: PieButtonTheme(
          backgroundColor: AppColors.buttonGradient1,
          iconColor: Colors.white,
        ),
        buttonThemeHovered: PieButtonTheme(
          backgroundColor: Color.fromARGB(96, 58, 58, 58),
          iconColor: Colors.white,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
              decoration: BoxDecoration(
                  gradient: CustomBackgroundGradients.getMainMenuBackground(
                      context, ref)),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  PageView(
                    controller: _pageViewController,
                    onPageChanged: _handlePageViewChanged,
                    children: <Widget>[
                      const FiltersPvMobilePage(),
                      MapPvMobile(pageController: _pageViewController),
                      const AdsPvMobile()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    if (!_isOnDesktopAndWeb) {
      return;
    }
    _tabController.index = currentPageIndex;
    setState(() {});
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}
