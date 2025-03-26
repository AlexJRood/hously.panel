import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';

class UserCard extends ConsumerWidget {
  final int userId;
  final VoidCallback onTap;

  const UserCard({
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
    double minBaseTextSize = 12;
    double maxBaseTextSize = 18;
    double dynamicFontSize = minBaseTextSize +
        (itemWidth - 120) / (180 - 120) * (maxBaseTextSize - minBaseTextSize);
    dynamicFontSize = max(minBaseTextSize, min(dynamicFontSize, maxBaseTextSize));
    final isUserLoggedIn = ApiServices.isUserLoggedIn();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: userFuture.when(
          data: (user) {
            final avatarUrl = user?.avatarUrl ?? 'assets/images/default_avatar.webp';
            final firstName = user?.firstName ?? '';
            final lastName = user?.lastName ?? '';

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isUserLoggedIn) ...[
                      TextButton.icon(
                        onPressed: () {
                          ref.read(navigationService)
                              .pushNamedReplacementScreen(Routes.editAccount);
                        },
                        icon: const Icon(Icons.edit, color: AppColors.light),
                        label: Text('Edytuj swój profil'.tr,
                            style: AppTextStyles.interLight),
                      )
                    ],
                  ],
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                Column(
                  children: [
                    if (firstName.isNotEmpty) ...[
                      Text(
                        '$firstName $lastName',
                        style: AppTextStyles.interMedium
                            .copyWith(fontSize: dynamicFontSize),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign
                            .center, // lub TextAlign.left, TextAlign.right w zależności od potrzeb
                      )
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
