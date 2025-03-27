import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/utils/custom_error_handler.dart';
import 'package:hously_flutter/routing/navigation_history_provider.dart';
import 'package:hously_flutter/modules/login/components_pc.dart';
import 'package:hously_flutter/modules/login/providers/login_provider.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/modules/notification/notification_service.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/bars/sidebar.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class LoginPcPage extends ConsumerWidget {
  LoginPcPage({super.key});

  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 1200;
    final containerWidth = math.min(screenWidth * 0.9, 550).toDouble();
    final loginprovider = ref.watch(loginProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Stack(
          children: [
            const BackgroundImage(),
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
                                          LoginForm(
                                            formKey: loginprovider.formKey,
                                            containerWidth: containerWidth,
                                            isSmallScreen: isSmallScreen,
                                            emailController:
                                                loginprovider.emailController,
                                            passwordController: loginprovider
                                                .passwordController,
                                            onLogin: () => _login(context, ref,
                                                loginprovider.formKey),
                                            ref: ref,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Expanded(
                                  flex: 2, child: SizedBox(width: 4)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const AppBarLogo(),
          ],
        ),
      ),
    );
  }

  Future<void> _checkForToken(BuildContext context, WidgetRef ref) async {
    if (ApiServices.token != null) {
      // ref.read(navigationHistoryProvider.notifier).removeSpecificPages(['/login', '/register']);
    }
  }

  Future<void> _login(
      BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey) async {
    final loginprovider = ref.watch(loginProvider);
    if (formKey.currentState!.validate()) {
      final response = await ApiServices.post(
        URLs.restAuthLogin,
        headers: {'Content-Type': 'application/json'},
        data: {
          'username': loginprovider.emailController.text,
          'password': loginprovider.passwordController.text,
        },
      );

      if (response != null && response.statusCode == 201) {
        var data = response.data;
        var token = data['token'];
        print('token is $token');

        final secureStorage = SecureStorage();
        await secureStorage.saveToken(token);
        ApiServices.token = token;

        ref.read(authStateProvider.notifier).logIn(ref);
        ref.invalidate(userProvider);
        await ref.read(userProvider.future);
        await ApiServices.init(ref);

        final snackBar = Customsnackbar().showSnackBar(
          "Hurra!".tr,
          'Jesteś zalogowany'.tr,
          "success",
          () => _login(context, ref, formKey),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        ref.watch(fcmTokenProvider);

        await ref.read(userProvider.future).whenComplete(() {
          ref.read(navigationHistoryProvider.notifier).addPage(Routes.homepage);
          ref
              .read(navigationService)
              .pushNamedReplacementScreen(Routes.homepage);
        });
      } else {
        final snackBar = Customsnackbar().showSnackBar(
          "Login Failed",
          "Logowanie nie powiodło się. Sprawdź swoje dane logowania i spróbuj ponownie"
              .tr,
          "error",
          () => _login(context, ref, formKey),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}

class LoginForm extends StatelessWidget {
  final double containerWidth;
  final bool isSmallScreen;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final VoidCallback onLogin;
  final WidgetRef ref;
  final GlobalKey<FormState> formKey;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.containerWidth,
    required this.isSmallScreen,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      containerWidth: containerWidth,
      isSmallScreen: isSmallScreen,
      formContent: AutofillGroup(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              FormHeader(
                  isSmallScreen: isSmallScreen, title: 'Log in to Hously'.tr),
              const SizedBox(height: 12),
              SocialButtonsRow(context: context),
              const SizedBox(height: 10),
              const DividerWithText(),
              const SizedBox(height: 10),
              ValidatedTextField(
                autofillHints: const [AutofillHints.email],
                controller: emailController,
                label: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Email is required'.tr;
                  if (!GetUtils.isEmail(value))
                    return 'Invalid email address'.tr;
                  return null;
                },
              ),
              const SizedBox(height: 8),
              ValidatedTextField(
                autofillHints: const [AutofillHints.password],
                controller: passwordController,
                label: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Password is required'.tr;
                  if (value.length < 8)
                    return 'Password must be at least 8 characters long'.tr;
                  return null;
                },
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () => ref
                          .read(navigationService)
                          .pushNamedScreen(Routes.forgotpassword),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              PrimaryButton(text: 'Login'.tr, onPressed: onLogin),
              const SizedBox(height: 8),
              RegisterPrompt(ref: ref),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterPrompt extends StatelessWidget {
  final WidgetRef ref;

  const RegisterPrompt({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account? '.tr,
            style: const TextStyle(
                fontSize: 11,
                color: Colors.black,
                decoration: TextDecoration.none),
          ),
          TextButton(
            child: Text(
              'Register'.tr,
              style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black,
                  decoration: TextDecoration.underline),
            ),
            onPressed: () => ref
                .read(navigationService)
                .pushNamedReplacementScreen(Routes.register),
          ),
        ],
      ),
    );
  }
}
