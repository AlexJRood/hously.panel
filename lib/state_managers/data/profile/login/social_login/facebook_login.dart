import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';

Future<void> handleFacebookSignIn(BuildContext context, WidgetRef ref) async {
  try {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken? accessToken =
          result.accessToken; // Poprawione uzyskiwanie tokena

      if (accessToken != null) {
        final response = await ApiServices.post(
          URLs.restAuthFacebook,
          data: {'access_token': accessToken},
        );

        if (response != null && response.statusCode == 200) {
          final data = json.decode(response.data);
          String token = data['key'];

          final secureStorage = SecureStorage();
          await secureStorage.saveToken(token);
          await ApiServices.init(ref);

          ref.read(userStateProvider.notifier).updateUserFromJson(data['user']);

          ref
              .read(navigationService)
              .pushNamedReplacementScreen(Routes.homepage);
        } else {
          print('Failed to sign in: $response');
        }
      } else {
        print('Access token is null');
      }
    } else {
      print('Login failed: ${result.message}');
    }
  } catch (error) {
    print(error);
  }
}
