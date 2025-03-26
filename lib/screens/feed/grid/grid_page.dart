import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/feed/basic_view/ads_view_pc.dart';
import 'package:hously_flutter/screens/feed/grid/grid_mobile_page.dart';
import 'package:hously_flutter/screens/feed/grid/grid_pc_page.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 1080) {
          return const GridMobilePage(); // Widok dla mniejszych ekranów
        } else {
          return const GridPcPage(); // Widok dla większych ekranów
          //return const GridPcPage(); // Widok dla większych ekranów
        }
      },
    );
  }
}
