// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/state_managers/services/notification_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart'; // Zaimportuj SecureStorage
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_logo.dart';
import 'package:hously_flutter/widgets/social_login_module.dart';
// Zaimportuj provider historii nawigacji

class LoginPcPop extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPcPop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _checkForToken(context, ref);

    double screenWidth = MediaQuery.of(context).size.width;
    double inputWidth = math.max(screenWidth * 0.33, 400);
    final theme = ref.watch(themeColorsProvider);
    return Stack(
      children: [
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.85),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Column(
          children: [
            const TopAppBarLogoRegisterPage(),
            Expanded(
              child: SizedBox(
                width: inputWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 60,
                    ),
                    Material(
                        color: Colors.transparent,
                        child: Text(
                            'Zaloguj się aby dokończyć dodwanie ogłoszenia'.tr,
                            style: AppTextStyles.interSemiBold18)),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: CustomBackgroundGradients.adGradient1(
                              context, ref)),
                      child: TextField(
                        autofillHints: const [AutofillHints.email],
                        controller: _emailController,
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Theme.of(context).iconTheme.color),
                          floatingLabelStyle: TextStyle(
                              color: Theme.of(context).iconTheme.color),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide:
                                  const BorderSide(color: AppColors.light)),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient:
                            CustomBackgroundGradients.adGradient1(context, ref),
                      ),
                      child: TextField(
                        autofillHints: const [AutofillHints.password],
                        controller: _passwordController,
                        style:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                        decoration: InputDecoration(
                          floatingLabelStyle: TextStyle(
                              color: Theme.of(context).iconTheme.color),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Theme.of(context).iconTheme.color),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide:
                                  const BorderSide(color: Colors.white54)),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            ref
                                .read(navigationService)
                                .pushNamedReplacementScreen(
                                  Routes.registerPop,
                                );
                          },
                          child: Text('Zarejestruj się'.tr,
                              style: AppTextStyles.interRegular
                                  .copyWith(fontSize: 16)),
                        ),
                        const Spacer(),
                        Container(
                          width: inputWidth / 3,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: CustomBackgroundGradients.adGradient1(
                                context, ref),
                          ),
                          child: ElevatedButton(
                            onPressed: () => _login(context, ref),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            child: Text('Login',
                                style: AppTextStyles.interRegular.copyWith(
                                    fontSize: 16,
                                    color: Theme.of(context).iconTheme.color)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SocialLogin(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _checkForToken(BuildContext context, WidgetRef ref) async {
    if (ApiServices.token != null) {
      // Usunięcie stron logowania i rejestracji z historii nawigacji
      print('token : ${ApiServices.token}');
      ref
          .read(navigationHistoryProvider.notifier)
          .removeSpecificPages(['/login', '/register']);

      // Przekierowanie na ostatnią stronę w historii nawigacji
      final lastPage = ref.read(navigationHistoryProvider.notifier).lastPage;
      ref.read(navigationService).pushNamedReplacementScreen(lastPage);
    }
  }

  Future<void> _login(BuildContext context, WidgetRef ref) async {
    final response = await ApiServices.post(
      URLs.restAuthLogin,
      headers: {'Content-Type': 'application/json'},
      data: {
        'username': _emailController.text,
        'password': _passwordController.text
      },
    );

    if (response != null && response.statusCode == 201) {
      var data = json.decode(response.data);
      var token = data['token'];
      final secureStorage = SecureStorage();
      await secureStorage.saveToken(token);
      await ApiServices.init(ref);

      // Usuń stronę logowania z historii nawigacji i przejdź do ostatnio odwiedzonej strony

      ref.read(navigationService).beamPop();

      final snackBar = Customsnackbar().showSnackBar(
          "Hurra!.".tr, 'Jesteś zalogowany'.tr, "success",
          () {
        _login(context, ref);
      });      
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ref.watch(fcmTokenProvider);
    } else {
      final errorSnackBar = Customsnackbar().showSnackBar(
        "Error",
        'Logowanie nie powiodło się. Sprawdź swoje dane logowania i spróbuj ponownie.'
            .tr,
        "error",
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      ;
    }
  }
}
