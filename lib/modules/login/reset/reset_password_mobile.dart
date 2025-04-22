// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/modules/login/components_mobile.dart';
import 'package:hously_flutter/modules/login/providers/reset_password_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
class ForgotPasswordMobilePage extends ConsumerStatefulWidget {
  const ForgotPasswordMobilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordMobilePage> createState() =>
      _ForgotPasswordMobilePageState();
}

class _ForgotPasswordMobilePageState
    extends ConsumerState<ForgotPasswordMobilePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);
    const double maxWidth = 1920;
    const double minWidth = 360;
    const double maxPadding = 100;
    const double minPadding = 10;

    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxPadding - minPadding) +
        minPadding;
    dynamicPadding = dynamicPadding.clamp(minPadding, maxPadding);

    return  SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              children: [
                if (screenHeight > 60) ...[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            ref.read(navigationService).beamPop();
                          },
                          icon: const Icon(Icons.arrow_back_ios_sharp,
                              color: Colors.black),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
                Expanded(
                  flex: 20,
                  child: Container(
                    width: screenWidth > 600 ? 400 : screenWidth * 0.9,
                    padding: EdgeInsets.symmetric(horizontal: dynamicPadding),
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            Text(
                              forgotPasswordState.isLinkSent
                                  ? 'Reset link sent'
                                  : 'Reset password',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                            const SizedBox(height: 20),
                            forgotPasswordState.isLinkSent
                                ? const LinkSentContent()
                                : const ResetForm(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (screenHeight > 400) ...[
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Know your password? ",
                              style: GoogleFonts.inter(
                                  fontSize: 11, color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                ref
                                    .read(navigationService)
                                    .pushNamedScreen(Routes.login);
                              },
                              child: Text(
                                'Log in',
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
                        const SizedBox(height: 5),
                      ],
                    ),
                  )
                ],
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
    );
  }
}

class ResetForm extends ConsumerWidget {
  const ResetForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);
    return Form(
      key: forgotPasswordState.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            controller: forgotPasswordState.emailController,
            focusNode: forgotPasswordState.emailFocusNode,
            label: 'Email',
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: forgotPasswordNotifier.sendResetLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff232323),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Send reset link on email',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 40),
          const DividerWithText(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class LinkSentContent extends ConsumerWidget {
  const LinkSentContent({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Please open the link we’ve sent to you on ${forgotPasswordState.emailController.text} in order to reset your password',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color.fromARGB(255, 97, 96, 96),
          ),
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          minHeight: 7,
          borderRadius: BorderRadius.circular(10),
          value: forgotPasswordState.progressValue,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'If you didn’t receive the email, you can resend it in ',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 97, 96, 96),
                ),
              ),
              TextSpan(
                text:
                    '${forgotPasswordState.initialSeconds - forgotPasswordState.remainingSeconds}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ),
              TextSpan(
                text: ' seconds',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 97, 96, 96),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (forgotPasswordState.remainingSeconds <
                  forgotPasswordState.initialSeconds) {
              } else {
                forgotPasswordNotifier.resetLinkState();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff232323),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              forgotPasswordState.remainingSeconds <
                      forgotPasswordState.initialSeconds
                  ? 'The email didn’t arrive? Resend it'
                  : 'Resend email',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
