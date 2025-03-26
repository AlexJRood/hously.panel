// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/theme/apptheme.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/side_menu/slide_rotate_menu.dart';

final avatarProvider = StateProvider<Uint8List?>((ref) => null);
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
final marketingConsentProvider = StateProvider<bool>((ref) => false);

class RegisterMobilePage extends ConsumerWidget {
  RegisterMobilePage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();

  Future<void> _pickAvatar(WidgetRef ref) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List avatarData = await pickedFile.readAsBytes();
      ref.read(avatarProvider.notifier).state = avatarData;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    final avatarBytes = ref.watch(avatarProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double inputWidth = math.max(screenWidth * 0.65, 320);
    double dynamicPadding = 15;

    final termsAccepted = ref.watch(termsAcceptedProvider);
    final marketingConsent = ref.watch(marketingConsentProvider);
    final theme = ref.watch(themeColorsProvider);
    return PopupListener(
      child: SafeArea(
        child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
              decoration: BoxDecoration(
                  gradient: CustomBackgroundGradients.getMainMenuBackground(
                      context, ref)),
              child: SizedBox(
                width: inputWidth,
                child: Column(
                  children: [
                    AppBarMobile(
                      sideMenuKey: sideMenuKey,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: inputWidth,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                  width: inputWidth,
                                  child: Column(
                                    // ... pozostały kod
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Dodaj zdjęcie profilowe'.tr,
                                          style: AppTextStyles.interRegular
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                      SizedBox(
                                        height: dynamicPadding,
                                      ),
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
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                                  size: 50)
                                              : null,
                                        ),
                                      ),
                                      // ... pozostały kod
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: dynamicPadding * 2),
                              SizedBox(
                                width: inputWidth,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref)),
                                      child: TextField(
                                        controller: _emailController,
                                        style: AppTextStyles.interMedium.copyWith(
                                          fontSize: 12,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                        decoration: InputDecoration(
                                            labelText: 'Email',
                                            labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                            floatingLabelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
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
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color!),
                                            ),
                                            fillColor: Colors.transparent),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref)),
                                      child: TextField(
                                        controller: _firstNameController,
                                        style: AppTextStyles.interMedium.copyWith(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        decoration: InputDecoration(
                                            labelText: 'Imię',
                                            labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                            floatingLabelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
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
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color!),
                                            ),
                                            fillColor: Colors.transparent),
                                      ),
                                    ),
                                    SizedBox(height: dynamicPadding),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref)),
                                      child: TextField(
                                        controller: _lastNameController,
                                        style: AppTextStyles.interMedium.copyWith(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        decoration: InputDecoration(
                                            labelText: 'Nazwisko'.tr,
                                            labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                            floatingLabelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
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
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color!),
                                            ),
                                            fillColor: Colors.transparent),
                                      ),
                                    ),
                                    SizedBox(height: dynamicPadding),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref)),
                                      child: TextField(
                                        controller: _passwordController,
                                        style: AppTextStyles.interMedium.copyWith(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        decoration: InputDecoration(
                                          labelText: 'Hasło'.tr,
                                          labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).iconTheme.color,
                                          ),
                                          floatingLabelStyle: TextStyle(
                                            color:
                                                Theme.of(context).iconTheme.color,
                                          ),
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
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color!),
                                          ),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                    SizedBox(height: dynamicPadding),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref)),
                                      child: TextField(
                                        controller: _password2Controller,
                                        style: AppTextStyles.interMedium.copyWith(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        decoration: InputDecoration(
                                          labelText: 'Potwierdź hasło'.tr,
                                          labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).iconTheme.color,
                                          ),
                                          floatingLabelStyle: TextStyle(
                                            color:
                                                Theme.of(context).iconTheme.color,
                                          ),
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
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color!),
                                          ),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                    SizedBox(height: dynamicPadding),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              CheckboxListTile(
                                                title: Text(
                                                    'Akceptuję warunki użytkowania'
                                                        .tr,
                                                    style: AppTextStyles
                                                        .interLight
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color:
                                                                Theme.of(context)
                                                                    .iconTheme
                                                                    .color)),
                                                value: termsAccepted,
                                                onChanged: (bool? value) {
                                                  ref
                                                      .read(termsAcceptedProvider
                                                          .notifier)
                                                      .state = value!;
                                                },
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                              ),
                                              CheckboxListTile(
                                                title: Text(
                                                    'Zgoda na otrzymywanie informacji marketingowych'
                                                        .tr,
                                                    style: AppTextStyles
                                                        .interLight
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color:
                                                                Theme.of(context)
                                                                    .iconTheme
                                                                    .color)),
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
                                          width: inputWidth / 3,
                                          // Responsywna szerokość
                                          height: 48,
                                          // Ustaw wysokość, żeby dopasować do standardowej wysokości ElevatedButton
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              // Dopasuj promień do przycisku
                                              gradient: CustomBackgroundGradients
                                                  .adGradient1(context, ref)),
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
                                              backgroundColor: Colors.transparent,
                                              // Ustaw przezroczyste tło
                                              shadowColor: Colors.transparent,
                                              // Usuń cień, żeby gradient był widoczny
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            child: Text('Zarejestruj'.tr,
                                                style: AppTextStyles.interSemiBold
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .iconTheme
                                                            .color)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: dynamicPadding * 2),
                              SizedBox(
                                width: inputWidth,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref)),
                                      child: TextField(
                                        controller: _emailController,
                                        style: AppTextStyles.interMedium.copyWith(
                                          fontSize: 12,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                        decoration: InputDecoration(
                                            labelText: 'Email',
                                            labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                            floatingLabelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
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
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color!),
                                            ),
                                            fillColor: Colors.transparent),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref)),
                                      child: TextField(
                                        controller: _firstNameController,
                                        style: AppTextStyles.interMedium.copyWith(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        decoration: InputDecoration(
                                            labelText: 'Imię'.tr,
                                            labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                            floatingLabelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
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
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color!),
                                            ),
                                            fillColor: Colors.transparent),
                                      ),
                                    ),
                                    SizedBox(height: dynamicPadding),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref)),
                                      child: TextField(
                                        controller: _lastNameController,
                                        style: AppTextStyles.interMedium.copyWith(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        decoration: InputDecoration(
                                            labelText: 'Nazwisko'.tr,
                                            labelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
                                            floatingLabelStyle: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                            ),
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
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color!),
                                            ),
                                            fillColor: Colors.transparent),
                                      ),
                                    ),
                                    SizedBox(height: dynamicPadding),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref)),
                                      child: TextField(
                                        controller: _passwordController,
                                        style: AppTextStyles.interMedium.copyWith(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        decoration: InputDecoration(
                                          labelText: 'Hasło'.tr,
                                          labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).iconTheme.color,
                                          ),
                                          floatingLabelStyle: TextStyle(
                                            color:
                                                Theme.of(context).iconTheme.color,
                                          ),
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
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color!),
                                          ),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                    SizedBox(height: dynamicPadding),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref)),
                                      child: TextField(
                                        controller: _password2Controller,
                                        style: AppTextStyles.interMedium.copyWith(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        decoration: InputDecoration(
                                          labelText: 'Potwierdź hasło'.tr,
                                          labelStyle: TextStyle(
                                            color:
                                                Theme.of(context).iconTheme.color,
                                          ),
                                          floatingLabelStyle: TextStyle(
                                            color:
                                                Theme.of(context).iconTheme.color,
                                          ),
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
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color!),
                                          ),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                    SizedBox(height: dynamicPadding),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              CheckboxListTile(
                                                title: Text(
                                                    'Akceptuję warunki użytkowania'
                                                        .tr,
                                                    style: AppTextStyles
                                                        .interLight
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color:
                                                                Theme.of(context)
                                                                    .iconTheme
                                                                    .color)),
                                                value: termsAccepted,
                                                onChanged: (bool? value) {
                                                  ref
                                                      .read(termsAcceptedProvider
                                                          .notifier)
                                                      .state = value!;
                                                },
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                              ),
                                              CheckboxListTile(
                                                title: Text(
                                                    'Zgoda na otrzymywanie informacji marketingowych'
                                                        .tr,
                                                    style: AppTextStyles
                                                        .interLight
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color:
                                                                Theme.of(context)
                                                                    .iconTheme
                                                                    .color)),
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
                                          width: inputWidth / 3,
                                          // Responsywna szerokość
                                          height: 48,
                                          // Ustaw wysokość, żeby dopasować do standardowej wysokości ElevatedButton
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              // Dopasuj promień do przycisku
                                              gradient: CustomBackgroundGradients
                                                  .adGradient1(context, ref)),
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
                                              backgroundColor: Colors.transparent,
                                              // Ustaw przezroczyste tło
                                              shadowColor: Colors.transparent,
                                              // Usuń cień, żeby gradient był widoczny
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            child: Text('Zarejestruj'.tr,
                                                style: AppTextStyles.interSemiBold
                                                    .copyWith(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .iconTheme
                                                            .color)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const BottomBarMobile(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register(BuildContext context, WidgetRef ref) async {
    final registerUrl = URLs.register;

    try {
      // Prepare the form data
      final formData = FormData.fromMap({
        'username': _emailController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password2': _password2Controller.text,
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
      });

      // Add avatar if it exists
      final avatarData = ref.read(avatarProvider);
      if (avatarData != null) {
        formData.files.add(MapEntry(
          'avatar',
          MultipartFile.fromBytes(avatarData, filename: 'avatar.jpg'),
        ));
      }

      // Send the request
      final response = await ApiServices.post(registerUrl, formData: formData);

      // Handle response based on status code
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        final data = response.data;

        if (data.containsKey('token')) {
          final token = data['token'];
          final secureStorage = SecureStorage();
          await secureStorage.saveToken(token);
          await ApiServices.init(ref);

          final snackBar = Customsnackbar().showSnackBar(
              "Registered successfully", "You are now loogged in", "success",
              () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          });
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          // Redirect to the appropriate page
          ref
              .read(navigationHistoryProvider.notifier)
              .removeSpecificPages(['/login', '/register']);
          final lastPage =
              ref.read(navigationHistoryProvider.notifier).lastPage;
          ref.read(navigationService).pushNamedReplacementScreen(lastPage);
        } else {
          final snackBar = Customsnackbar().showSnackBar(
              "Registration Failed", "Please try again", "error", () {
            _register(context, ref);
          });
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = Customsnackbar().showSnackBar(
            "Error", "Registration error ${response}".tr, "error", () {
          _register(context, ref);
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      // Catch Dio errors and display a message
      final snackBar = Customsnackbar()
          .showSnackBar("Error", "Registration error ${e}".tr, "error", () {
        _register(context, ref);
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
