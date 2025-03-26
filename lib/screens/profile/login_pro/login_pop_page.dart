import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/screens/profile/login_mobile_pop.dart';
import 'package:hously_flutter/widgets/screens/profile/login_pc_pop.dart';

class LoginPopPage extends StatelessWidget {
  const LoginPopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          // Jeśli jest to aplikacja webowa lub aplikacja desktopowa z szerokością większą niż 1420
          return LoginPcPop();
        } else {
          // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
          return LoginMobilePop();
        }
      },
    );
  }
}
