import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/landlord/landlord_mobile.dart';
import 'package:hously_flutter/screens/landlord/landlord_pc.dart';

class LandlordAppPage extends StatelessWidget {
  const LandlordAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          // Jeśli jest to aplikacja webowa lub aplikacja desktopowa z szerokością większą niż 1420
          return LandlordAppPc();
        } else {
          // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
          return LandlordAppMobile();
        }
      },
    );
  }
}
