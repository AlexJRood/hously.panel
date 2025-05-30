import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_settings_components.dart';
import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class PasswordChangeMobile extends ConsumerWidget {
  const PasswordChangeMobile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final TextEditingController _oldpasswordcontroller =
        TextEditingController();
    final TextEditingController _newpasswordcontroller =
        TextEditingController();
    final TextEditingController _confirmpasswordcontroller =
        TextEditingController();
    List<FocusNode> passwordfocusnode =
        List.generate(4, (index) => FocusNode());
    final theme = ref.watch(themeColorsProvider);

    return Scaffold(

      body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.getMainMenuBackground(
                    context, ref),
              ),
        child: Column(
          children: [
            // AppBar Section
            MobileSettingsAppbar(
              title: "Password",
              onPressed: () {
              ref.read(navigationService).beamPop();
              },
            ),
        
            // Scrollable Fields Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ScrollConfiguration(
                  behavior:
                      ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Update Your Pasword",
                            style: TextStyle(color: theme.mobileTextcolor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Enter a passcode to securely verify access to your account.",
                            style: TextStyle(
                                color: theme.mobileTextcolor, fontSize: 12)),
                        SizedBox(
                          height: 10,
                        ),
                        GradientTextFieldMobile(
                            isObscure: true,
                            focusNode: passwordfocusnode[0],
                            value: "",
                            reqNode: passwordfocusnode[1],
                            controller: _oldpasswordcontroller,
                            hintText: "Current Password"),
                        GradientTextFieldMobile(
                            isObscure: true,
                            focusNode: passwordfocusnode[1],
                            value: "",
                            reqNode: passwordfocusnode[2],
                            controller: _newpasswordcontroller,
                            hintText: "New Password"),
                        GradientTextFieldMobile(
                            isObscure: true,
                            focusNode: passwordfocusnode[2],
                            value: "",
                            reqNode: passwordfocusnode[3],
                            controller: _confirmpasswordcontroller,
                            hintText: "Confirm New Password"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        
            // Fixed Bottom Button Section
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
    );
  }
}
