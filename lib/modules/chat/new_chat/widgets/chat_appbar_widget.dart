import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/chat/new_chat/provider/web_socket_provider.dart';
import '../provider/chat_room_provider.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';


class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    super.key,
    this.isMobile = false,
    this.scaffoldKey,
    required this.ref,
  });
  final bool isMobile;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(otherUserData);
    final theme = ref.watch(themeColorsProvider);

    return Container(
        width: double.infinity,
        height: 65,
        child: ClipRRect(
             borderRadius: const BorderRadius.only(topLeft: Radius.circular(32.5), bottomLeft: Radius.circular(32.5)),
      child: Stack(
          children: [            
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
                color: theme.adPopBackground.withOpacity(0.25),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (isMobile)
                        SizedBox(
                          height: 65,width: 65,
                          child: IconButton(
                            style: elevatedButtonStyleRounded10,
                            onPressed: () {
                              final webSocketNotifier =
                                  ref.read(webSocketProvider.notifier);
                              webSocketNotifier.disconnect();
                                
                              ref.read(isChatSelected.notifier).state = false;
                            },
                            icon:  SvgPicture.asset(AppIcons.iosArrowLeft, color: AppColors.light),
                          ),
                        ),
                      Container(
                        height: isMobile ? 45 : 65,
                        width: isMobile ? 45 : 65,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: ClipOval(
                          child: userData.avatar != null &&
                                  userData.avatar!.isNotEmpty
                              ? Image.network(
                                  'https://www.hously.cloud/${userData.avatar!}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return SvgPicture.asset(
                                      AppIcons.person,
                                      color: Colors.white,
                                      height: isMobile ? 25 : 35,
                                      width: isMobile ? 25 : 35,
                                    );
                                  },
                                )
                              :  SvgPicture.asset(
                                  AppIcons.person,
                                  color: Colors.white,
                                  height: 35,
                                  width: 35,
                                ),
                        ),
                      ), Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${userData.firstName} ${userData.lastName}',
                              style: isMobile
                                  ? AppTextStyles.interLight16
                                  : AppTextStyles.interLight18,
                            ),
                          ],
                       
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 15,
                  children: [
                    // Icon(
                    //   Icons.phone,
                    //   color: Colors.white,
                    //   size: isMobile ? 20 : 25,
                    // ),
                    // Icon(
                    //   Icons.video_chat_outlined,
                    //   color: Colors.white,
                    //   size: isMobile ? 20 : 25,
                    // ),
                      SizedBox(
                        height: 65,width: 65,
                        child: IconButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                          },
                          icon:  SvgPicture.asset(AppIcons.moreVertical, color: AppColors.light),
                        ),
                      ),
                    // Icon(
                    //   Icons.more_horiz,
                    //   color: Colors.white,
                    //   size: isMobile ? 20 : 25,
                    // ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
