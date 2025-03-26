import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hously_flutter/screens/crm/new_dashboard/widget/dashboard_last_mount_view_widget.dart';
import 'package:hously_flutter/screens/crm/new_dashboard/widget/db_calendar_widget.dart';
import 'package:hously_flutter/screens/crm/new_dashboard/widget/db_earning_chart_widget.dart';
import 'package:hously_flutter/screens/crm/new_dashboard/widget/db_favorite_ad_widget.dart';
import 'package:hously_flutter/screens/crm/new_dashboard/widget/db_recent_leads_and_chart_widget.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/crm/bottombar_crm.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class NewDashboardScreenMobile extends StatelessWidget {
  const NewDashboardScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Container(
          color: const Color.fromRGBO(35, 35, 35, 1),
          child: Column(
            children: [
              AppBarMobile(
                sideMenuKey: sideMenuKey,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Welcome back!',
                          style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Read Estate Property Management Dashboard.',
                          style: TextStyle(
                              color: const Color.fromRGBO(200, 200, 200, 1),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        const DashboardLastMountViewWidget(
                          isMobile: true,
                        ),
                        SizedBox(height: 62.h, child: const DbMoneyListView()),
                        const DbCalendarWidget(),
                        const DbRecentLeadsWidget(
                          isMobile: true,
                        ),
                        const DbEarningChartWidget(),
                        const DbFavoriteAdWidget(
                          isMobile: true,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 65, child: BottombarCrm()),
            ],
          ),
        ),
      ),
    );
  }
}
