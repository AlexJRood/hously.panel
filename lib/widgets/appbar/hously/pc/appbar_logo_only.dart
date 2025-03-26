//lib/components/appbar.dart

import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/appbar/widgets/logo_hously.dart'; // Zmiana kolejności importów;

class TopAppBarLogoOnly extends StatelessWidget {
  const TopAppBarLogoOnly({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    const double maxWidth = 1920;
    const double minWidth = 480;
    const double maxLogoSize = 30;
    const double minLogoSize = 16;

    double logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) +
        minLogoSize;
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(),
          LogoHouslyWidget(),
        ],
      ),
    );
  }
}
