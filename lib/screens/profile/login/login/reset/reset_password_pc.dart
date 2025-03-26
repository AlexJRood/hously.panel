import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/screens/profile/login/login/components_pc.dart';
import 'package:hously_flutter/screens/profile/login/login/providers/reset_password_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'dart:async';
import 'dart:math' as math;

import 'package:hously_flutter/widgets/sidebar/sidebar.dart';

class ResetPasswordPc extends ConsumerStatefulWidget {
  const ResetPasswordPc({super.key});

  @override
  ConsumerState<ResetPasswordPc> createState() => _ResetPasswordPcState();
}

class _ResetPasswordPcState extends ConsumerState<ResetPasswordPc> {
  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 1200;
    final containerWidth = math.min(screenWidth * 0.9, 550).toDouble();

    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);
    return Scaffold(
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
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 180),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(child: SizedBox(width: 4)),
                              const BrandHeader(isSmallScreen: true),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          forgotPasswordState.isLinkSent
                                              ? ResetLinkSent(
                                                  containerWidth:
                                                      containerWidth,
                                                  isSmallScreen: isSmallScreen,
                                                  email: forgotPasswordState
                                                      .emailController.text,
                                                  onResend: () {
                                                    forgotPasswordNotifier
                                                        .sendResetLink();
                                                  },
                                                )
                                              : ResetPasswordForm(
                                                  formKey: forgotPasswordState
                                                      .formKey,
                                                  containerWidth:
                                                      containerWidth,
                                                  isSmallScreen: isSmallScreen,
                                                  emailController:
                                                      forgotPasswordState
                                                          .emailController,
                                                  onSend: () {
                                                    forgotPasswordNotifier
                                                        .sendResetLink();
                                                  },
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Expanded(
                                  flex: 2, child:  SizedBox(width: 4)),
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
}

class ResetPasswordForm extends StatelessWidget {
  final double containerWidth;
  final bool isSmallScreen;
  final TextEditingController emailController;

  final GlobalKey<FormState> formKey;
  final VoidCallback onSend;

  const ResetPasswordForm({
    super.key,
    required this.formKey,
    required this.containerWidth,
    required this.isSmallScreen,
    required this.emailController,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return FormContainer(
      containerWidth: containerWidth,
      isSmallScreen: isSmallScreen,
      formContent: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FormHeader(isSmallScreen: isSmallScreen, title: 'Reset password'),
            const SizedBox(height: 12),
            ExtendedSocialButtonsRow(
              context: context,
              onGoogleTap: () => debugPrint('Google login'),
              onAppleTap: () => debugPrint('Apple login'),
              onFacebookTap: () => debugPrint('Facebook login'),
            ),
            const SizedBox(height: 10),
            const DividerWithText(),
            const SizedBox(height: 10),
            ValidatedTextField(
              autofillHints: const [AutofillHints.email],
              controller: emailController,
              label: 'Email',
              validator: (value) {
                if (value == null || value.isEmpty) return 'Email is required';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) return 'Invalid email address';
                return null;
              },
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: 'Send reset link on email',
              onPressed: onSend,
            ),
            const SizedBox(height: 8),
            const LoginPrompt(),
          ],
        ),
      ),
    );
  }
}

class ResetLinkSent extends ConsumerWidget {
  final double containerWidth;
  final bool isSmallScreen;
  final String email;
  final VoidCallback onResend;

  const ResetLinkSent({
    super.key,
    required this.containerWidth,
    required this.isSmallScreen,
    required this.email,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);

    return FormContainer(
      containerWidth: containerWidth,
      isSmallScreen: isSmallScreen,
      formContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FormHeader(
            isSmallScreen: isSmallScreen,
            title: 'Reset link sent',
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Please open the link we’ve sent to you on $email in order to reset your password',
              style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 97, 96, 96),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: LinearProgressIndicator(
              minHeight: 7,
              borderRadius: BorderRadius.circular(10),
              value: forgotPasswordState.progressValue,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text:
                        'If you didn’t receive the email, you can resend it in ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 97, 96, 96),
                    ),
                  ),
                  TextSpan(
                    text:
                        '${forgotPasswordState.initialSeconds - forgotPasswordState.remainingSeconds}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                  const TextSpan(
                    text: ' seconds',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 97, 96, 96),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            text: forgotPasswordState.remainingSeconds <
                    forgotPasswordState.initialSeconds
                ? 'The email didn’t arrive? Resend it'
                : 'Resend email',
            onPressed: () {
              if (forgotPasswordState.remainingSeconds <
                  forgotPasswordState.initialSeconds) {
              } else {
                forgotPasswordNotifier.sendResetLink();
              }
              onResend();
            },
          ),
          const SizedBox(height: 8),
          const LoginPrompt(),
        ],
      ),
    );
  }
}

class LoginPrompt extends ConsumerWidget {
  const LoginPrompt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Know your password? ',
            style: TextStyle(
              fontSize: 11,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          TextButton(
            child: const Text(
              'Log in',
              style: TextStyle(
                fontSize: 11,
                color: Colors.black,
                decoration: TextDecoration.underline,
              ),
            ),
            onPressed: () =>
                ref.read(navigationService).pushNamedScreen(Routes.login),
          ),
        ],
      ),
    );
  }
}
