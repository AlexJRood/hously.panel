// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/utils/custom_error_handler.dart';
import 'package:hously_flutter/modules/login/components_mobile.dart';
import 'package:hously_flutter/modules/login/providers/login_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/modules/notification/notification_service.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';

import 'package:hously_flutter/utils/install_popup.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class LoginMobilePage extends ConsumerStatefulWidget {
  const LoginMobilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginMobilePage> createState() => _LoginMobilePageState();
}

class _LoginMobilePageState extends ConsumerState<LoginMobilePage> {
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
    final loginprovider = ref.watch(loginProvider);
    // Clamp to ensure padding stays within min/max range
    dynamicPadding = dynamicPadding.clamp(minPadding, maxPadding);

    return PopupListener(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios_sharp,
                            color: Colors.black),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                // Add vertical spacing dynamically

                Expanded(
                  flex: 20,
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
                              child: Form(
                                key: loginprovider.formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 50),
                                    Text(
                                      'Log in to Hously',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28),
                                    ),
                                    const SizedBox(height: 20),
                                    CustomTextField(
                                      controller: loginprovider.emailController,
                                      focusNode: loginprovider.emailFocusNode,
                                      label: 'Email',
                                      autofillHints: const [
                                        AutofillHints.email
                                      ],
                                      nextFocus:
                                          loginprovider.passwordFocusNode,
                                    ),
                                    const SizedBox(height: 8),
                                    CustomTextField(
                                      controller:
                                          loginprovider.passwordController,
                                      focusNode:
                                          loginprovider.passwordFocusNode,
                                      label: 'Password',
                                      autofillHints: const [
                                        AutofillHints.password
                                      ],
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        children: [
                                          const Spacer(),
                                          InkWell(
                                            onTap: () => ref
                                                .read(navigationService)
                                                .pushNamedScreen(
                                                    Routes.forgotpassword),
                                            child: const Text(
                                              "Forgot Password?",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12),
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
                                          onPressed: () => _login(context, ref,
                                              loginprovider.formKey),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff232323),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text('Login',
                                              style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 14)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    const DividerWithText(),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Push bottom section down dynamically when screen height > 1100
                if (screenHeight > 1100) ...[
                  const Spacer(flex: 3), // Push content upward
                ],

                if (screenHeight > 400) ...[
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GoogleFonts.inter(
                                  fontSize: 11, color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                ref
                                    .read(navigationService)
                                    .pushNamedReplacementScreen(
                                        Routes.register);
                              },
                              child: Text(
                                'Register now',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color:
                                      const Color.fromARGB(255, 104, 104, 104),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],


                
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(navigationService)
                                  .pushNamedReplacementScreen(Routes.leadsPanel);
                            },
                            child: Text('go to leads'),
                          ),
                        

                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _checkForToken(BuildContext context, WidgetRef ref) async {
    if (ApiServices.token != null) {
      // Usunięcie stron logowania i rejestracji z historii nawigacji
      // ref.read(navigationHistoryProvider.notifier)
      //     .removeSpecificPages(['/login', '/register']);
    }
  }

  Future<void> _login(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormState> formKey,
  ) async {
    final loginprovider = ref.watch(loginProvider);
    if (formKey.currentState!.validate()) {
      final response = await ApiServices.post(
        URLs.restAuthLogin,
        headers: {'Content-Type': 'application/json'},
        data: {
          'username': loginprovider.emailController.text,
          'password': loginprovider.passwordController.text
        },
      );

      if (response != null && response.statusCode == 201) {
        var data = response.data;
        var token = data['token'];
        print('token is $token');
        final secureStorage = SecureStorage();
        await secureStorage.saveToken(token);
        await ApiServices.init(ref);

        ref.read(navigationService).pushNamedReplacementScreen(Routes.homepage);
        final snackBar = Customsnackbar()
            .showSnackBar("Hurra!.".tr, 'Jesteś zalogowany'.tr, "success", () {
          _login(context, ref, formKey);
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        ref.watch(fcmTokenProvider);
      } else {
        final snackBar = Customsnackbar().showSnackBar(
            "Logowanie nie powiodło się".tr, 'Sprawdź swoje dane'.tr, "error",
            () {
          _login(context, ref, formKey);
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
