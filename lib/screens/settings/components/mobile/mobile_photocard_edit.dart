import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';

class MobilePhotoCardEdit extends ConsumerWidget {
  const MobilePhotoCardEdit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);
    final userAsyncValue = ref.watch(userProvider);

    return Column(
      children: [
        SizedBox(height: 15),
        userAsyncValue.when(
          loading: () =>
              const ShimmerPlaceholder(width: 140, height: 140, radius: 10),
          error: (error, stackTrace) =>
              const ShimmerPlaceholder(width: 140, height: 140, radius: 10),
          data: (userData) {
            if (userData == null || userData.avatarUrl!.isEmpty) {
              return Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: theme.settingstile,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Icon(Icons.person, size: 50, color: Colors.grey),
              ); // Placeholder when user data is null or image is empty
            }
            return Stack(
              alignment: Alignment.bottomRight,
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
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        AppIcons.camera,
                        color: theme.mobileTextcolor,
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {
                        // Handle change photo action
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 5),
        Text(
          "Change Photo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.mobileTextcolor,
          ),
        ),
      ],
    );
  }
}
