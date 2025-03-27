import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/theme/apptheme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/utils/loading_widgets.dart';
import 'package:shimmer/shimmer.dart';

class UserTile extends ConsumerWidget {
  final Widget widget;
  const UserTile({super.key, required this.widget});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final userAsyncValue = ref.watch(userProvider);

    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: theme.userTile,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: userAsyncValue.when(
        data: (userData) {
          if (userData == null) {
            return const ShimmerEffectSettingsPhoto();
          }
          return Row(
            children: [
              Expanded(
                flex: 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    userData.avatarUrl ?? 'assets/images/default_avatar.webp',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 40, color: Colors.red),
                  ),
                ),
              ),
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                flex: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userData.firstName} ${userData.lastName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.whitewhiteblack,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      userData.email,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.whitewhiteblack.withOpacity(0.8),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: widget,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const ShimmerEffectSettingsPhoto(),
        error: (error, stackTrace) => const ShimmerEffectSettingsPhoto(),
      ),
    );
  }
}

class SwitchUserTile extends ConsumerWidget {
  final String title;
  final String email;
  final int index;
  final int selectedindex;
  final Widget widget;

  const SwitchUserTile({
    super.key,
    required this.index,
    required this.selectedindex,
    required this.widget,
    required this.title,
    required this.email,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        double imageSize = constraints.maxWidth < 600 ? 44 : 60;
        double fontSizeTitle = constraints.maxWidth < 600 ? 14 : 16;
        double fontSizeEmail = constraints.maxWidth < 600 ? 12 : 14;

        return Container(
          padding: const EdgeInsets.only(left: 5),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: index == selectedindex ? theme.userTile : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Container(
                height: imageSize,
                width: imageSize,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/image.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              const SizedBox(width: 8), // Spacing between image and text
              // Title and Email Section
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: index == selectedindex
                          ? Theme.of(context).iconTheme.color
                          : theme.whitewhiteblack,
                      fontSize: fontSizeTitle,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: fontSizeEmail,
                      color: index == selectedindex
                          ? Theme.of(context).iconTheme.color!.withOpacity(0.8)
                          : theme.whitewhiteblack.withOpacity(0.8),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [widget, const Spacer()],
              ),
            ],
          ),
        );
      },
    );
  }
}
