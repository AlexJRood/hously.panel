import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_card_pc.dart';

class ClientPhotowidget extends ConsumerWidget {
  final dynamic clientViewPop;
  const ClientPhotowidget({super.key, required this.clientViewPop});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Row(
      children: [
        Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          gradient:
                              CustomBackgroundGradients.getMainMenuBackground(
                                  context, ref)),
                    ),
                    const SizedBox(
                      height: 70,
                    )
                  ],
                ),
                Positioned(
                  top: 50,
                  left: 15,
                  child: NewClientCardPc(
                    onTap: () {},
                    id: clientViewPop.id ?? '',
                    avatar: clientViewPop.avatar ?? '',
                    name: clientViewPop.name ?? '',
                    lastName: clientViewPop.lastName ?? '',
                    email: clientViewPop.email ?? '',
                    phoneNumber: clientViewPop.phoneNumber ?? '',
                  ),
                ),
                Positioned(
                    right: 20,
                    bottom: 5,
                    child: Icon(
                      Icons.edit,
                      size: 15,
                      color: theme.whitewhiteblack,
                    ))
              ],
            )),
      ],
    );
  }
}
