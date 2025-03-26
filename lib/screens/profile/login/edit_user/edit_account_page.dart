// import 'dart:math' as math;
import 'dart:typed_data';

//
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/theme/apptheme.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/side_menu/slide_rotate_menu.dart';

final avatarProvider = StateProvider<Uint8List?>((ref) => null);

class EditAccountPage extends ConsumerStatefulWidget {
  const EditAccountPage({super.key});

  @override
  ConsumerState<EditAccountPage> createState() => EditAccountPageState();
}

class EditAccountPageState extends ConsumerState<EditAccountPage> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final response = await ApiServices.get(
      ref: ref,
      URLs.userProfile,
      hasToken: true,
    );

    if (response != null && response.statusCode == 200) {
      final data = response.data;
      _emailController.text = data['email'];
      _firstNameController.text = data['first_name'];
      _lastNameController.text = data['last_name'];
      if (data['profile']['avatar'] != null) {
        final avatarUrl = URLs.avatar(data['profile']['avatar']);
        final avatarResponse = await ApiServices.get(
          ref: ref,
          avatarUrl,
          hasToken: true,
          responseType: ResponseType.bytes,
        );
        if (avatarResponse != null && avatarResponse.statusCode == 200) {
          ref.read(avatarProvider.notifier).state =
              Uint8List.fromList(avatarResponse.data);
        }
      }
    } else {
      final snackBar = Customsnackbar().showSnackBar(
          "Error", "Błąd ładowania danych: ${response}", "error", () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _pickAvatar(WidgetRef ref) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List avatarData = await pickedFile.readAsBytes();
      ref.read(avatarProvider.notifier).state = avatarData;
    }
  }

  Future<void> updateUserData(BuildContext context, WidgetRef ref) async {
    final formData = FormData();

    formData.fields.add(MapEntry('email', _emailController.text));
    formData.fields.add(MapEntry('username', _emailController.text));
    formData.fields.add(MapEntry('first_name', _firstNameController.text));
    formData.fields.add(MapEntry('last_name', _lastNameController.text));
    if (_passwordController.text.isNotEmpty) {
      formData.fields.add(MapEntry('password', _passwordController.text));
      formData.fields.add(MapEntry('password2', _password2Controller.text));
    }

    final avatarData = ref.read(avatarProvider);
    if (avatarData != null) {
      formData.files.add(MapEntry(
        'avatar',
        MultipartFile.fromBytes(avatarData, filename: 'avatar.jpg'),
      ));
    }

    final response = await ApiServices.put(
      URLs.editProfile,
      formData: formData,
      hasToken: true,
    );

    if (response != null && response.statusCode == 200) {
      final snackBar = Customsnackbar().showSnackBar(
          "Success", 'Dane zaktualizowane pomyślnie'.tr, "success", () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = Customsnackbar().showSnackBar(
          "Error", 'Błąd aktualizacji: ${response}'.tr, "error", () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarBytes = ref.watch(avatarProvider);
    // double screenWidth = MediaQuery.of(context).size.width;
    // double inputWidth = math.max(screenWidth * 0.33, 350);
    final theme = ref.watch(themeColorsProvider);
    final sideMenuKey = GlobalKey<SideMenuState>();

    return Scaffold(
      body: SideMenuManager.sideMenuSettings(
        menuKey:sideMenuKey ,
        child: Row(
          children: [
             Sidebar(
               sideMenuKey: sideMenuKey,
             ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    gradient: CustomBackgroundGradients.getMainMenuBackground(
                        context, ref)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => _pickAvatar(ref),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: theme.fillColor,
                          backgroundImage: avatarBytes != null
                              ? MemoryImage(avatarBytes)
                              : null,
                          child: avatarBytes == null
                              ? Icon(Icons.add_a_photo,
                                  color: theme.textFieldColor, size: 50)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),
                      BuildTextField(
                        labelText: 'Email',
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      BuildTextField(
                        labelText: 'Imię'.tr,
                        controller: _firstNameController,
                      ),
                      const SizedBox(height: 20),
                      BuildTextField(
                        labelText: 'Nazwisko'.tr,
                        controller: _lastNameController,
                      ),
                      const SizedBox(height: 20),
                      BuildTextField(
                        labelText: 'Hasło'.tr,
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      BuildTextField(
                        labelText: 'Potwierdź hasło'.tr,
                        controller: _password2Controller,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).primaryColor)),
                        onPressed: () => updateUserData(context, ref),
                        child: Text(
                          'Zapisz zmiany'.tr,
                          style: TextStyle(
                              color: Theme.of(context).iconTheme.color!),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildTextField extends ConsumerWidget {
  const BuildTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  });
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: CustomBackgroundGradients.adGradient1(context, ref)),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Theme.of(context).iconTheme.color!),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: Theme.of(context).iconTheme.color,
            ),
            floatingLabelStyle: TextStyle(
              color: Theme.of(context).iconTheme.color,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Theme.of(context).iconTheme.color!),
            ),
            fillColor: Colors.transparent),
      ),
    );
  }
}
