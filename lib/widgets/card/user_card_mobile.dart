import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/api_services/api_services.dart';

class UserCardMobile extends ConsumerWidget {
  final int userId;
  final VoidCallback onTap;

  const UserCardMobile({
    super.key,
    required this.userId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFuture = ref.watch(userProviderFamily(userId));
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 1920 * 250;
    itemWidth = max(120.0, min(itemWidth, 250.0));
    double dynamicFontSize = 20;
    final isUserLoggedIn = ApiServices.isUserLoggedIn();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: userFuture.when(
          data: (user) {
            final avatarUrl =
                user?.avatarUrl ?? 'assets/images/default_avatar.webp';
            final firstName = user?.firstName ?? '';
            final lastName = user?.lastName ?? '';
            final username = user?.username ?? '';

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: itemWidth,
                    height: itemWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      image: DecorationImage(
                        image: avatarUrl.startsWith(URLs.httpOrHttps)
                            ? NetworkImage(avatarUrl)
                            : AssetImage(avatarUrl) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (firstName.isNotEmpty) ...[
                      Text(
                        '$firstName $lastName',
                        style: AppTextStyles.interSemiBold
                            .copyWith(fontSize: dynamicFontSize),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign
                            .center, // lub TextAlign.left, TextAlign.right w zależności od potrzeb
                      ),
                      Text(
                        username,
                        style: AppTextStyles.interMedium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isUserLoggedIn) ...[
                            TextButton.icon(
                              onPressed: () {},
                              icon: SvgPicture.asset(AppIcons.pencil,
                                  color: AppColors.light),
                              label: Text('Edytuj swój profil'.tr,
                                  style: AppTextStyles.interMedium),
                            )
                          ],
                        ],
                      ),
                    ],
                    if (firstName.isEmpty) ...[
                      Text('Zaloguj się aby wyświetlić'.tr,
                          style: AppTextStyles.interMedium
                              .copyWith(fontSize: dynamicFontSize - 4)),
                      Text('dane sprzedającego'.tr,
                          style: AppTextStyles.interMedium
                              .copyWith(fontSize: dynamicFontSize - 4)),
                    ],
                  ],
                ),
                const SizedBox(height: 5),
              ],
            );
          },
          loading: () => const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: AppColors.light,
                strokeWidth: 2,
              ),
            ),
          ),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
      ),
    );
  }
}
