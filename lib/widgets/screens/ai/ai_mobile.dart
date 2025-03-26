import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_chat.dart';

class AiMobile extends ConsumerWidget {
  const AiMobile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              const SidebarChat(),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: CustomBackgroundGradients
                          .getSideMenuBackgroundwithopacity(context, ref)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
