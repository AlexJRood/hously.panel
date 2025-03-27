import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'dart:ui' as ui;

class LogoHouslyWidget extends StatelessWidget {

  const LogoHouslyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double maxWidth = 1920;
    const double minWidth = 344;
    const double maxLogoSize = 24;
    const double minLogoSize = 14;

    var logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) + minLogoSize;
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);


    const double maxPaddingSize = 45;
    const double minPaddingSize = 10;


    var logoPaddingSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxPaddingSize - minPaddingSize) + minPaddingSize;
    logoPaddingSize = logoPaddingSize.clamp(minPaddingSize, maxPaddingSize);


    return SizedBox(
      height:60,
      // width: screenWidth -60,
      child: ClipRRect(
          child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          
              child: TextButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: () {
                        BetterFeedback.of(context).show(
                          (feedback) async {
                          },
                        );
                      },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: logoPaddingSize),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        
                        Text(
                          'HOUSLY.panel',
                          style: AppTextStyles.houslyAiLogo.copyWith(
                              fontSize: logoSize,
                              color: Theme.of(context).iconTheme.color),
                        ),
                  ],
                      ),
                    ),
      ),
                ),
            ),
        ),
    );
  }
}
