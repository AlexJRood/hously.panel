import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';

import '../../../state_managers/services/navigation_service.dart';

class AiAppBar extends StatelessWidget {
  const AiAppBar({
    super.key,
    this.isMobile = false,
    this.scaffoldKey,
  });
  final bool isMobile;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(22, 25, 32, 0.35),
              Color.fromRGBO(34, 57, 62, 0.35),
            ]),
          ),
          height: 80,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isMobile)
                  IconButton(
                      onPressed: () {
                        scaffoldKey?.currentState?.openDrawer();
                      },
                      icon: SvgPicture.asset(
                        AppIcons.menu,
                        color: Colors.white,
                      )),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: Color.fromRGBO(18, 77, 36, 0.1)),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('ChatGPT-4',
                        style: TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1),
                            fontSize: 20)),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: SvgPicture.asset(
                    AppIcons.close,
                    height: 25,
                    width: 25,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
