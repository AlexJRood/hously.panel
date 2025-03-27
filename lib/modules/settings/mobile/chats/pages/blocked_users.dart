import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/modules/settings/components/mobile/blocked_user_tile.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/modules/settings/components/pc/chats%20components%20pc/chats_pc_components.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class BlockedUsers extends ConsumerWidget {
  const BlockedUsers({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient:
                CustomBackgroundGradients.getMainMenuBackground(context, ref)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppBar Section
            MobileSettingsAppbar(
              title: "Zablokowani użytkownicy".tr,
              onPressed: () {
                ref.read(navigationService).beamPop();
              },
            ),

            // Scrollable Fields Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Zablokowani użytkownicy".tr,
                            style: TextStyle(color: theme.mobileTextcolor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Zapobiegaj niechcianym interakcjom, blokując użytkowników. Zablokowani użytkownicy nie będą widzieć Twojego profilu ani aktywności"
                                .tr,
                            style: TextStyle(
                                color: theme.mobileTextcolor, fontSize: 12)),
                        SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlockedUserTileMobile(
                            userName: "name",
                            email: "name@gmail.com",
                            avatarUrl: "assets/images/image.png",
                            onUnblock: () {}),
                        SizedBox(
                          height: 5,
                        ),
                        BlockedUserTileMobile(
                            userName: "name",
                            email: "name@gmail.com",
                            avatarUrl: "assets/images/image.png",
                            onUnblock: () {}),
                        SizedBox(
                          height: 5,
                        ),
                        BlockedUserTileMobile(
                            userName: "name",
                            email: "name@gmail.com",
                            avatarUrl: "assets/images/image.png",
                            onUnblock: () {}),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Fixed Bottom Button Section
          ],
        ),
      ),
    );
  }
}
