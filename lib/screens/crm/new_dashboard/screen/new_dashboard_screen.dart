import 'package:flutter/material.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:showcaseview/showcaseview.dart';

import 'new_dashboard_screen_mobile.dart';
import 'new_dashboard_screen_pc.dart';

class NewDashboardScreen extends StatelessWidget {
  const NewDashboardScreen({super.key});

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
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 1080) {
            return ShowCaseWidget(
                autoPlay: true,
                onStart: (index, key) {
                  // log('onStart: $index, $key');
                },
                blurValue: 1,
                autoPlayDelay: const Duration(seconds: 10),
               builder: (context) =>  const NewDashboardScreenPc());
          } else {
            return ShowCaseWidget(
                autoPlay: true,
                onStart: (index, key) {
                  // log('onStart: $index, $key');
                },
                blurValue: 1,
                autoPlayDelay: const Duration(seconds: 10),
                builder: (context) =>const NewDashboardScreenMobile());
          }
        },
      ),
    );
  }
}
