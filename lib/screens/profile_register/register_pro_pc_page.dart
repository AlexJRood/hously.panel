// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/theme/apptheme.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_logo.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

final avatarProvider = StateProvider<Uint8List?>((ref) => null);
final logoProvider = StateProvider<Uint8List?>((ref) => null);
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
final marketingConsentProvider = StateProvider<bool>((ref) => false);

class ProRegisterPcPage extends ConsumerWidget {
  ProRegisterPcPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();

  final _companyNameController = TextEditingController();
  final _representativeNameController = TextEditingController();
  final _nipController = TextEditingController();
  final _regonController = TextEditingController();
  final _businessTypeController = TextEditingController();
  final _regCountryController = TextEditingController();
  final _regCityController = TextEditingController();
  final _regStreetController = TextEditingController();
  final _regStreetNumberController = TextEditingController();
  final _regPostalCodeController = TextEditingController();
  final _officeCountryController = TextEditingController();
  final _officeCityController = TextEditingController();
  final _officeStreetController = TextEditingController();
  final _officeStreetNumberController = TextEditingController();
  final _officePostalCodeController = TextEditingController();
  final sideMenuKey = GlobalKey<SideMenuState>();

  Future<void> _pickAvatar(WidgetRef ref) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List avatarData = await pickedFile.readAsBytes();
      ref.read(avatarProvider.notifier).state = avatarData;
    }
  }

  Future<void> _pickLogo(WidgetRef ref) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List logoData = await pickedFile.readAsBytes();
      ref.read(logoProvider.notifier).state = logoData;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarBytes = ref.watch(avatarProvider);
    final logoBytes = ref.watch(logoProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double inputWidth = math.max(screenWidth * 0.33, 350);

    final termsAccepted = ref.watch(termsAcceptedProvider);
    final marketingConsent = ref.watch(marketingConsentProvider);
    final theme = ref.watch(themeColorsProvider);
    return Scaffold(
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Container(
          decoration: BoxDecoration(
              gradient: CustomBackgroundGradients.getMainMenuBackground(
                  context, ref)),
          child: Row(
            children: [
               Sidebar(
                 sideMenuKey: sideMenuKey,
               ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Dodaj zdjęcie profilowe'.tr,
                                          style: AppTextStyles.interRegular
                                              .copyWith(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                      const SizedBox(
                                        height: 20,
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
                                              ? SvgPicture.asset(AppIcons.camera,
                                                  color: theme.textFieldColor,
                                                  height: 50,
                                                  width: 50,
                                          )
                                              : null,
                                        ),
                                      ),
                                      Text('Dodaj logo firmy'.tr,
                                          style: AppTextStyles.interRegular
                                              .copyWith(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () => _pickLogo(ref),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundColor: theme.fillColor,
                                          backgroundImage: logoBytes != null
                                              ? MemoryImage(logoBytes)
                                              : null,
                                          child: logoBytes == null
                                              ? SvgPicture.asset(AppIcons.camera,
                                                  color: theme.textFieldColor,
                                                  height: 50,
                                                  width: 50,
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
                        const SizedBox(
                          width: 50,
                        ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            gradient: CustomBackgroundGradients
                                                .adGradient1(context, ref)),
                                        child: TextField(
                                          controller: _emailController,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                          decoration: InputDecoration(
                                              labelText: 'Email',
                                              labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                              floatingLabelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
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
                                              fillColor: Colors.transparent),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref),
                                        ),
                                        child: TextField(
                                          controller: _firstNameController,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                          decoration: InputDecoration(
                                              labelText: 'Imię'.tr,
                                              labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                              floatingLabelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
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
                                              fillColor: Colors.transparent),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref),
                                        ),
                                        child: TextField(
                                          controller: _lastNameController,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                          decoration: InputDecoration(
                                              labelText: 'Nazwisko'.tr,
                                              labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                              floatingLabelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
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
                                              fillColor: Colors.transparent),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref),
                                        ),
                                        child: TextField(
                                          controller: _companyNameController,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                          decoration: InputDecoration(
                                              labelText: 'Nazwa Firmy'.tr,
                                              labelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
                                              floatingLabelStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color),
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
                                              fillColor: Colors.transparent),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref),
                                        ),
                                        child: TextField(
                                          controller: _passwordController,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                          decoration: InputDecoration(
                                            labelText: 'Hasło'.tr,
                                            labelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color),
                                            floatingLabelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color),
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
                                          gradient: CustomBackgroundGradients
                                              .adGradient1(context, ref),
                                        ),
                                        child: TextField(
                                          controller: _password2Controller,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                          decoration: InputDecoration(
                                            labelText: 'Potwierdź hasło'.tr,
                                            labelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color),
                                            floatingLabelStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color),
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
                                                              fontSize: 10,
                                                              color: Theme.of(
                                                                      context)
                                                                  .iconTheme
                                                                  .color)),
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
                                                              fontSize: 10,
                                                              color: Theme.of(
                                                                      context)
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
                                            width: inputWidth /
                                                3, // Responsywna szerokość
                                            height:
                                                48, // Ustaw wysokość, żeby dopasować do standardowej wysokości ElevatedButton
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  30.0), // Dopasuj promień do przycisku
                                              gradient:
                                                  CustomBackgroundGradients
                                                      .adGradient1(context,
                                                          ref), // Twój gradient
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
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              ),
                                              child: Text('Zarejestruj'.tr,
                                                  style: AppTextStyles
                                                      .interRegular
                                                      .copyWith(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .iconTheme
                                                                  .color)),
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
        ),
      ),
    );
  }

  Future<void> _register(BuildContext context, WidgetRef ref) async {
    final registerUrl = URLs.proRegister;

    try {
      // Prepare form data
      final formData = FormData.fromMap({
        'username': _emailController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password2': _password2Controller.text,
        'accept_terms': ref
            .read(termsAcceptedProvider)
            .toString()
            .replaceFirst('t', 'T')
            .replaceFirst('f', 'F'),
        'accept_marketing': ref
            .read(marketingConsentProvider)
            .toString()
            .replaceFirst('t', 'T')
            .replaceFirst('f', 'F'),
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'company_name': _companyNameController.text,
        'representative_name': _representativeNameController.text,
        'nip': _nipController.text,
        'regon': _regonController.text,
        'business_type': _businessTypeController.text,
        'reg_country': _regCountryController.text,
        'reg_city': _regCityController.text,
        'reg_street': _regStreetController.text,
        'reg_street_number': _regStreetNumberController.text,
        'reg_postal_code': _regPostalCodeController.text,
        'office_country': _officeCountryController.text,
        'office_city': _officeCityController.text,
        'office_street': _officeStreetController.text,
        'office_street_number': _officeStreetNumberController.text,
        'office_postal_code': _officePostalCodeController.text,
      });

      // Add avatar and logo files if they exist
      final avatarData = ref.read(avatarProvider);
      if (avatarData != null) {
        formData.files.add(MapEntry(
          'avatar',
          MultipartFile.fromBytes(avatarData, filename: 'avatar.jpg'),
        ));
      }

      final logoData = ref.read(logoProvider);
      if (logoData != null) {
        formData.files.add(MapEntry(
          'company_logo',
          MultipartFile.fromBytes(logoData, filename: 'logo.jpg'),
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
