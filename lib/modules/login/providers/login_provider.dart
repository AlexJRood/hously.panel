import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/api_services/api_services.dart';

import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/routing/route_constant.dart';

final loginProvider = ChangeNotifierProvider<LoginNotifier>((ref) {
  return LoginNotifier(ref);
});

class LoginNotifier extends ChangeNotifier {
  final Ref ref;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginNotifier(this.ref);

  Future<void> checkForToken(BuildContext context) async {
    if (ApiServices.token != null) {
      // Remove login and register pages from history
      ref.read(navigationService).pushNamedReplacementScreen(Routes.homepage);
    }
  }
}
