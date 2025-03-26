import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/feed/map/map_view_mobile_page.dart';
import 'package:hously_flutter/screens/feed/map/map_view_pc_page.dart';

class MapViewPage extends StatelessWidget {
  const MapViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 1080) {
          return const MapViewMobilePage(); // Widok dla mniejszych ekranów
        } else {
          return const MapViewPcPage(); // Widok dla większych ekranów
        }
      },
    );
  }
}
