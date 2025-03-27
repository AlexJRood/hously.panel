// html_utils_web.dart
import 'dart:html';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:js/js_util.dart';

void removeLoader() {
  print('younis web');
  window.onLoad.first.then((_) {
    final loader = document.getElementById('loading-screen');
    loader?.remove();
  });
}

void updateUrl(String path) {
  window.history.pushState(null, 'Form', path);
}

void requestFullScreen(){
  js.context.callMethod('requestFullScreen');
}

Future<void> invokeWebShare(String url) async {
  try {
    final shareData = {'title': 'Udostępnij ogłoszenie', 'url': url};
    await promiseToFuture(html.window.navigator.share(shareData));
  } catch (e) {
    throw Exception('Błąd podczas wywoływania web share: $e');
  }
}

Future<bool> isMobileBrowser() async {
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  return userAgent.contains('iphone') ||
      userAgent.contains('ipad') ||
      userAgent.contains('android');
}

Future<void> invokeWebShareFeed(String url) async {
  try {
    final result = await promiseToFuture(html.window.navigator.share({
      'title': 'Udostępnij ogłoszenie',
      'text': 'Sprawdź to ogłoszenie',
      'url': url,
    }));
    if (!result) {
      throw Exception('Udostępnianie nie powiodło się');
    }
  } catch (e) {
    debugPrint('Błąd podczas wywoływania web share: $e');
  }
}
String getCsrfTokenFromCookies() {
  var token = js.context.callMethod('getCsrfToken');
  return token ?? '';
}

String getDeviceType(){
  return 'web';
}