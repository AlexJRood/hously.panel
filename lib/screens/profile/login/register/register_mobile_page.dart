// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/screens/profile/login/login/components_mobile.dart';
import 'package:hously_flutter/state_managers/data/profile/login/social_login/apple_login.dart';
import 'package:hously_flutter/state_managers/data/profile/login/social_login/facebook_login.dart';
import 'package:hously_flutter/state_managers/data/profile/login/social_login/google_login.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';

import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:image_picker/image_picker.dart';

final avatarProvider = StateProvider<Uint8List?>((ref) => null);
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
final marketingConsentProvider = StateProvider<bool>((ref) => false);

class RegisterMobilePage extends ConsumerStatefulWidget {
  const RegisterMobilePage({super.key});

  @override
  ConsumerState<RegisterMobilePage> createState() => _RegisterMobilePageState();
}

Future<void> _pickAvatar(WidgetRef ref) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    final Uint8List avatarData = await pickedFile.readAsBytes();
    ref.read(avatarProvider.notifier).state = avatarData;
  }
}

class _RegisterMobilePageState extends ConsumerState<RegisterMobilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _phoneFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _confirmPasswordFocusNode;
  bool _agreeToTerms = false;
  bool _showImagePicker = false; // Add toggle for image picker screen

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    const double maxWidth = 1920;
    const double minWidth = 360;
    const double maxPadding = 100;
    const double minPadding = 10;

    // Dynamic padding calculation
    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxPadding - minPadding) +
        minPadding;

    // Clamp to ensure padding stays within min/max range
    dynamicPadding = dynamicPadding.clamp(minPadding, maxPadding);

    return PopupListener(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: [
                if (screenHeight > 80) ...[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (_showImagePicker) {
                              setState(() {
                                _showImagePicker = false; // Go back to form
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.arrow_back_ios_sharp,
                              color: Colors.black),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
                // Add vertical spacing dynamically
                Expanded(
                  flex: 24,
                  child: Container(
                    width: screenWidth > 600 ? 400 : screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: dynamicPadding),
                    child: Column(
                      children: [
                        Expanded(
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: SingleChildScrollView(
                              child: _showImagePicker
                                  ? BuildImagePicker(
                                      ref: ref,
                                      onPickAvatar: () => _pickAvatar(ref),
                                    )
                                  : BuildForm(
                                      formKey: _formKey,
                                      firstNameController: _firstNameController,
                                      lastNameController: _lastNameController,
                                      emailController: _emailController,
                                      phoneController: _phoneController,
                                      passwordController: _passwordController,
                                      confirmPasswordController:
                                          _confirmPasswordController,
                                      firstNameFocusNode: _firstNameFocusNode,
                                      lastNameFocusNode: _lastNameFocusNode,
                                      emailFocusNode: _emailFocusNode,
                                      phoneFocusNode: _phoneFocusNode,
                                      passwordFocusNode: _passwordFocusNode,
                                      confirmPasswordFocusNode:
                                          _confirmPasswordFocusNode,
                                      agreeToTerms: _agreeToTerms,
                                      onTermsChanged: (value) {
                                        setState(() {
                                          _agreeToTerms = value ?? false;
                                        });
                                      },
                                      onContinuePressed: _validateAndProceed,
                                      ref: ref,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //Push bottom section down dynamically when screen height > 1100
                if (screenHeight > 1100 && !_showImagePicker) ...[
                  const Spacer(flex: 3), // Push content upward
                ],

                if (screenHeight > 500 && _showImagePicker) ...[
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: SizedBox(
                        width: screenWidth > 600 ? 400 : screenWidth * 0.9,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => _register(context, ref, _formKey),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff232323),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Create Account',
                            style: GoogleFonts.inter(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox())
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validateAndProceed(
      BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _showImagePicker = true; // Show the image picker screen
      });
    } else {
      final snackBar = Customsnackbar().showSnackBar(
        "Validation Error",
        "Please fix the errors in the form",
        "error",
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _register(
      BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey) async {
    final registerUrl = URLs.register;

    try {
      // Prepare the form data
      final formData = FormData.fromMap({
        'username': _emailController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password2': _confirmPasswordController.text,
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
            "Registered successfully",
            "You are now logged in",
            "success",
            () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          );
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
            "Registration Failed",
            "Please try again",
            "error",
            () {
              _register(context, ref, _formKey);
            },
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = Customsnackbar().showSnackBar(
          "Error",
          "Registration error ${response}".tr,
          "error",
          () {
            _register(context, ref, _formKey);
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      // Catch Dio errors and display a message
      final snackBar = Customsnackbar().showSnackBar(
        "Error",
        "Registration error ${e}".tr,
        "error",
        () {
          _register(context, ref, _formKey);
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

class BuildForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode firstNameFocusNode;
  final FocusNode lastNameFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final bool agreeToTerms;
  final void Function(bool?) onTermsChanged;
  final void Function(BuildContext, WidgetRef, GlobalKey<FormState>)
      onContinuePressed;
  final WidgetRef ref;

  const BuildForm({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.firstNameFocusNode,
    required this.lastNameFocusNode,
    required this.emailFocusNode,
    required this.phoneFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.agreeToTerms,
    required this.onTermsChanged,
    required this.onContinuePressed,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Text(
            'Sign up to Hously',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: firstNameController,
            focusNode: firstNameFocusNode,
            label: 'First Name',
            autofillHints: const [AutofillHints.givenName],
            nextFocus: lastNameFocusNode,
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: lastNameController,
            focusNode: lastNameFocusNode,
            label: 'Last Name',
            autofillHints: const [AutofillHints.familyName],
            nextFocus: emailFocusNode,
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: emailController,
            focusNode: emailFocusNode,
            label: 'Email',
            autofillHints: const [AutofillHints.email],
            nextFocus: phoneFocusNode,
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: phoneController,
            focusNode: phoneFocusNode,
            label: 'Phone Number',
            autofillHints: const [AutofillHints.telephoneNumber],
            nextFocus: passwordFocusNode,
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            label: 'Password',
            autofillHints: const [AutofillHints.newPassword],
            obscureText: true,
            nextFocus: confirmPasswordFocusNode,
          ),
          const SizedBox(height: 8),
          CustomTextField(
            controller: confirmPasswordController,
            focusNode: confirmPasswordFocusNode,
            label: 'Confirm Password',
            autofillHints: const [AutofillHints.newPassword],
            obscureText: true,
            compareController: passwordController,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Checkbox(
                  value: agreeToTerms,
                  onChanged: onTermsChanged,
                ),
                Expanded(
                  child: Text(
                    'I agree with our TERMS OF SERVICE, PRIVACY POLICY and our default NOTIFICATION SETTINGS.',
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => onContinuePressed(context, ref, formKey),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff232323),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          const DividerWithText(),
          const SizedBox(height: 20),
          SocialButtonMobile(
            imagePath: 'assets/images/google.png',
            label: 'Continue with Google',
            onPressed: () {},
          ),
          const SizedBox(height: 7),
          SocialButtonMobile(
            imagePath: 'assets/images/apple.png',
            label: 'Continue with Apple',
            onPressed: () {},
          ),
          const SizedBox(height: 7),
          SocialButtonMobile(
            imagePath: 'assets/images/facebook.png',
            label: 'Continue with Facebook',
            onPressed: () {},
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Already have an account? ",
                style: GoogleFonts.inter(fontSize: 11, color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  ref
                      .read(navigationService)
                      .pushNamedReplacementScreen(Routes.login);
                },
                child: Text(
                  'Log In',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color.fromARGB(255, 104, 104, 104),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

class BuildImagePicker extends StatelessWidget {
  final WidgetRef ref;
  final VoidCallback onPickAvatar;

  const BuildImagePicker({
    super.key,
    required this.ref,
    required this.onPickAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final avatarBytes = ref.watch(avatarProvider);
    final theme = ref.watch(themeColorsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Text(
          'Sign up to Hously',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 28),
        ),
        const SizedBox(height: 40),
        Center(
          child: Text(
            'Add a photo with you',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: InkWell(
            onTap: onPickAvatar,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: theme.fillColor,
              backgroundImage:
                  avatarBytes != null ? MemoryImage(avatarBytes) : null,
              child: avatarBytes == null
                  ? SvgPicture.asset(
                      AppIcons.camera,
                      color: Theme.of(context).iconTheme.color,
                      height: 50,
                      width: 50,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
