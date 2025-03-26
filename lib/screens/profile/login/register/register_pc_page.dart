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
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_logo.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../widgets/side_menu/slide_rotate_menu.dart';
import '../../../../data/design/design.dart';

final avatarProvider = StateProvider<Uint8List?>((ref) => null);
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
final marketingConsentProvider = StateProvider<bool>((ref) => false);

class RegisterPcPage extends ConsumerStatefulWidget {
  const RegisterPcPage({Key? key}) : super(key: key);

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
  bool showImagePicker = false; // Toggle between form and image picker

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

  final sideMenuKey = GlobalKey<SideMenuState>();

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
    final formKey = GlobalKey<FormState>(); // Add Form Key
    final avatarBytes = ref.watch(avatarProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final inputWidth = math.min(screenWidth * 0.5, 400);
    final termsAccepted = ref.watch(termsAcceptedProvider);
    final marketingConsent = ref.watch(marketingConsentProvider);
    final theme = ref.watch(themeColorsProvider);
    final isSmallScreen = screenWidth < 1400; // Define breakpoint
    final horizontalPadding = isSmallScreen ? 16.0 : 24.0;
    final verticalPadding = isSmallScreen ? 16.0 : 40.0;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/registerbackground.png',
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Sidebar(
                  sideMenuKey: sideMenuKey,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TopAppBarLogoRegisterPage(),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: isSmallScreen ? 2 : 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 240.0, horizontal: 40.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            'HOUSLY.AI',
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: isSmallScreen ? 3 : 4,
                                  child: AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      transitionBuilder: (child, animation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                      child: showImagePicker
                                          ? _buildImagePicker(avatarBytes,
                                              screenHeight, context)
                                          : _buildForm(formKey, screenWidth)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context, String image) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen =
        screenWidth < 800; // Define breakpoint for small screens

    final buttonSize =
        isSmallScreen ? 62.0 : 72.0; // Adjust size for small screens
    final iconSize = isSmallScreen ? 45.0 : 60.0; // Adjust icon size
    final padding = isSmallScreen
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 8)
        : const EdgeInsets.symmetric(horizontal: 12, vertical: 12);

    return Container(
      constraints: BoxConstraints(maxWidth: buttonSize), // Limit button width
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Container(
          height: buttonSize,
          width: iconSize,
          child: Image.asset(
            image,
            fit: BoxFit.contain,
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: padding,
        ),
        label: const Text(''), // Keep the label empty as per the design
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
            child: Divider(
          color: Color(0xffE2E8F0),
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('lub'.tr),
          // or
        ),
        Expanded(child: Divider(color: Color(0xffE2E8F0))),
      ],
    );
  }

