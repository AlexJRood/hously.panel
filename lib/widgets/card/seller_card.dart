import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/seller_provider.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';

class SellerCard extends ConsumerWidget {
  final int sellerId;
  final VoidCallback onTap;

  const SellerCard({
    super.key,
    required this.sellerId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sellerFuture = ref.watch(sellerProviderFamily(sellerId));
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 1920 * 180;
    itemWidth = max(120.0, min(itemWidth, 180.0));
    double minBaseTextSize = 12;
    double maxBaseTextSize = 16;
    double dynamicFontSize = minBaseTextSize +
        (itemWidth - 120) / (180 - 120) * (maxBaseTextSize - minBaseTextSize);
    dynamicFontSize =
        max(minBaseTextSize, min(dynamicFontSize, maxBaseTextSize));
    final theme = ref.watch(themeColorsProvider);

    return ElevatedButton(
      style: elevatedButtonStyleRounded20,
      onPressed: onTap,
      child: sellerFuture.when(
        data: (seller) {
          final avatarUrl =
              seller?.avatarUrl ?? 'assets/images/default_avatar.webp';
          final firstName = seller?.firstName ?? '';
          final lastName = seller?.lastName ?? '';

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: avatarUrl.startsWith(URLs.httpOrHttps)
                    ? CachedNetworkAvatar(
                        avatarUrl: avatarUrl, itemWidth: itemWidth - 10)
                    : AssetAvatar(
                        assetPath: avatarUrl, itemWidth: itemWidth - 10),
              ),
              const SizedBox(height: 10),
              if (firstName.isNotEmpty) ...[
                Text(
                  '$firstName $lastName',
                  style: AppTextStyles.interMedium.copyWith(
                    fontSize: dynamicFontSize,
                    color: theme.popUpIconColor,
                  ),
                ),
              ] else ...[
                Text(
                  'Zaloguj się aby wyświetlić'.tr,
                  style: AppTextStyles.interMedium.copyWith(
                    fontSize: dynamicFontSize - 4,
                    color: theme.popUpIconColor,
                  ),
                ),
                Text(
                  'dane sprzedającego'.tr,
                  style: AppTextStyles.interMedium.copyWith(
                    fontSize: dynamicFontSize - 4,
                    color: theme.popUpIconColor,
                  ),
                ),
              ],
              const SizedBox(height: 5),
            ],
          );
        },
        loading: () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: ShimmerPlaceholder(
                width: itemWidth,
                height: itemWidth,
              ),
            ),
            const SizedBox(height: 10),
            ShimmerPlaceholder(
              width: itemWidth * 0.8,
              height: dynamicFontSize + 1,
            ),
            const SizedBox(height: 5),
            ShimmerPlaceholder(
              width: itemWidth * 0.8,
              height: dynamicFontSize + 1,
            ),
          ],
        ),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }
}

/// Widget to display a cached network image avatar.
class CachedNetworkAvatar extends StatelessWidget {
  final String avatarUrl;
  final double itemWidth;

  const CachedNetworkAvatar({
    super.key,
    required this.avatarUrl,
    required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
        width: itemWidth,
        height: itemWidth,
        fit: BoxFit.cover,
        placeholder: (context, url) => ShimmerPlaceholder(
          width: itemWidth,
          height: itemWidth,
        ),
        errorWidget: (context, url, error) => const Center(
          child: Text(
            'No image found',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

/// Widget to display an asset image avatar.
class AssetAvatar extends StatelessWidget {
  final String assetPath;
  final double itemWidth;

  const AssetAvatar({
    super.key,
    required this.assetPath,
    required this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: itemWidth,
      height: itemWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
