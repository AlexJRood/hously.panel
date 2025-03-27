import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/loading_widgets.dart';

import 'package:shimmer/shimmer.dart';

class MobilePhotoCard extends ConsumerWidget {
  const MobilePhotoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth > 600 ? 130 : 110;
    final userAsyncValue = ref.watch(userProvider);
    final theme = ref.watch(themeColorsProvider);

    return Column(
      children: [
        userAsyncValue.when(
          loading: () => const _ShimmerUserCard(),
          error: (error, stackTrace) => const _ShimmerUserCard(),
          data: (userData) {
            if (userData == null) {
              return const _ShimmerUserCard();
            }

            return Column(
              children: [
                Container(
                  height: 140,
                  width: 140,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: userData.avatarUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const ShimmerMobilePhotocard(
                        width: 140,
                        height: 140,
                        radius: 10,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "${userData.firstName} ${userData.lastName}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: theme.mobileTextcolor),
                ),
                const SizedBox(height: 3),
                Text(userData.email,
                    style: TextStyle(color: theme.mobileTextcolor)),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// **Shimmer Loading Placeholder**
class _ShimmerUserCard extends StatelessWidget {
  const _ShimmerUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        const ShimmerMobilePhotocard(width: 140, height: 140, radius: 10),
        const SizedBox(height: 8),
        Shimmer.fromColors(
          baseColor: ShimmerColors.base(context),
          highlightColor: ShimmerColors.highlight(context),
          child: Container(
            height: 12,
            width: 100,
            decoration: BoxDecoration(
              color: ShimmerColors.background(context),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Shimmer.fromColors(
          baseColor: ShimmerColors.base(context),
          highlightColor: ShimmerColors.highlight(context),
          child: Container(
            height: 10,
            width: 150,
            decoration: BoxDecoration(
              color: ShimmerColors.background(context),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

/// **Reusable Shimmer Box**
class ShimmerMobilePhotocard extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerMobilePhotocard({
    super.key,
    required this.width,
    required this.height,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerColors.base(context),
      highlightColor: ShimmerColors.highlight(context),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ShimmerColors.background(context),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
