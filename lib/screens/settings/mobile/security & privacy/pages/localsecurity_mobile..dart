import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_components.dart';
import 'package:hously_flutter/screens/settings/components/settings_button.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class LocalsecurityMobile extends ConsumerWidget {
  const LocalsecurityMobile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final TextEditingController _oldpin = TextEditingController();
    final TextEditingController _newpin = TextEditingController();
    final TextEditingController _confirmpin = TextEditingController();
    List<FocusNode> passwordfocusnode =
        List.generate(4, (index) => FocusNode());
    final theme = ref.watch(themeColorsProvider);

    return Scaffold(
      backgroundColor: theme.mobileBackground,
      body: Column(
        children: [
          // AppBar Section
          MobileSettingsAppbar(
            title: "Password",
            onPressed: () {
              Navigator.pop(context);
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
                      Text("Update Your Pin",
                          style: TextStyle(color: theme.whitewhiteblack)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Enter a passcode to securely verify access to your account.",
                          style: TextStyle(
                              color: theme.popupcontainertextcolor,
                              fontSize: 12)),
                      SizedBox(
                        height: 10,
                      ),
                      GradientTextFieldMobile(
                          isObscure: true,
                          focusNode: passwordfocusnode[0],
                          value: "",
                          reqNode: passwordfocusnode[1],
                          controller: _oldpin,
                          hintText: "Current Pin"),
                      GradientTextFieldMobile(
                          isObscure: true,
                          focusNode: passwordfocusnode[1],
                          value: "",
                          reqNode: passwordfocusnode[2],
                          controller: _newpin,
                          hintText: "New Pin"),
                      GradientTextFieldMobile(
                          isObscure: true,
                          focusNode: passwordfocusnode[2],
                          value: "",
                          reqNode: passwordfocusnode[3],
                          controller: _confirmpin,
                          hintText: "Confirm New Pin"),
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
    );
  }
}
