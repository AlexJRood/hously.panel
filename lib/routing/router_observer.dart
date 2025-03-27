import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hously_flutter/routing/strings_const.dart';

class RouterObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
  }
}

Future<void> setWebsiteTitle(String label, {bool hasPrefix = true}) {
  final newLabel = hasPrefix ? '${StringsConst.websiteTitle} | $label' : label;

  return Future.microtask(() => SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
          label: newLabel,
        ),
      ));
}
