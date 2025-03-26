// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/state_managers/services/notification_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart'; // Zaimportuj SecureStorage
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/social_login_module.dart';
import '../../../../widgets/side_menu/slide_rotate_menu.dart';



class LoginMobilePage extends ConsumerStatefulWidget {
  const LoginMobilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginMobilePage> createState() => _LoginMobilePageState();
}

class _LoginMobilePageState extends ConsumerState<LoginMobilePage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late FocusNode focusNode1, focusNode2;
  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    _checkForToken(context, ref);

    focusNode1.addListener(() {
      if (focusNode1.hasFocus) {
        print("FocusNode1 has focus");
      }
    });

    focusNode2.addListener(() {
      if (focusNode2.hasFocus) {
        print("FocusNode2 has focus");
      }
    });
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    double screenWidth = MediaQuery.of(context).size.width;
    double inputWidth = math.max(screenWidth * 0.33, 350);

    return PopupListener(
        child: SafeArea(
          child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
           menuKey: sideMenuKey,
            child: Container(
              decoration: BoxDecoration(
                gradient:
                    CustomBackgroundGradients.getMainMenuBackground(context, ref),
              ),
              child: Column(
                children: [
                   AppBarMobile(sideMenuKey: sideMenuKey,),
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
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                gradient: CustomBackgroundGradients.adGradient1(
                                    context, ref)),
                            child: TextField(
                              autofillHints: const [AutofillHints.email],
                              cursorColor: Theme.of(context).iconTheme.color,
                              controller: _emailController,
                              focusNode: focusNode1,
                                    onSubmitted: (_) {
                                      FocusScope.of(context)
                                          .requestFocus(focusNode1);
                                    },
                              style: TextStyle(
                                  color: Theme.of(context).iconTheme.color),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Theme.of(context).iconTheme.color),
                                floatingLabelStyle: TextStyle(
                                    color: Theme.of(context).iconTheme.color),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).iconTheme.color!)),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: CustomBackgroundGradients.adGradient1(
                                    context, ref)),
                            child: TextField(
                              focusNode: focusNode2,
                                    onSubmitted: (_) {FocusScope.of(context).requestFocus(focusNode2);},
                              autofillHints: const [AutofillHints.password],
                              cursorColor: Theme.of(context).iconTheme.color,
                              controller: _passwordController,
                              style: TextStyle(color: Theme.of(context).iconTheme.color),
                              decoration: InputDecoration(
                                floatingLabelStyle: TextStyle(color: Theme.of(context).iconTheme.color),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Theme.of(context).iconTheme.color),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Theme.of(context).iconTheme.color!)),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                  onPressed: () => ref
                                      .read(navigationService)
                                      .pushNamedReplacementScreen(Routes.register),
                                  child: Text('Zarejestruj się'.tr,
                                      style: AppTextStyles.interRegular.copyWith(
                                          fontSize: 16,
                                          color: Theme.of(context).iconTheme.color)),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: inputWidth / 3,
                                height: 48,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: CustomBackgroundGradients.adGradient1(
                                        context, ref)),
                                child: ElevatedButton(
                                  onPressed: () => _login(context, ref),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                  child: Text('Login',
                                      style: AppTextStyles.interRegular.copyWith(
                                          fontSize: 16,
                                          color:
                                              Theme.of(context).iconTheme.color)),
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
                  const BottomBarMobile(),
                ],
              ),
            ),
                ),
               ),
        ),
    );
  }

  Future<void> _checkForToken(BuildContext context, WidgetRef ref) async {
    if (ApiServices.token != null) {
      // Usunięcie stron logowania i rejestracji z historii nawigacji
      // ref.read(navigationHistoryProvider.notifier)
      //     .removeSpecificPages(['/login', '/register']);
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
      var data = response.data;
      var token = data['token'];
      print('token is $token');
      final secureStorage = SecureStorage();
      await secureStorage.saveToken(token);
      await ApiServices.init(ref);

      ref.read(navigationService).pushNamedReplacementScreen(Routes.homepage);
      final snackBar = Customsnackbar().showSnackBar(
                "Hurra!.".tr, 'Jesteś zalogowany'.tr, "success",
                () {
              _login(context, ref);
            });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ref.watch(fcmTokenProvider);

     
    } else {
      final snackBar = Customsnackbar().showSnackBar(
          "Logowanie nie powiodło się".tr, 'Sprawdź swoje dane'.tr, "error",
          () {
        _login(context, ref);
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
