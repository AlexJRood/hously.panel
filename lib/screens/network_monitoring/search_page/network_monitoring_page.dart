import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/network_monitoring/saved_search/saved_search_new_screens/monitoring_save_mobile.dart';
import 'package:hously_flutter/screens/network_monitoring/search_page/network_monitoring_pc_page.dart';


class NetworkMonitoringPage extends ConsumerWidget {
  const NetworkMonitoringPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          // Jeśli jest to aplikacja webowa lub aplikacja desktopowa z szerokością większą niż 1420
          return const NetworkMonitoringPcPage();
        } else {
          // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
          return const MonitoringSaveMobile();
        }
      },
    );
  }
}
