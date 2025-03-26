import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/const.dart';


// ignore: must_be_immutable
class Terms extends StatelessWidget {
  TextEditingController terms = TextEditingController();
   Terms({super.key,required this.terms});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 520,
      child: TextField(controller: terms,
        maxLines: 3, // For multiline text field
        decoration: customdecoration().customInputDecoration("Terms And Conditions"),
      ),
    );
  }
}
