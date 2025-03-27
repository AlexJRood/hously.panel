import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/login/login_mobile_page.dart';
import 'package:hously_flutter/modules/login/login_pc_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return  LoginPcPage();
        } else {
          return const LoginMobilePage();
        }
      },
    );
  }
}
