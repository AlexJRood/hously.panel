import 'package:flutter/material.dart';
import 'about_us_mobile.dart';
import 'about_us_pc.dart';

class BasicAboutUsPage extends StatelessWidget {
  const BasicAboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 560) {
          return AboutPageMobile();
        } else {
          return AboutPage();
        }
      },
    );
  }
}

///void navigateToAboutUs(BuildContext context, WidgetRef ref) {
//   ref.read(navigationService).pushNamedScreen(Routes.aboutusview);
//   ref.read(selectedFeedViewProvider.notifier).state = Routes.aboutusview;
// }

///ElevatedButton(
//   onPressed: () => navigateToAboutUs(context, ref),
//   child: const Text('About Us'),
// )
