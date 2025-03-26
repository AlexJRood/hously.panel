import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/profile/login/social_login/apple_login.dart';
import 'package:hously_flutter/state_managers/data/profile/login/social_login/facebook_login.dart';
import 'package:hously_flutter/state_managers/data/profile/login/social_login/google_login.dart';
import 'package:universal_io/io.dart'
    as uio; // Używamy uniwersalnego pakietu IO';

// ignore: must_be_immutable
class SocialLogin extends ConsumerWidget {
  SocialLogin({super.key});

  bool isApple = uio.Platform.isIOS || uio.Platform.isMacOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(),
        ElevatedButton(
          style: elevatedButtonStyleRounded10SocialLogin,
          onPressed: () => handleGoogleSignIn(context, ref),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: FaIcon(FontAwesomeIcons.google,
                color: Theme.of(context).iconTheme.color),
          ), // Logo Google
        ),
        const SizedBox(width: 5),
        if (isApple) ...[
          // Tylko dla iOS i macOS
          ElevatedButton(
            style: elevatedButtonStyleRounded10SocialLogin,
            onPressed: () => handleAppleSignIn(context, ref),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: FaIcon(FontAwesomeIcons.apple, color: AppColors.light),
            ), // Logo Apple
          ),
        ],
        const SizedBox(width: 5),
        ElevatedButton(
          style: elevatedButtonStyleRounded10SocialLogin,
          onPressed: () => handleFacebookSignIn(context, ref),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: FaIcon(FontAwesomeIcons.facebook,
                color: Theme.of(context).iconTheme.color),
          ), // Logo Facebook
        ),
        const Spacer(),
      ],
    );
  }
}
