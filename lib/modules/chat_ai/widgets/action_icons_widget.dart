import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/theme/icons.dart';

class ActionIcons extends StatelessWidget {
  const ActionIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AppIcons.like,
            color: Colors.grey,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.reply,
            color: Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 8),
           SvgPicture.asset(
            AppIcons.moreVertical,
            color: Colors.grey,
            height: 20,
             width: 20,
          ),
        ],
      ),
    );
  }
}
