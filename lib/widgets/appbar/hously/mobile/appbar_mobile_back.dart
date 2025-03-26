import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'dart:ui' as ui;

import 'package:hously_flutter/widgets/appbar/widgets/logo_hously.dart';


class AppBarMobileWithBack extends ConsumerWidget {
  const AppBarMobileWithBack({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    final currentthememode = ref.watch(themeProvider);
    //Dynamiczne logo
    // Ustawienie maksymalnej i minimalnej szerokości ekranu
    const double maxWidth = 1920;
    const double minWidth = 480;
    // Ustawienie maksymalnego i minimalnego rozmiaru czcionki
    const double maxLogoSize = 30;
    const double minLogoSize = 22;
    // Obliczenie odpowiedniego rozmiaru czcionki
    double logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) +
        minLogoSize;
    // Ograniczenie rozmiaru czcionki do zdefiniowanych minimum i maksimum
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);
    // Oblicz proporcję szerokości
    // double widthRatio = screenWidth / 1920.0;
    // Oblicz szerokość dla dynamicznego SizedBox
    // double dynamicSizedBoxWidth = 150.0 * widthRatio - 30;
    final theme = ref.watch(themeColorsProvider);
    return  Container(
      height:60,
      width: screenWidth,
      color: Colors.transparent,
      child: ClipRRect(
        child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
            decoration: BoxDecoration(
                color: currentthememode == ThemeMode.system ||
                        currentthememode == ThemeMode.light
                    ? Colors.black.withOpacity(0.1)
                    : Colors.white.withOpacity(0.1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          IconButton(
            icon: SvgPicture.asset(AppIcons.iosArrowLeft,
                color: theme.popUpIconColor,
              height: 25.0,
              width: 25.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          const LogoHouslyWidget(),
        ],
      ),
          ),
        ),
      ),
    );
  }
}
