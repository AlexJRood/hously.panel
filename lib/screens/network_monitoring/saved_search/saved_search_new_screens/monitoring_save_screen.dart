import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/network_monitoring/saved_search/saved_search_new_screens/monitoring_save_mobile.dart';
import 'package:hously_flutter/screens/network_monitoring/saved_search/saved_search_new_screens/monitoring_save_pc.dart';

class MonitoringSaveScreen extends StatelessWidget {
  const MonitoringSaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1250) {
          return const MonitoringSavePc();
        } else {
          return  const MonitoringSaveMobile();
        }
      },
    );
  }
}
