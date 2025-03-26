import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart'; // Import user_provider
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart'; // Import SecureStorage

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['email', 'profile', 'openid'],
  clientId:
      '749372972983-8k4sv4vqoo4pdaqk532hu52i1mv7tbn7.apps.googleusercontent.com',
);

Future<void> handleGoogleSignIn(BuildContext context, WidgetRef ref) async {
  try {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final response = await ApiServices.post(
        URLs.restAuthGoogle,
        data: {'access_token': googleAuth.accessToken},
      );

      if (response != null && response.statusCode == 200) {
        // Handle successful response, save token, etc.
        final data = json.decode(response.data);
        String token = data['key'];

        // Save token securely
        final secureStorage = SecureStorage();
        await secureStorage.saveToken(token);
        await ApiServices.init(ref);

        // Update user data in UserStateNotifier
        ref.read(userStateProvider.notifier).updateUserFromJson(data['user']);

        // Usuń stronę logowania z historii nawigacji i przejdź do ostatnio odwiedzonej strony
        final lastPage = ref.read(navigationHistoryProvider.notifier).lastPage;
        ref.read(navigationService).pushNamedReplacementScreen(Routes.homepage);
      } else {
        // Handle error response
        print('Failed to sign in: $response');
      }
    }
  } catch (error) {
    print(error);
  }
}
