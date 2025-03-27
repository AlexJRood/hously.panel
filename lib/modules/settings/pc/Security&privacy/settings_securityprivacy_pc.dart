import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/settings/provider/security_providers.dart';

import 'package:hously_flutter/modules/settings/components/settings_button.dart';

import 'package:hously_flutter/modules/settings/components/pc/components/settings_tiles.dart';
import 'package:hously_flutter/modules/settings/components/deviceinfo_widget.dart';
import 'package:hously_flutter/modules/settings/components/pc/security%20components%20pc/popup_container.dart';
import 'package:hously_flutter/modules/settings/components/pc/security%20components%20pc/popup_textfield.dart';
import 'package:hously_flutter/modules/settings/components/security_screen_button.dart';

import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/modules/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class SecurityPrivacyScreenPc extends ConsumerStatefulWidget {
  const SecurityPrivacyScreenPc({
    super.key,
  });

  @override
  ConsumerState<SecurityPrivacyScreenPc> createState() =>
      _SecurityPrivacyScreenPcState();
}

class _SecurityPrivacyScreenPcState
    extends ConsumerState<SecurityPrivacyScreenPc> {
  final TextEditingController currentPasswordcontroller =
      TextEditingController();
  final TextEditingController newPasswordcontroller = TextEditingController();
  final TextEditingController confirmNewpasswordcontroller =
      TextEditingController();
  final TextEditingController currentpincontroller = TextEditingController();
  final TextEditingController newPincontroller = TextEditingController();
  final TextEditingController confirmnewPincontroller = TextEditingController();
  final TextEditingController removepincontroller = TextEditingController();
  final TextEditingController instagramLinkController = TextEditingController();
  final TextEditingController whatsappNumberController =
      TextEditingController();
  final TextEditingController linkedinLinkController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final TextEditingController genderController = TextEditingController();
  List<FocusNode> securityfocusNodes =
      List.generate(14, (index) => FocusNode());
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    currentPasswordcontroller.dispose();
    newPasswordcontroller.dispose();
    confirmNewpasswordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final securitySettings = ref.watch(securitySettingsProvider);
    final changepasword = ref.watch(changepasswordprovider.notifier);
    final changepin = ref.watch(changepinprovider.notifier);
    final removepin = ref.watch(removepinprovider.notifier);
    final theme = ref.watch(themeColorsProvider);
    return GestureDetector(
      onTap: () {
        ref.read(securitySettingsProvider.notifier).resetSettings();
        currentPasswordcontroller.clear();
        newPasswordcontroller.clear();
        confirmNewpasswordcontroller.clear();
        currentpincontroller.clear();
        newPincontroller.clear();
        confirmnewPincontroller.clear();
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingText(text: 'Password'),
              const SizedBox(
                height: 15,
              ),
              if (securitySettings.settings['changepassword']!)
                PopupContainer(
                  onCancel: () {
                    ref
                        .read(securitySettingsProvider.notifier)
                        .toggleSetting('changepassword');
                    currentPasswordcontroller.clear();
                    newPasswordcontroller.clear();
                    confirmNewpasswordcontroller.clear();
                  },
                  onConfirm: () {
                    changepasword.update((state) {
                      return state.copyWith(
                        values: {
                          ...state.values,
                          'currentpassword': currentPasswordcontroller.text,
                          'newpassword': newPasswordcontroller.text,
                          'confirmnewpassword':
                              confirmNewpasswordcontroller.text,
                        },
                      );
                    });
                    bool isValid = validatechangepassword(
                        context,
                        ref,
                        [
                          'currentpassword',
                          'newpassword',
                          'confirmnewpassword',
                        ],
                        changepasswordprovider);

                    if (isValid) {
                      ref
                          .read(securitySettingsProvider.notifier)
                          .toggleSetting('changepassword');
                      currentPasswordcontroller.clear();
                      newPasswordcontroller.clear();
                      confirmNewpasswordcontroller.clear();
                    } else {}
                  },
                  widgets: [
                    PopupTextfield(
                        focusNode: securityfocusNodes[0],
                        reqNode: securityfocusNodes[1],
                        controller: currentPasswordcontroller,
                        hintText: 'Current Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    PopupTextfield(
                        focusNode: securityfocusNodes[1],
                        reqNode: securityfocusNodes[2],
                        controller: newPasswordcontroller,
                        hintText: 'New Password'),
                    const SizedBox(
                      height: 10,
                    ),
                    PopupTextfield(
                        focusNode: securityfocusNodes[2],
                        reqNode: securityfocusNodes[3],
                        controller: confirmNewpasswordcontroller,
                        hintText: 'Confirm New Password'),
                  ],
                  text: 'Zaktualizuj swoje hasło'.tr,
                  subtext:
                      'Wprowadź kod dostępu, aby bezpiecznie zweryfikować dostęp do swojego konta'
                          .tr,
                )
              else
                Settingsbutton(
                    isPc: true,
                    buttonheight: 40,
                    onTap: () {
                      ref
                          .read(securitySettingsProvider.notifier)
                          .toggleSetting('changepassword');
                    },
                    text: 'Zmień hasło'.tr),
              const SizedBox(
                height: 30,
              ),
              HeadingText(text: 'Lokalne zabezpieczenia'.tr),
              const SizedBox(
                height: 15,
              ),
              SubtitleText(
                  text:
                      'Wprowadź PIN, aby bezpiecznie zweryfikować dostęp do swojego konta'
                          .tr),
              const SizedBox(
                height: 15,
              ),
              if (securitySettings.settings['changepin']!) ...[
                PopupContainer(
                  onCancel: () {
                    ref
                        .read(securitySettingsProvider.notifier)
                        .toggleSetting('changepin');
                    currentpincontroller.clear();
                    newPincontroller.clear();
                    confirmnewPincontroller.clear();
                  },
                  onConfirm: () {
                    changepin.update((state) {
                      return state.copyWith(
                        values: {
                          ...state.values,
                          'currentpin': currentpincontroller.text,
                          'newpin': newPincontroller.text,
                          'confirmnewpin': confirmnewPincontroller.text,
                        },
                      );
                    });
                    bool isValid = validatechangepassword(
                      context,
                      ref,
                      [
                        'currentpin',
                        'newpin',
                        'confirmnewpin',
                      ],
                      changepinprovider,
                    );

                    if (isValid) {
                      ref
                          .read(securitySettingsProvider.notifier)
                          .toggleSetting('changepin');
                      currentpincontroller.clear();
                      newPincontroller.clear();
                      confirmnewPincontroller.clear();
                    } else {}
                  },
                  widgets: [
                    PopupTextfield(
                        focusNode: securityfocusNodes[4],
                        reqNode: securityfocusNodes[5],
                        controller: currentpincontroller,
                        hintText: 'Current pin'),
                    const SizedBox(
                      height: 10,
                    ),
                    PopupTextfield(
                        focusNode: securityfocusNodes[5],
                        reqNode: securityfocusNodes[6],
                        controller: newPincontroller,
                        hintText: 'New pin'),
                    const SizedBox(
                      height: 10,
                    ),
                    PopupTextfield(
                        focusNode: securityfocusNodes[6],
                        reqNode: securityfocusNodes[7],
                        controller: confirmnewPincontroller,
                        hintText: 'Confirm New Pin'),
                  ],
                  text: 'Zaktualizuj swój PIN'.tr,
                  subtext:
                      'Wprowadź nowy PIN, aby bezpiecznie zaktualizować dostęp do swojego konta'
                          .tr,
                )
              ],
              if (securitySettings.settings['removepin']!) ...[
                PopupContainer(
                  onCancel: () {
                    ref
                        .read(securitySettingsProvider.notifier)
                        .toggleSetting('removepin');
                    removepincontroller.clear();
                  },
                  onConfirm: () {
                    removepin.update((state) {
                      return state.copyWith(
                        values: {
                          ...state.values,
                          'removepin': removepincontroller.text,
                        },
                      );
                    });
                    bool isValid = validatechangepassword(
                      context,
                      ref,
                      [
                        'removepin',
                      ],
                      removepinprovider,
                    );

                    if (isValid) {
                      ref
                          .read(securitySettingsProvider.notifier)
                          .toggleSetting('removepin');
                      removepincontroller.clear();
                    } else {}
                  },
                  widgets: [
                    PopupTextfield(
                        focusNode: securityfocusNodes[4],
                        reqNode: securityfocusNodes[5],
                        controller: removepincontroller,
                        hintText: 'Current pin'),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                  text: 'Usuń swój PIN'.tr,
                  subtext: 'Wprowadź swój aktualny PIN, aby usunąć'.tr,
                ),
              ],
              if (!securitySettings.settings['removepin']! &&
                  !securitySettings.settings['changepin']!) ...[
                Row(
                  children: [
                    Settingsbutton(
                        isPc: true,
                        buttonheight: 40,
                        onTap: () {
                          ref
                              .read(securitySettingsProvider.notifier)
                              .toggleSetting('changepin');
                        },
                        text: 'Zmień swój PIN'.tr),
                    const SizedBox(
                      width: 5,
                    ),
                    Settingsbutton(
                      isPc: true,
                      buttonheight: 40,
                      onTap: () {
                        ref
                            .read(securitySettingsProvider.notifier)
                            .toggleSetting('removepin');
                      },
                      text: 'Usuń PIN'.tr,
                      isborder: true,
                      backgroundcolor: false,
                    ),
                    const Spacer()
                  ],
                ),
              ],
              const SizedBox(
                height: 30,
              ),
              HeadingText(text: 'Logowanie za pomocą kodu QR'.tr),
              const SizedBox(
                height: 15,
              ),
              SubtitleText(
                  text:
                      'Wygeneruj kod QR, aby bezpiecznie zalogować się na swoje konto na innym urządzeniu'
                          .tr),
              const SizedBox(
                height: 15,
              ),
              Settingsbutton(
                  isPc: true,
                  buttonheight: 40,
                  onTap: () {},
                  text: 'Wygeneruj kod QR'.tr),
              const SizedBox(
                height: 30,
              ),
              HeadingText(text: 'Uwierzytelnianie wieloskładnikowe'.tr),
              const SizedBox(
                height: 15,
              ),
              SubtitleText(
                  text:
                      'Zabezpiecz swoje konto za pomocą weryfikacji dwuetapowej'
                          .tr),
              const SizedBox(
                height: 15,
              ),
              if (securitySettings.settings['setupauthentication']!)
                PopupContainer(
                  isbuttonvisible: false,
                  onCancel: () {
                    ref
                        .read(securitySettingsProvider.notifier)
                        .toggleSetting('setupauthentication');
                  },
                  onConfirm: () {},
                  widgets: [
                    AuthenticationButton(
                      isPc: false,
                      icon: Icons.key_sharp,
                      text: 'Create a new Password',
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthenticationButton(
                      icon: Icons.phone,
                      text: 'Phone number (SMS)',
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                  text: 'Weryfikacja dwuetapowa'.tr,
                  subtext:
                      'Zabezpiecz swoje konto za pomocą weryfikacji dwuetapowej'
                          .tr,
                )
              else
                Settingsbutton(
                    isPc: true,
                    buttonheight: 40,
                    onTap: () {
                      ref
                          .read(securitySettingsProvider.notifier)
                          .toggleSetting('setupauthentication');
                    },
                    text: 'Skonfiguruj uwierzytelnianie'.tr),
              const SizedBox(
                height: 30,
              ),
              HeadingText(text: 'Aktywne sesje'.tr),
              const SizedBox(
                height: 15,
              ),
              SubtitleText(
                  text:
                      'Oto wszystkie urządzenia, które są obecnie zalogowane. Możesz wylogować się z każdego z nich indywidualnie lub ze wszystkich innych urządzeń'
                          .tr),
              const SizedBox(
                height: 15,
              ),
              HeadingText(text: 'To urządzenie'.tr),
              const SizedBox(
                height: 15,
              ),
              DeviceInfoWidget(
                ismac: true,
                deviceName: 'Mac Book',
                locationAndDate: 'Chisinau, Moldova · 06/08/3024',
                onPressed: () {},
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(color: theme.themeTextColor.withOpacity(0.5)),
              const SizedBox(
                height: 15,
              ),
              HeadingText(text: 'Aktywne urządzenia'.tr),
              const SizedBox(
                height: 15,
              ),
              // First Active Device
              DeviceInfoWidget(
                deviceName: 'iPhone 12 Pro',
                locationAndDate: 'Chisinau, Moldova · 06/08/3024',
                onPressed: () {},
              ),

              const SizedBox(
                height: 15,
              ),
              // Second Active Device
              DeviceInfoWidget(
                deviceName: 'iPhone 12 Pro',
                locationAndDate: 'Chisinau, Moldova · 06/08/3024',
                onPressed: () {},
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(color: theme.themeTextColor.withOpacity(0.5)),
              const SizedBox(
                height: 25,
              ),
              HeadingText(
                  text: 'Wyloguj się ze wszystkich znanych urządzeń'.tr),
              const SizedBox(
                height: 15,
              ),
              SubtitleText(
                  text:
                      'Będziesz musiał ponownie zalogować się na wszystkie wylogowane urządzenia'
                          .tr),
              const SizedBox(
                height: 15,
              ),
              Settingsbutton(
                isPc: true,
                buttonheight: 40,
                onTap: () {},
                text: 'Wyloguj się ze wszystkich znanych urządzeń'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
