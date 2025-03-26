import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class MobilePhotoCardEdit extends ConsumerWidget {
  final String imageUrl;
  const MobilePhotoCardEdit({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);

    return Column(
      children: [
        Stack(
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
                  imageUrl: imageUrl,
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
                  icon: const Icon(Icons.camera_alt_outlined,
                      color: Colors.white, size: 20),
                  onPressed: () {
                    // Handle change photo action
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          "Change Photo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.popupcontainertextcolor,
          ),
        ),
      ],
    );
  }
}
