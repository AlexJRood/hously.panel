import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/landing_page/landing_page_mobile.dart';
import 'package:hously_flutter/screens/landing_page/landing_page_pc.dart';
import 'package:showcaseview/showcaseview.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return ShowCaseWidget(
              autoPlay: true,
              onStart: (index, key) {
                // log('onStart: $index, $key');
              },
              blurValue: 1,
              autoPlayDelay: const Duration(seconds: 10),
              builder: (context) => const LandingPagePc()); // Widok dla mniejszych ekranów
        } else {
          return const LandingPageMobile(); // Widok dla większych ekranów
        }
      },
    );
  }
}
