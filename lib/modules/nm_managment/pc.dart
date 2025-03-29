import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/bars/bar_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class NetworkMonitoringManagment extends ConsumerWidget {
  NetworkMonitoringManagment({super.key});

  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BarManager(
      sideMenuKey: sideMenuKey,
      children: [
        Expanded(
          child: Column(
            children: [
              

            ],
          )
        ),
      ],
    );
  }
}
