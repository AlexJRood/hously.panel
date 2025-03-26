import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/feed/grid/grid_mobile_page.dart';
import 'ads_view_pc.dart';

class BasicPage extends StatelessWidget {
  const BasicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 560) {

          return const GridMobilePage();
        } else {
          return const AdsViewPage();
        }
      },
    );
  }
}
