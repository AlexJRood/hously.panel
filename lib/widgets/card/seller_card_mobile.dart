import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/seller_provider.dart';

class SellerCardMobile extends ConsumerWidget {
  final int sellerId;
  final VoidCallback onTap;

  const SellerCardMobile({
    super.key,
    required this.sellerId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellerFuture = ref.watch(sellerProviderFamily(sellerId));
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 3;
    double dynamicFontSize = screenWidth < 400 ? 16 : 20;
    final theme = ref.watch(themeColorsProvider);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: sellerFuture.when(
          data: (seller) {
            final avatarUrl =
                seller?.avatarUrl ?? 'assets/images/default_avatar.webp';
            final firstName = seller?.firstName ?? '';
            final lastName = seller?.lastName ?? '';

            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: screenWidth < 400 ? itemWidth * 0.8 : itemWidth,
                    height: screenWidth < 400 ? itemWidth * 0.8 : itemWidth,
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
                      const SizedBox(height: 5),
                      Text(
                        '$firstName $lastName',
                        style: AppTextStyles.interSemiBold.copyWith(
                            fontSize: dynamicFontSize,
                            color: theme.popUpIconColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Hej! Interesuje Cię ta nieruchomość?'.tr,
                        style: AppTextStyles.interRegular.copyWith(
                            fontSize: dynamicFontSize / 3 * 2,
                            color: theme.popUpIconColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Napisz do mnie!'.tr,
                        style: AppTextStyles.interRegular.copyWith(
                            fontSize: dynamicFontSize / 3 * 2,
                            color: theme.popUpIconColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
              ],
            );
          },
          loading: () => Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: theme.popUpIconColor,
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
