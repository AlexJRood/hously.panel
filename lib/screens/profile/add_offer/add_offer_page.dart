import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/profile/add_offer/add_offer_mobile_page.dart';
import 'package:hously_flutter/screens/profile/add_offer/add_offer_pc_page.dart';

class AddOfferPage extends StatelessWidget {
  const AddOfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return AddOfferPcPage();
        } else {
          return AddOfferMobilePage();
        }
      },
    );
  }
}

