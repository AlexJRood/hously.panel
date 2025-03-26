import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Flutter Riverpod

import 'package:hously_flutter/screens/profile/edit_offer/edit_offer_mobile_page.dart';

import 'package:hously_flutter/widgets/screens/edit_offer_pc.dart';

class EditOfferPage extends StatelessWidget {
  // Zmiana na ConsumerWidget
  final int? offerId;

  const EditOfferPage({super.key, required this.offerId});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Sprawdzenie, czy szerokość ekranu jest mniejsza niż 1000 px
      if (constraints.maxWidth > 1200) {
        return EditOfferPc(
          offerId: offerId,
        );
      } else {
        return EditOfferMobilePage(offerId: offerId); // Warunkowe renderowanie
      }
    });
  }
}
