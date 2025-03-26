import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/network_monitoring/network_home_page/network_home_new/screens/widgets/monitoring_custom_text_field.dart';
import 'package:hously_flutter/screens/network_monitoring/saved_search/saved_search_new_screens/widgets/monitoring_save_pc_filters.dart';
import 'package:hously_flutter/widgets/filter_monitoring_widget.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_network_monitoring.dart';

class MonitoringSavePc extends StatelessWidget {
  const MonitoringSavePc({super.key});

  @override
  Widget build(BuildContext context) {
    final sideMenuKey = GlobalKey<SideMenuState>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              SidebarNetworkMonitoring(
                sideMenuKey: sideMenuKey,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 20,
                      children: [
                        Row(
                          spacing: 24,
                          children: [
                            SizedBox(
                              width: 700,
                              child: MonitoringCustomTextField(
                                hintText: 'Affordable Options',
                              ),
                            ),
                            Text(
                              'Advanced search',
                              style: TextStyle(
                                  color: Color.fromRGBO(166, 215, 227, 1),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 30,
                          children: [
                            SizedBox(
                                width: 340,
                                child: FilterMonitoringWidget()),
                            MonitoringSavePcFilters(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0,bottom: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 12,
                  children: [
                    Container(
                      height: 66,
                      width: 100,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(33, 32, 32, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box_outlined,
                              size: 20,
                              color: Color.fromRGBO(233, 233, 233, 1),
                            ),
                            Text('Publish',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(233, 233, 233, 1))),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 66,
                      width: 100,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(33, 32, 32, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box_outlined,
                              size: 20,
                              color: Color.fromRGBO(233, 233, 233, 1),
                            ),
                            Text('Edit',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(233, 233, 233, 1))),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 66,
                      width: 100,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(33, 32, 32, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box_outlined,
                              size: 20,
                              color: Color.fromRGBO(233, 233, 233, 1),
                            ),
                            Text('Edit',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(233, 233, 233, 1))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


