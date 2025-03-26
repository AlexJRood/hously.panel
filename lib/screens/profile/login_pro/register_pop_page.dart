import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/screens/profile/register_mobile_pop.dart';
import 'package:hously_flutter/widgets/screens/profile/register_pc_pop.dart';

class RegisterPopPage extends StatelessWidget {
  const RegisterPopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 1080) {
        return RegisterPcPop();
      } else {
        return RegisterMobilePop();
      }
    });
  }
}
