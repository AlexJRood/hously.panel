import 'package:flutter/material.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/monitoring_home_mobile.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/monitoring_home_pc.dart';

class MonitoringHomeScreen extends StatelessWidget {
  const MonitoringHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return const MonitoringHomePc();
        } else {
          return  const MonitoringHomeMobile();
        }
      },
    );
  }
}
