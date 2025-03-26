import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/profile/profile_page/profile_ads_mobile_page.dart';
import 'package:hously_flutter/screens/profile/profile_page/profile_ads_pc_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          // Jeśli jest to aplikacja webowa lub aplikacja desktopowa z szerokością większą niż 1420
          return const ProfileAdsPcPage();
        } else {
          // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
          return const ProfileAdsMobilePage();
        }
      },
    );
  }
}
