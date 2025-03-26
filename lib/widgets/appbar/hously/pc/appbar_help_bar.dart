
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/appbar/widgets/logo_hously.dart';
import 'package:hously_flutter/widgets/screens/home_page/help_bar_buttons_only.dart';

class TopAppBarHelpBar extends ConsumerWidget {
  const TopAppBarHelpBar({super.key});

  @override
  Widget build(BuildContext context,ref) {
    //Dynamiczne logo
    double screenWidth = MediaQuery.of(context).size.width;
    // Ustawienie maksymalnej i minimalnej szerokości ekranu
    const double maxWidth = 1920;
    const double minWidth = 480;
    // Ustawienie maksymalnego i minimalnego rozmiaru czcionki
    const double maxLogoSize = 30;
    const double minLogoSize = 16;
    // Obliczenie odpowiedniego rozmiaru czcionki
    double logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) +
        minLogoSize;
    // Ograniczenie rozmiaru czcionki do zdefiniowanych minimum i maksimum
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);
    const double maxDynamicPadding = 40;
    const double minDynamicPadding = 5;
    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: dynamicPadding, vertical: 5),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HelpBarButtonsOnly(),
          Spacer(),
          LogoHouslyWidget(),
          // Ustaw odpowiednią ścieżkę do logo
        ],
      ),
    );
  }
}
