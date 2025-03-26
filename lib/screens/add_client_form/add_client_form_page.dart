import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/add_client_form/add_client_form_mobile.dart';
import 'package:hously_flutter/screens/add_client_form/add_client_form_pc.dart';

class AddClientFormScreen extends StatelessWidget {
  const AddClientFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1150) {
          return const AddClientFormPc();
        } else {
          return  const AddClientFormMobile();
        }
      },
    );
  }
}
