import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_components.dart';

import 'package:hously_flutter/screens/settings/components/security_screen_button.dart';
import 'package:hously_flutter/screens/settings/components/settings_button.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class TwoStepMobileScreen extends ConsumerWidget {
  const TwoStepMobileScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient:
              CustomBackgroundGradients.getMainMenuBackground(context, ref),
        ),
        child: Center(
          child: Column(
            children: [
              // AppBar Section
              MobileSettingsAppbar(
                title: "Two-Step Verivication",
                onPressed: () {
                  ref.read(navigationService).beamPop();
                },
              ),

              // Scrollable Fields Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Two-step verification",
                              style: TextStyle(color: theme.mobileTextcolor)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("Secure your account with two-step verification",
                              style: TextStyle(
                                  color: theme.mobileTextcolor, fontSize: 12)),
                          const SizedBox(
                            height: 10,
                          ),
                          AuthenticationButton(
                            isPc: false,
                            icon: Icons.key_sharp,
                            text: 'Create a new Password',
                            onPressed: () {
                              ref
                                  .read(navigationService)
                                  .pushNamedScreen(Routes.twostep);
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AuthenticationButton(
                            isPc: false,
                            icon: Icons.phone,
                            text: 'Phone number (SMS)',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Fixed Bottom Button Section
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: 'Confirm',
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TwostepPassword extends ConsumerWidget {
  const TwostepPassword({super.key});

  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final TextEditingController _passwordcontroller = TextEditingController();
    final TextEditingController _confirmpasswordcontroller =
        TextEditingController();
    List<FocusNode> passwordfocusnode =
        List.generate(3, (index) => FocusNode());
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient:
              CustomBackgroundGradients.getMainMenuBackground(context, ref),
        ),
        child: Center(
          child: Column(
            children: [
              // AppBar Section
              MobileSettingsAppbar(
                title: "Two-Step Verivication",
                onPressed: () {
                  ref.read(navigationService).beamPop();
                },
              ),

              // Scrollable Fields Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Two-step verificationd",
                              style: TextStyle(color: theme.mobileTextcolor)),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                              "This password will be asked when you log in an a new device.",
                              style: TextStyle(
                                  color: theme.mobileTextcolor, fontSize: 12)),
                          const SizedBox(
                            height: 10,
                          ),
                          GradientTextFieldMobile(
                              isObscure: true,
                              focusNode: passwordfocusnode[0],
                              value: "",
                              reqNode: passwordfocusnode[1],
                              controller: _passwordcontroller,
                              hintText: "New Password"),
                          GradientTextFieldMobile(
                              isObscure: true,
                              focusNode: passwordfocusnode[1],
                              value: "",
                              reqNode: passwordfocusnode[2],
                              controller: _confirmpasswordcontroller,
                              hintText: "Confirm Password"),
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
    );
  }
}
