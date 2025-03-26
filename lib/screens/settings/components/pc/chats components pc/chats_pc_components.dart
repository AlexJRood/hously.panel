import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/screens/settings/components/settings_button.dart';
import 'package:hously_flutter/screens/settings/components/pc/components/settings_tiles.dart';
import 'package:hously_flutter/screens/settings/components/security_screen_button.dart';
import 'package:hously_flutter/screens/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class BlockedUserTile extends StatelessWidget {
  final String imageurl;
  final String name;
  final String email;
  const BlockedUserTile(
      {super.key,
      required this.imageurl,
      required this.email,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageurl),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
            flex: 14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingText(
                  text: name,
                  fontsize: 14,
                ),
                const SizedBox(
                  height: 4,
                ),
                SubtitleText(
                  text: email,
                  fontsize: 12,
                )
              ],
            )),
        const Expanded(
          flex: 14,
          child: SizedBox(
            width: 10,
          ),
        ),
        Expanded(
            flex: 4, child: CustomElevatedButton(text: 'Unblock', onTap: () {}))
      ],
    );
  }
}


