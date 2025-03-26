import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_chat.dart';

class AiPc extends ConsumerWidget {
  const AiPc({super.key});

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
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: CustomBackgroundGradients
                          .getSideMenuBackgroundwithopacity(context, ref)),
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        'Pracujemy nad tą funkcją, pojawi się wkrótce',
                        style: AppTextStyles.interLight.copyWith(fontSize: 18),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container())
            ],
          ),
        ),
      ],
    );
  }
}
