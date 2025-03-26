// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/screens/profile/login/login/components_pc.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_logo.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:image_picker/image_picker.dart';

final avatarProvider = StateProvider<Uint8List?>((ref) => null);
final termsAcceptedProvider = StateProvider<bool>((ref) => false);

class RegisterPcPage extends ConsumerStatefulWidget {
  const RegisterPcPage({super.key});

  @override
  _RegisterPcPageState createState() => _RegisterPcPageState();
}

class _RegisterPcPageState extends ConsumerState<RegisterPcPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _password2Controller;
  late final TextEditingController _lastNameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _phoneNumberController;
  late FocusNode focusNode1,
      focusNode2,
      focusNode3,
      focusNode4,
      focusNode5,
      focusNode6;
  bool showImagePicker = false;

  final sideMenuKey = GlobalKey<SideMenuState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _password2Controller = TextEditingController();
    _lastNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
    focusNode6 = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _phoneNumberController.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 1000; // Match LoginPcPage breakpoint
    final containerWidth = math.min(screenWidth * 0.9, 550).toDouble();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Stack(
          children: [
            const BackgroundImage(), // Match LoginPcPage background
            Row(
              children: [
                Sidebar(sideMenuKey: sideMenuKey),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(child: SizedBox(width: 4)),
                              BrandHeader(isSmallScreen: isSmallScreen),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            transitionBuilder:
                                                (child, animation) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                            child: showImagePicker
                                                ? _buildImagePicker(
                                                    ref.watch(avatarProvider),
                                                    containerWidth,
                                                    context,
                                                  )
                                                : RegisterForm(
                                                    formKey: _formKey,
                                                    containerWidth:
                                                        containerWidth,
                                                    isSmallScreen:
                                                        isSmallScreen,
                                                    firstNameController:
                                                        _firstNameController,
                                                    lastNameController:
                                                        _lastNameController,
                                                    emailController:
                                                        _emailController,
                                                    phoneNumberController:
                                                        _phoneNumberController,
                                                    passwordController:
                                                        _passwordController,
                                                    password2Controller:
                                                        _password2Controller,
                                                    onContinue: () {
                                                      if (_formKey.currentState!
                                                              .validate() &&
                                                          ref.read(
                                                              termsAcceptedProvider)) {
                                                        setState(() {
                                                          showImagePicker =
                                                              true;
                                                        });
                                                      } else if (!ref.read(
                                                          termsAcceptedProvider)) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Musisz zaakceptować warunki korzystania z usługi, aby kontynuować.'
                                                                  .tr,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    onRegister: () =>
                                                        _register(context, ref),
                                                    ref: ref,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(flex: 2, child: SizedBox(width: 4)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const AppBarLogo(), // Match LoginPcPage app bar logo
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker(
      Uint8List? avatarBytes, double containerWidth, BuildContext context) {
    return Container(
      width: containerWidth,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add a photo with you'.tr,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xff5A5A5A),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () async {
              await _pickAvatar(ref);
            },
            child: Container(
              width: 212,
              height: 212,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: avatarBytes == null
                    ? Image.asset(
                        'assets/images/frame.png',
                        height: 48,
                        width: 48,
                        fit: BoxFit.contain,
                      )
                    : CircleAvatar(
                        radius: 96,
                        backgroundImage: MemoryImage(avatarBytes),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: const LinearGradient(
                colors: [Colors.black, Colors.grey], // Placeholder gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ElevatedButton(
              onPressed: () => _register(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Register'.tr,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

  Future<void> _register(BuildContext context, WidgetRef ref) async {
    final registerUrl = URLs.register;

    try {
      final formData = FormData.fromMap({
        'username': _emailController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password2': _password2Controller.text,
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
      });

      final avatarData = ref.read(avatarProvider);
      if (avatarData != null) {
        formData.files.add(MapEntry(
          'avatar',
          MultipartFile.fromBytes(avatarData, filename: 'avatar.jpg'),
        ));
      }

      final response = await ApiServices.post(registerUrl, formData: formData);

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        final data = response.data;

        if (data.containsKey('token')) {
          final token = data['token'];
          final secureStorage = SecureStorage();
          await secureStorage.saveToken(token);
          await ApiServices.init(token);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Registered successfully, you are logged in')),
          );

          ref
              .read(navigationHistoryProvider.notifier)
              .removeSpecificPages(['/login', '/register']);
          final lastPage =
              ref.read(navigationHistoryProvider.notifier).lastPage;
          Navigator.of(context).pushReplacementNamed(lastPage);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration failed')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration error: $response')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration error: $e')),
      );
    }
  }
}

class RegisterForm extends StatelessWidget {
  final double containerWidth;
  final bool isSmallScreen;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final TextEditingController password2Controller;
  final VoidCallback onContinue;
  final VoidCallback onRegister;
  final WidgetRef ref;
  final GlobalKey<FormState> formKey;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.containerWidth,
    required this.isSmallScreen,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.passwordController,
    required this.password2Controller,
    required this.onContinue,
    required this.onRegister,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final termsAccepted = ref.watch(termsAcceptedProvider);

    return FormContainer(
      containerWidth: containerWidth,
      isSmallScreen: isSmallScreen,
      formContent: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FormHeader(
                isSmallScreen: isSmallScreen, title: 'Sign up to Hously'.tr),
            const SizedBox(height: 12),
            SocialButtonsRow(context: context),
            const SizedBox(height: 10),
            const DividerWithText(),
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: ValidatedTextField(
                    controller: firstNameController,
                    label: 'First Name'.tr,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'First name is required'.tr;
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: ValidatedTextField(
                    controller: lastNameController,
                    label: 'Last Name'.tr,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Last name is required'.tr;
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ValidatedTextField(
              controller: emailController,
              label: 'Email'.tr,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Email is required'.tr;
                if (!GetUtils.isEmail(value)) return 'Invalid email address'.tr;
                return null;
              },
            ),
            const SizedBox(height: 8),
            ValidatedTextField(
              controller: phoneNumberController,
              label: 'Phone Number'.tr,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Phone number is required'.tr;
                return null;
              },
            ),
            const SizedBox(height: 8),
            ValidatedTextField(
              controller: passwordController,
              label: 'Password'.tr,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Password is required'.tr;
                if (value.length < 8)
                  return 'Password must be at least 8 characters long'.tr;
                return null;
              },
            ),
            const SizedBox(height: 8),
            ValidatedTextField(
              controller: password2Controller,
              label: 'Confirm Password'.tr,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'Confirm your password'.tr;
                if (value != passwordController.text)
                  return 'Passwords do not match'.tr;
                return null;
              },
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: termsAccepted,
                      onChanged: (bool? value) {
                        ref.read(termsAcceptedProvider.notifier).state = value!;
                      },
                      visualDensity: VisualDensity.standard,
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(0xff919191);
                          }
                          return Colors.transparent;
                        },
                      ),
                      side: const BorderSide(
                        color: Color(0xff919191),
                        width: 1.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'I agree with our '.tr,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Terms of Service'.tr,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            const TextSpan(
                              text: ', ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            TextSpan(
                              text: 'Privacy Policy'.tr,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            TextSpan(
                              text: ' and our default '.tr,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                            ),
                            TextSpan(
                              text: 'Notification Settings'.tr,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                            const TextSpan(
                              text: '.',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                PrimaryButton(text: 'Continue'.tr, onPressed: onContinue),
                const SizedBox(height: 8),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? '.tr,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Log In'.tr,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () => ref
                            .read(navigationService)
                            .pushNamedReplacementScreen(Routes.login),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
