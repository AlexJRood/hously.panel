import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/search_page/filters_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart'; // Import SecureStorage
import 'package:image_picker/image_picker.dart';

class SaveSearchDialog extends ConsumerStatefulWidget {
  const SaveSearchDialog({super.key});

  @override
  _SaveSearchDialogState createState() => _SaveSearchDialogState();
}

class _SaveSearchDialogState extends ConsumerState<SaveSearchDialog> {
  // Define all controllers as before
  TextEditingController savedSearchTitleController = TextEditingController();
  TextEditingController savedSearchDescriptionController =
      TextEditingController();
  TextEditingController tagsController = TextEditingController();
  String? selectedAvatar;
  Uint8List? customAvatarData;

  final ImagePicker _picker = ImagePicker();
  List<String> defaultAvatars = [
    'assets/images/landingpage.webp',
    'assets/images/landingpage.webp',
    'assets/images/landingpage2.webp',
    'assets/images/landingpage.webp',
    'assets/images/landingpage.webp',
    'assets/images/landingpage2.webp',
  ];

  Future<void> pickCustomAvatar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageData = await image.readAsBytes();
      setState(() {
        customAvatarData = imageData;
        selectedAvatar = null;
      });
    }
  }

  final _scrollController = ScrollController();

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Search'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: savedSearchTitleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: savedSearchDescriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: tagsController,
              decoration: const InputDecoration(labelText: 'Tags'),
            ),
            const SizedBox(height: 10),
            const Text('Select Default Avatar:'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _scrollLeft,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: pickCustomAvatar,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                        ...defaultAvatars.map((avatarPath) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedAvatar = avatarPath;
                                customAvatarData = null;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: CircleAvatar(
                                backgroundImage: AssetImage(avatarPath),
                                radius: 30,
                                child: selectedAvatar == avatarPath
                                    ? const Icon(Icons.check,
                                        color: Colors.white)
                                    : null,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _scrollRight,
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (selectedAvatar != null)
              CircleAvatar(
                backgroundImage: AssetImage(selectedAvatar!),
                radius: 80,
              ),
            if (customAvatarData != null)
              CircleAvatar(
                backgroundImage: MemoryImage(customAvatarData!),
                radius: 80,
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            ref.read(navigationService).beamPop();
          },
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () async {
            try {
              // Prepare the filters data as JSON
              final filterNotifier =
                  ref.read(networkMonitoringFilterCacheProvider.notifier);

              // Get the token from SecureStorage
              final secureStorage = SecureStorage();

              if (ApiServices.token == null) {
                print('Authorization token not found');
                final warningSnackBar = Customsnackbar().showSnackBar(
                  "Warning",
                  'Authorization token not found',
                  "warning",
                  () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                );
                ScaffoldMessenger.of(context).showSnackBar(warningSnackBar);

                return;
              }

              // Prepare the data to be sent to the server
              Map<String, dynamic> data = {
                'user_id': 1, // Replace with actual user ID
                'client_id': 1, // Replace with actual client ID
                'title': savedSearchTitleController.text,
                'description': savedSearchDescriptionController.text,
                'tags': tagsController.text,
                'filters': jsonEncode(
                    filterNotifier.filters), // Tutaj dodajemy filtry jako JSON
              };

              // Debugging output
              print('Data to send: $data');

              final formData = FormData.fromMap(data);

              if (customAvatarData != null) {
                formData.files.add(
                  MapEntry(
                    'avatar',
                    MultipartFile.fromBytes(
                      customAvatarData!,
                      filename: 'custom_avatar.png',
                    ),
                  ),
                );
              }

              final response = await ApiServices.post(
                URLs.savedSearch,
                formData: formData,
              );
              if (response != null && response.statusCode == 201) {
                print('Search saved successfully');
                if (mounted) {
                  ref.read(navigationService).beamPop();
                  final successSnackBar = Customsnackbar().showSnackBar(
                    "success",
                    'Search saved successfully',
                    "success",
                    () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  );
                  ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                }
              }
            } catch (e) {}
          },
        ),
      ],
    );
  }
}

Future<void> saveSearch(BuildContext context, WidgetRef ref) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return SaveSearchDialog();
    },
  );
}
