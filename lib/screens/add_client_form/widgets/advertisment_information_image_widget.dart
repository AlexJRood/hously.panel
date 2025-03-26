import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final advertisementSelectedImagesProvider =
    StateNotifierProvider<SelectedImagesNotifier, List<XFile>>(
  (ref) => SelectedImagesNotifier(),
);

class SelectedImagesNotifier extends StateNotifier<List<XFile>> {
  SelectedImagesNotifier() : super([]);


  Future<void> pickMultipleImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedImages = await picker.pickMultiImage();

    state = [...state, ...pickedImages]; // Append new images to the list
  }

  void removeImage(int index) {
    final newState = [...state];
    newState.removeAt(index);
    state = newState;
  }

  void clearImages() {
    state = [];
  }
}

class AdvertisementInformationImageWidget extends ConsumerWidget {
  const AdvertisementInformationImageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedImages = ref.watch(advertisementSelectedImagesProvider);

    return Column(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            InkWell(
              onTap: () {
                ref
                    .read(advertisementSelectedImagesProvider.notifier)
                    .pickMultipleImages();
              },
              child: Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                child: const Center(
                  child: Icon(Icons.camera_alt_outlined, color: Colors.black),
                ),
              ),
            ),
            ...List.generate(selectedImages.length, (index) {
              return Stack(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        image: kIsWeb
                            ? NetworkImage(selectedImages[index].path)
                            : FileImage(File(selectedImages[index].path))
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(advertisementSelectedImagesProvider.notifier)
                            .removeImage(index);
                      },
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.black54,
                        child: Icon(Icons.close, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }
}
