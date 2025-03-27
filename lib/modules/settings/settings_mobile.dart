import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_photo_card.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/modules/settings/provider/logout_provider.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/install_popup.dart';

class SettingsMobile extends ConsumerStatefulWidget {
  const SettingsMobile({super.key});

  @override
  ConsumerState<SettingsMobile> createState() => _SettingsMobileState();
}

class _SettingsMobileState extends ConsumerState<SettingsMobile> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    final userAsyncValue = ref.watch(userProvider);
    final isToggled = ref.watch(toggleProviderlogout);

    final navService = ref.read(navigationService);
    return PopupListener(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            gradient:
                CustomBackgroundGradients.getMainMenuBackground(context, ref),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  MobileSettingsAppbar(title: "Settings", onPressed: () {}),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const MobilePhotoCard(),
                              const SizedBox(height: 10),
                              TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(0),
                                  fillColor: theme.settingsMenutile,
                                  filled: true,
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  hintText: "Search",
                                  hintStyle:
                                      TextStyle(color: theme.mobileTextcolor),
                                  prefixIcon: SvgPicture.asset(
                                      AppIcons.moreVertical,
                                      color: theme.mobileTextcolor),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account Settings",
                                    style:
                                        TextStyle(color: theme.mobileTextcolor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Scrollable Settings List
                              Container(
                                decoration: BoxDecoration(
                                  color: theme.settingsMenutile,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("Profile",
                                          style: _tileTextStyle(theme)),
                                      trailing: TitleIcon(),
                                      onTap: () {
                                        navService.pushNamedScreen(
                                            Routes.settingsprofile);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Powiadomienia".tr,
                                          style: _tileTextStyle(theme)),
                                      trailing: TitleIcon(),
                                      onTap: () {
                                        navService.pushNamedScreen(
                                            Routes.settingsnotification);
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                          "Bezpieczeństwo i Prywatność".tr,
                                          style: _tileTextStyle(theme)),
                                      trailing: TitleIcon(),
                                      onTap: () {
                                        navService.pushNamedScreen(
                                            Routes.settingssecurity);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Payments",
                                          style: _tileTextStyle(theme)),
                                      trailing: TitleIcon(),
                                      onTap: () {
                                        navService.pushNamedScreen(
                                            Routes.settingspayments);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Język".tr,
                                          style: _tileTextStyle(theme)),
                                      trailing: TitleIcon(),
                                      onTap: () {
                                        navService.pushNamedScreen(
                                            Routes.settingslanguage);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Motyw".tr,
                                          style: _tileTextStyle(theme)),
                                      trailing: TitleIcon(),
                                      onTap: () {
                                        navService.pushNamedScreen(
                                            Routes.settingstheme);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Czat".tr,
                                          style: _tileTextStyle(theme)),
                                      trailing: TitleIcon(),
                                      onTap: () {
                                        navService.pushNamedScreen(
                                            Routes.settingschat);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Wsparcie".tr,
                                          style: _tileTextStyle(theme)),
                                      trailing: TitleIcon(),
                                      onTap: () {
                                        navService.pushNamedScreen(
                                            Routes.settingsupport);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Wyloguj się".tr,
                                          style: _tileTextStyle(theme,
                                              isLogout: true)),
                                      trailing: TitleIcon(),
                                      onTap: () {
                                        navService.pushNamedScreen(
                                            Routes.settinglogout);
                                        ref
                                            .read(toggleProviderlogout.notifier)
                                            .toggle();
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (isToggled == true) ...[
                GestureDetector(
                  onTap: () {
                    ref.read(toggleProviderlogout.notifier).toggle();
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(color: Colors.black.withOpacity(0.2)),
                  ),
                ),

                // Centered Logout Container
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: theme.mobileTextcolor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Logout",
                          style: TextStyle(
                              color: theme.whitewhiteblack, fontSize: 17),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Are you sure you want to logout?",
                          style: TextStyle(color: theme.textFieldColor),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Settingsbutton(
                                isPc: false,
                                buttonheight: 40,
                                onTap: () {},
                                text: "Logout",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: CustomElevatedButton(
                                  text: "Cancel",
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _tileTextStyle(theme, {bool isLogout = false}) {
    return TextStyle(
        color: theme.mobileTextcolor,
        fontWeight: FontWeight.normal,
        fontSize: 15);
  }
}

class TitleIcon extends ConsumerWidget {
  const TitleIcon({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Icon(
      Icons.arrow_forward_ios_outlined,
      color: theme.mobileTextcolor,
    );
  }
}