  Widget _buildValidatedTextField(
    BuildContext context,
    TextEditingController controller,
    String label,
    FocusNode currentFocus,
    FocusNode? nextFocus,
    String? Function(String?)? validator, {
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: currentFocus,
      onFieldSubmitted: (_) => nextFocus?.requestFocus(),
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            color: Color(0xff919191),
            fontWeight: FontWeight.w400,
            fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE2E8F0), width: 1),
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE2E8F0), width: 1.0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE2E8F0), width: 1.0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE2E8F0), width: 1.0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        contentPadding:
            EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Adjust padding
      ),
      validator: validator,
    );
  }

  @override
  Widget _buildImagePicker(
      Uint8List? avatarBytes, double screenHeight, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 800; // Breakpoint
    final containerWidth = isSmallScreen
        ? math.min(screenWidth * 0.9, 480).toDouble()
        : math.min(screenWidth * 0.7, 560).toDouble();
    final containerHeight = isSmallScreen
        ? math.min(screenHeight * 0.6, 400).toDouble()
        : math.min(screenHeight * 0.8, 600).toDouble();

    return Center(
      child: Container(
        height: containerHeight,
        width: containerWidth,
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 12 : 20,
          horizontal: isSmallScreen ? 16 : 24,
        ),
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
                fontSize: isSmallScreen ? 16 : 18,
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
                width: isSmallScreen ? 180 : 212,
                height: isSmallScreen ? 180 : 212,
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
                          radius: isSmallScreen ? 80 : 96,
                          backgroundImage: MemoryImage(avatarBytes),
                        ),
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildForm(GlobalKey<FormState> formKey, double screenWidth) {
    final isSmallScreen = screenWidth < 800; // Breakpoint for small screens
    final containerWidth = isSmallScreen
        ? math.min(screenWidth * 0.9, 480).toDouble()
        : math
            .min(screenWidth * 0.7, 560)
            .toDouble(); // Adjust width dynamically
    final termsAccepted = ref.watch(termsAcceptedProvider);

    return Center(
      child: Container(
        width: containerWidth,
        padding: EdgeInsets.symmetric(
          vertical: isSmallScreen ? 16 : 20,
          horizontal: isSmallScreen ? 12 : 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Sign up to Hously'.tr,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 24 : 28,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _buildSocialButton(
                        context, 'assets/images/google_button.png'),
                  ),
                  Expanded(
                      child: _buildSocialButton(
                          context, 'assets/images/apple_button.png')),
                  Expanded(
                    child: _buildSocialButton(
                        context, 'assets/images/facebook_button.png'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildDivider(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: _buildValidatedTextField(
                        context,
                        _firstNameController,
                        'Imię'.tr,
                        // 'First Name',
                        focusNode1,
                        focusNode2,
                        (value) => value == null || value.isEmpty
                            ? 'Imię jest wymagane'.tr
                            // ? 'First name is required'
                            : null),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: _buildValidatedTextField(
                        context,
                        _lastNameController,
                        'Last Name',
                        focusNode2,
                        focusNode3,
                        (value) => value == null || value.isEmpty
                            ? 'Last name is required'
                            : null),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildValidatedTextField(
                  context, _emailController, 'Email', focusNode3, focusNode4,
                  (value) {
                if (value == null || value.isEmpty) {
                  return 'Email jest wymagany'.tr;
                  // 'Email is required';
                } else if (!value.isEmail) {
                  return 'Niepoprawny adres email'.tr;
                  // 'Invalid email address';
                }
                return null;
              }),
              const SizedBox(height: 8),
              _buildValidatedTextField(
                  context,
                  _phoneNumberController,
                  'Numer Telefonu'.tr
                  // 'Phone Number'
                  ,
                  focusNode4,
                  focusNode5, (value) {
                if (value == null || value.isEmpty) {
                  return 'Numer telefonu jest wymagany'.tr;
                  // 'Phone number is required';
                } else if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value)) {
                  return 'Niepoprawny numer telefonu'.tr;
                  // 'Invalid phone number';
                }
                return null;
              }),
              const SizedBox(height: 8),
              _buildValidatedTextField(
                context,
                _passwordController,
                'Hasło'.tr, // Password
                focusNode5,
                focusNode6,
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hasło jest wymagane'.tr;
                    // Password is required
                  } else if (value.length < 8) {
                    return 'Hasło musi mieć co najmniej 8 znaków'.tr;
                    // Password must be at least 8 characters long
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 8),
              _buildValidatedTextField(
                context,
                _password2Controller,
                'Potwierdź hasło'.tr, // Confirm Password
                focusNode6,
                null,
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Potwierdź swoje hasło'.tr;
                    // Confirm your password
                  } else if (value != _passwordController.text) {
                    return 'Hasła nie pasują'.tr;
                    // Passwords do not match
                  }
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: termsAccepted,
                        onChanged: (bool? value) {
                          ref.read(termsAcceptedProvider.notifier).state =
                              value!;
                        },
                        visualDensity: VisualDensity.standard,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Color(0xff919191);
                            }
                            return Colors.transparent;
                          },
                        ),
                        side: BorderSide(
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
                            text: 'Zgadzam się z naszymi '.tr,
                            // 'I agree with our ',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Warunkami korzystania z usługi'.tr,
                                // 'Terms of Service',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              const TextSpan(
                                text: ', ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: 'Polityką prywatności'.tr,
                                // 'Privacy Policy',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(
                                text: ' oraz domyślnymi '.tr,
                                // ' and our default ',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: 'Ustawieniami powiadomień'.tr,
                                // 'Notification Settings',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle Notification Settings link tap
                                  },
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
                  const SizedBox(height: 8),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() && termsAccepted) {
                          setState(() {
                            showImagePicker = true; // Show the image picker
                          });
                        } else if (!termsAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Musisz zaakceptować warunki korzystania z usługi, aby kontynuować.'
                                      .tr
                                  // 'You must agree to the terms of service to continue.
                                  ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(42),
                        // Decreased button height
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Kontynuuj'.tr,
                        // 'Continue',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14, // Reduced font size
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Masz już konto?'.tr,
                          // 'Already have an account? ',
                          style: const TextStyle(
                            fontSize: 11,
                            // Reduced font size
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        TextButton(
                          child: Text(
                            'Zaloguj się'.tr,
                            // 'Log In',
                            style: const TextStyle(
                              fontSize: 11,
                              // Reduced font sizes
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
