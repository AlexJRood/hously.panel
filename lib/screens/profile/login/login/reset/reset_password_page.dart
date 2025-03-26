import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/profile/login/login/reset/reset_password_mobile.dart';
import 'package:hously_flutter/screens/profile/login/login/reset/reset_password_pc.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return const ResetPasswordPc();
        } else {
          return const ForgotPasswordMobilePage();
        }
      },
    );
  }
}
