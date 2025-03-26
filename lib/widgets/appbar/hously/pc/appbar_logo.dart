//lib/components/appbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart'; 
import 'dart:ui' as ui;
import 'package:hously_flutter/widgets/appbar/widgets/logo_hously.dart';

class TopAppBarLogoOnly extends ConsumerWidget {
  const TopAppBarLogoOnly({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      height: 60,
      width: screenWidth - 60,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            // color: theme.adPopBackground.withOpacity(0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 10),
                IconButton(
                  icon: SvgPicture.asset(AppIcons.iosArrowLeft,
                      color: Theme.of(context).iconTheme.color, height: 25.0,width: 25,),
                  onPressed: () {
                    ref.read(navigationService).beamPop();
                  },
                ),

                const Spacer(),

        const LogoHouslyWidget(),
        ],
      ),),),),
    );
  }
}



class TopAppBarLogoRegisterPage extends ConsumerWidget {
  const TopAppBarLogoRegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      height: 60,
      width: screenWidth - 60,
      child: ClipRRect(
        child: Container(
          height: 60,
          width: screenWidth - 60,
          child: ClipRRect(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  
        const LogoHouslyWidget(),
                        ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
