// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui; // Zaimportuj SecureStorage

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_logo.dart';
import 'package:image_picker/image_picker.dart';

final avatarProvider = StateProvider<Uint8List?>((ref) => null);
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
final marketingConsentProvider = StateProvider<bool>((ref) => false);

class RegisterPcPop extends ConsumerWidget {
  RegisterPcPop({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();

  Future<void> _pickAvatar(WidgetRef ref) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List avatarData = await pickedFile.readAsBytes();
      ref.read(avatarProvider.notifier).state = avatarData;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarBytes = ref.watch(avatarProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double inputWidth = math.max(screenWidth * 0.33, 350);

    final termsAccepted = ref.watch(termsAcceptedProvider);
    final marketingConsent = ref.watch(marketingConsentProvider);

    return Stack(
      children: [
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.85),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const TopAppBarLogoRegisterPage(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            const Spacer(),
                            Center(
                              child: SizedBox(
                                width: inputWidth / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Material(
                                        color: Colors.transparent,
                                        child: Text(
                                            'Dodaj zdjęcie profilowe'.tr,
                                            style: AppTextStyles.interRegular
                                                .copyWith(fontSize: 12))),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () => _pickAvatar(ref),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey.shade200,
                                        backgroundImage: avatarBytes != null
                                            ? MemoryImage(avatarBytes)
                                            : null,
                                        child: avatarBytes == null
                                            ? SvgPicture.asset(AppIcons.camera,
                                                width: 50,
                                                height: 50,
                                        )
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 140,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                width: inputWidth,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        gradient:
                                            BackgroundGradients.adGradient55,
                                      ),
                                      child: TextField(
                                        controller: _emailController,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: const BorderSide(
                                                color: Colors.white54),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        gradient:
                                            BackgroundGradients.adGradient55,
                                      ),
                                      child: TextField(
                                        controller: _firstNameController,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          labelText: 'Imię'.tr,
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: const BorderSide(
                                                color: Colors.white54),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        gradient:
                                            BackgroundGradients.adGradient55,
                                      ),
                                      child: TextField(
                                        controller: _lastNameController,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          labelText: 'Nazwisko'.tr,
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: const BorderSide(
                                                color: Colors.white54),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        gradient:
                                            BackgroundGradients.adGradient55,
                                      ),
                                      child: TextField(
                                        controller: _passwordController,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          labelText: 'Hasło'.tr,
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: const BorderSide(
                                                color: Colors.white54),
                                          ),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        gradient:
                                            BackgroundGradients.adGradient55,
                                      ),
                                      child: TextField(
                                        controller: _password2Controller,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: InputDecoration(
                                          labelText: 'Potwierdź hasło'.tr,
                                          labelStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            borderSide: const BorderSide(
                                                color: Colors.white54),
                                          ),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Expanded(
                                          // Używam Expanded zamiast Column dla lepszego zarządzania przestrzenią
                                          child: Column(
                                            children: [
                                              // Checkbox 1 - Zaakceptowanie warunków
                                              CheckboxListTile(
                                                title: Text(
                                                    'Akceptuję warunki użytkowania'
                                                        .tr,
                                                    style: AppTextStyles
                                                        .interRegular
                                                        .copyWith(
                                                            fontSize: 10)),
                                                value: termsAccepted,
                                                onChanged: (bool? value) {
                                                  ref
                                                      .read(
                                                          termsAcceptedProvider
                                                              .notifier)
                                                      .state = value!;
                                                },
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                              ),
                                              // Checkbox 2 - Zgoda marketingowa
                                              CheckboxListTile(
                                                title: Text(
                                                    'Zgoda na otrzymywanie informacji marketingowych'
                                                        .tr,
                                                    style: AppTextStyles
                                                        .interRegular
                                                        .copyWith(
                                                            fontSize: 10)),
                                                value: marketingConsent,
                                                onChanged: (bool? value) {
                                                  ref
                                                      .read(
                                                          marketingConsentProvider
                                                              .notifier)
                                                      .state = value!;
                                                },
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: inputWidth /
                                              3, // Responsywna szerokość
                                          height:
                                              48, // Ustaw wysokość, żeby dopasować do standardowej wysokości ElevatedButton
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                30.0), // Dopasuj promień do przycisku
                                            gradient: BackgroundGradients
                                                .adGradient55, // Twój gradient
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (termsAccepted) {
                                                _register(context, ref);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Musisz zaakceptować warunki użytkowania, aby kontynuować.'
                                                            .tr),
                                                    duration:
                                                        Duration(seconds: 3),
                                                  ),
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors
                                                  .transparent, // Ustaw przezroczyste tło
                                              shadowColor: Colors
                                                  .transparent, // Usuń cień, żeby gradient był widoczny
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            child: Text('Zarejestruj'.tr,
                                                style: AppTextStyles
                                                    .interRegular
                                                    .copyWith(fontSize: 16)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Spacer()
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _register(BuildContext context, WidgetRef ref) async {
    final registerUrl = URLs.register;

    try {
      // Prepare form data
      final formData = FormData.fromMap({
        'username': _emailController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password2': _password2Controller.text,
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
      });

      // Add avatar file if available
      final avatarData = ref.read(avatarProvider);
      if (avatarData != null) {
        formData.files.add(
          MapEntry(
            'avatar',
            MultipartFile.fromBytes(avatarData, filename: 'avatar.jpg'),
          ),
        );
      }

      // Send the request
      final response = await ApiServices.post(registerUrl, formData: formData);

      // Check for successful response and handle data
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        final data = response.data;

        if (data.containsKey('token')) {
          final token = data['token'];
          final secureStorage = SecureStorage();
          await secureStorage.saveToken(token);
          await ApiServices.init(ref);

          final successSnackBar = Customsnackbar().showSnackBar(
            "success",
            'Registered successfully, you are logged in'.tr,
            "success",
            () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          );
          ScaffoldMessenger.of(context).showSnackBar(successSnackBar);

          // Navigate to the previous page or homepage
          ref
              .read(navigationHistoryProvider.notifier)
              .removeSpecificPages(['/login', '/register']);
          ref.read(navigationService).beamPop();
        } else {
  final errorSnackBar = Customsnackbar().showSnackBar(
    "Error", 
    'Registration failed'.tr, 
    "error", 
    () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    },
  );
  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
} 
} else {
  final errorSnackBar = Customsnackbar().showSnackBar(
    "Error", 
    'Registration error: $response'.tr, 
    "error", 
    () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    },
  );
  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
}
} catch (e) {
  final errorSnackBar = Customsnackbar().showSnackBar(
    "Error", 
    'Registration error: $e'.tr, 
    "error", 
    () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    },
  );
  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
}

  }
}
