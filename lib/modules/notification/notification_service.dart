import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/utils/firebase_options.dart';
import 'package:hously_flutter/modules/notification/model/device_model.dart';
import 'package:hously_flutter/modules/notification/model/notification_model.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/utils/platforms/html_utils_stub.dart'
    if (dart.library.html) 'package:hously_flutter/utils/platforms/html_utils_web.dart';

final notificationProvider =
    ChangeNotifierProvider((ref) => NotificationProvider());

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  Future<void> addDevices(DeviceModel notificationModel) async {
    try {
      final response = await ApiServices.post(
        URLs.fcmAddDevice,
        hasToken: true,
        data: notificationModel.toJson(),
      );
      if (response != null && response.statusCode == 200) {
        print('Device added successfully');
      } else {
        print('Device adding failed');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUserNotifications(WidgetRef ref) async {
    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.userNotifications,
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        print('Get user notification successfully');

        final responseBody = utf8.decode(response.data);
        final decodedResponse = jsonDecode(responseBody);

        final userNotificationResponse =
            UserNotificationResponse.fromJson(decodedResponse);

        _notifications = userNotificationResponse.results;
        notifyListeners();

        for (var notification in _notifications) {
          print(
              'Notification Title: ${notification.title}, Text: ${notification.text}');
        }
      } else {
        print('Get user notification failed');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> makeNotificationSeen(int notificationId) async {
    try {
      final response = await ApiServices.post(
        URLs.notificationsSeen('$notificationId'),
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        print('Notification seen successfully');
      } else {
        print('Notification seen failed');
      }
    } catch (e) {
      print(e);
    }
  }
}

final fcmTokenProvider =
    StateNotifierProvider<FCMTokenNotifier, String?>((ref) {
  return FCMTokenNotifier(ref);
});

class FCMTokenNotifier extends StateNotifier<String?> {
  FCMTokenNotifier(Ref ref) : super(null) {
    _initFCM(ref);
  }

  Future<void> _initFCM(dynamic ref) async {
    if (Firebase.apps.isEmpty) {
      print("Initializing Firebase...");
      await Firebase.initializeApp(options: firebaseDefaultOption);
    }

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      print('User declined notification permissions');
      return;
    }

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    String? token;
    while (token == null) {
      try {
        token = await FirebaseMessaging.instance.getToken(
          vapidKey:
              'BMhQMS7sCB-kBscb3uwS0CQy1vPKAT1NdQ9jl0uRMYgU0oHmy5AnU0Qe928pY6ZtlSF6hlasoEBy1QNwRl9Co7s',
        );
        if (token == null) {
          print('FCM token is null. Retrying in 5 seconds...');
          await Future.delayed(const Duration(seconds: 5));
        }
      } catch (e) {
        print('Error getting FCM token: $e. Retrying in 5 seconds...');
        await Future.delayed(const Duration(seconds: 5));
      }
    }

    state = token;
    print('FCM Token: $token');
    await registerDeviceToServer(token, ref);

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print('Token refreshed: $newToken');
      state = newToken;
      registerDeviceToServer(newToken, ref);
    });
  }

  Future<void> registerDeviceToServer(String token, dynamic ref) async {
    final userAsyncValue = ref.watch(userProvider);

    final deviceInfoPlugin = DeviceInfoPlugin();
    String deviceName = "Unknown Device";
    String platformType = "unknown";

    if (kIsWeb) {
      final webInfo = await deviceInfoPlugin.webBrowserInfo;
      deviceName = "${webInfo.browserName}";
      platformType = "web";
    } else {
      final phoneType = await getDeviceType();
      if (phoneType == 'android') {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceName = androidInfo.model;
        platformType = "android";
      } else if (phoneType == 'ios') {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceName = iosInfo.utsname.machine;
        platformType = "ios";
      }
    }
    final deviceInfo = {
      "registration_id": token,
      "type": platformType,
      "name": deviceName,
      "user": '${userAsyncValue.value?.userId}',
      "active": true,
      "device_id": token.substring(0, 60),
    };

    try {
      final response = await ApiServices.post(
        URLs.fcmAddDevice,
        data: deviceInfo,
        hasToken: true,
      );

      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        print('Device registered successfully.');
      } else {
        print(
            'Device registration failed. StatusCode: ${response?.statusCode} // Response: ${response?.data}');
      }
    } catch (e) {
      print('Error registering device: $e');
    }
  }
}
