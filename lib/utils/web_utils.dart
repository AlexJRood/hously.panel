// lib/utils/web_utils.dart
import 'dart:js' as js;
import 'dart:html' as html;

void hideAddressBar() {
  if (isMobileBrowser()) {
    js.context.callMethod('hideAddressBar');
  }
}

bool isMobileBrowser() {
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  return userAgent.contains('iphone') ||
      userAgent.contains('ipad') ||
      userAgent.contains('android');
}
