import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/profile/login/register/register_mobile_page.dart';
import 'package:hously_flutter/screens/profile/login/register/register_pc_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1080) {
        return const RegisterPcPage();
      } else {
        return const RegisterMobilePage();
      }
    });
  }
}
