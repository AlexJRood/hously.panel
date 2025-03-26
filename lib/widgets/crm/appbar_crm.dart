import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/appbar/widgets/logo_hously.dart';
import 'package:hously_flutter/widgets/crm/client_tile.dart';
import 'dart:ui' as ui;

class TopAppBarCRM extends ConsumerWidget {
  final String routeName;

  const TopAppBarCRM({super.key, required this.routeName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    const double maxWidth = 1920;
    const double minWidth = 480;
    const double maxLogoSize = 30;
    const double minLogoSize = 16;

    var logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) + minLogoSize;
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);

    return Container(
      height:60,
      width: screenWidth -60,
      child: ClipRRect(
          child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: ClientListAppBar(routeName: routeName)),
                  const LogoHouslyWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
