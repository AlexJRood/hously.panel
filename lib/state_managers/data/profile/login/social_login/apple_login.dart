import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

Future<void> handleAppleSignIn(BuildContext context, WidgetRef ref) async {
  try {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final response = await ApiServices.post(
      URLs.restAuthApple,
      data: {'access_token': appleCredential.identityToken},
    );

    if (response != null && response.statusCode == 200) {
      final data = json.decode(response.data);
      String token = data['key'];

      final secureStorage = SecureStorage();
      await secureStorage.saveToken(token);
      await ApiServices.init(ref);

      ref.read(userStateProvider.notifier).updateUserFromJson(data['user']);

      ref.read(navigationService).pushNamedReplacementScreen(Routes.homepage);
    } else {
      print('Failed to sign in: ${response}');
    }
  } catch (error) {
    print(error);
  }
}
