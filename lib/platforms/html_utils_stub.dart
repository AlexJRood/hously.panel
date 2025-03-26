// html_utils_stub.dart
import 'dart:io' as io;

void removeLoader() {
  // Do nothing on non-web platforms
  print('younis mobile');
}

void updateUrl(String path) {
  // Stub implementation for non-web platforms
}

void requestFullScreen() {}

Future<bool> isMobileBrowser() async => false;

Future<void> invokeWebShare(String url) async {
  throw UnsupportedError('Sharing is not supported on this platform.');
}
Future<void> invokeWebShareFeed(String url) async {
  throw UnsupportedError('Sharing is not supported on this platform.');
}

String getCsrfTokenFromCookies() {
 return '';
}

Future<String> getDeviceType() async {
  String platformType = "unknown";

  if (io.Platform.isAndroid) {
    platformType = "android";
  } else if (io.Platform.isIOS) {
    platformType = "ios";
  }

  return platformType;
}
