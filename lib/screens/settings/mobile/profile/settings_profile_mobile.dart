import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/screens/settings/components/gradient_dropdown.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_components.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_photocard_edit.dart';
import 'package:hously_flutter/screens/settings/components/settings_button.dart';
import 'package:hously_flutter/screens/settings/components/pro_container_mobile.dart';

import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/screens/settings/provider/profile_provider.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class SettingsProfileMobile extends ConsumerStatefulWidget {
  const SettingsProfileMobile({super.key});

  @override
  ConsumerState<SettingsProfileMobile> createState() =>
      _SettingsProfileMobileState();
}

class _SettingsProfileMobileState extends ConsumerState<SettingsProfileMobile> {
  Future<bool> updateVariable() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final profileform = ref.watch(profileFormProvider);
    final theme = ref.watch(themeColorsProvider);
    final profileState = ref.read(profileProvider.notifier);
    final userState = ref.watch(userProvider);

    return FutureBuilder<bool>(
        future: updateVariable(),
        builder: (context, snapshot) {
          bool isLoaded = snapshot.data ?? false;
          if (!isLoaded) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: theme.popupcontainertextcolor,
                ),
              ),
            );
          }
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.getMainMenuBackground(
                    context, ref),
              ),
              child: Column(
                children: [
                  MobileSettingsAppbar(
                      title: "Profile",
                      onPressed: () {
                        ref.read(navigationService).beamPop();
                      }),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const MobilePhotoCardEdit(),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Edit Profile",
                                  style:
                                      TextStyle(color: theme.mobileTextcolor),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [
                                GradientTextFieldMobile(
                                    focusNode: profileform.profileFocusNodes[0],
                                    value: "John",
                                    reqNode: profileform.profileFocusNodes[1],
                                    controller: profileform.firstNameController,
                                    hintText: "First Name"),
                                GradientTextFieldMobile(
                                    focusNode: profileform.profileFocusNodes[1],
                                    value: "Doe",
                                    reqNode: profileform.profileFocusNodes[2],
                                    controller: profileform.lastNameController,
                                    hintText: "Last Name"),
                                GradientTextFieldMobile(
                                    focusNode: profileform.profileFocusNodes[2],
                                    value: "johndoe@gmail.com",
                                    reqNode: profileform.profileFocusNodes[3],
                                    controller: profileform.emailController,
                                    hintText: "Email"),
                                GradientPhoneNumberTwoFields(
                                  value: "+91 9562895536",
                                  isSuffix: true,
                                  countryCodeController:
                                      profileform.countryCodeController,
                                  countryCodeFocus:
                                      profileform.profileFocusNodes[3],
                                  countryCodeHint: "",
                                  phoneNumberHint: "Phone",
                                  phoneNumberController:
                                      profileform.phoneNumberController,
                                  phoneNumberFocus:
                                      profileform.profileFocusNodes[4],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: GradientDateDropdown(
                                    value: "12/02/25",
                                    isPc: false,
                                    selectedDate:
                                        profileform.selectedDateOfBirth,
                                    hintText: 'Date Of Birth',
                                    onDateSelected: (date) {
                                      ref
                                          .read(profileFormProvider.notifier)
                                          .setDateOfBirth(date);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: GradientDropdown(
                                    isPc: false,
                                    value: "Male",
                                    selectedItem: profileform.selectedGender,
                                    items: const ['Male', 'Female', 'Other'],
                                    onChanged: (value) {
                                      ref
                                          .read(profileFormProvider.notifier)
                                          .setGender(value);
                                    },
                                    hintText: 'Gender',
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: GradientDropdownCountry(
                                    isPc: false,
                                    value: "India",
                                    hintText: 'Select Country',
                                    countries: countries,
                                    selectedCountry:
                                        profileform.selectedCountry,
                                    onChanged: (value) {
                                      ref
                                          .read(profileFormProvider.notifier)
                                          .setCountry(value);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    Settingsbutton(
                                      isPc: true,
                                      buttonheight: 40,
                                      onTap: () {
                                        profileState.update((state) {
                                          return state.copyWith(
                                            values: {
                                              ...state.values,
                                              'firstName': profileform
                                                  .firstNameController.text,
                                              'lastName': profileform
                                                  .lastNameController.text,
                                              'email': profileform
                                                  .emailController.text,
                                              'phoneNumber': profileform
                                                  .phoneNumberController.text,
                                              'dateOfBirth':
                                                  profileform.selectedDate ??
                                                      '',
                                              'gender':
                                                  profileform.selectedGender ??
                                                      '',
                                              'country':
                                                  profileform.selectedCountry ??
                                                      '',
                                            },
                                          );
                                        });
                                        bool isPersonalInfoValid =
                                            validatePersonalInfo(context, ref);
                                        if (isPersonalInfoValid) {
                                          profileform.firstNameController
                                              .clear();
                                          profileform.lastNameController
                                              .clear();
                                          profileform.emailController.clear();
                                          profileform.phoneNumberController
                                              .clear();
                                          profileform.dateOfBirthController
                                              .clear();
                                          ref
                                              .read(
                                                  profileFormProvider.notifier)
                                              .resetFields();
                                        } else {}
                                        print(profileState.state.values);
                                      },
                                      text: 'Zapisz zmiany'.tr,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                ProContainer(
                                  title:
                                      'Odblokuj funkcje premium dzięki PRO'.tr,
                                  subtitle:
                                      'Uzyskaj dostęp do ekskluzywnych treści i funkcji zaprojektowanych, aby pomóc Ci robić więcej, szybciej'
                                          .tr,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Linki społecznościowe".tr,
                                      style: TextStyle(
                                          color: theme.mobileTextcolor),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                GradientTextFieldMobile(
                                    focusNode: profileform.profileFocusNodes[5],
                                    value: "John",
                                    reqNode: profileform.profileFocusNodes[6],
                                    controller:
                                        profileform.facebookLinkController,
                                    hintText: "Facebook"),
                                GradientTextFieldMobile(
                                    focusNode: profileform.profileFocusNodes[6],
                                    value: "John",
                                    reqNode: profileform.profileFocusNodes[7],
                                    controller:
                                        profileform.instagramLinkController,
                                    hintText: "Instagram"),
                                GradientTextFieldMobile(
                                    focusNode: profileform.profileFocusNodes[7],
                                    value: "John",
                                    reqNode: profileform.profileFocusNodes[8],
                                    controller:
                                        profileform.whatsappNumberController,
                                    hintText: "Whatsapp"),
                                GradientTextFieldMobile(
                                    focusNode: profileform.profileFocusNodes[8],
                                    value: "john",
                                    reqNode: profileform.profileFocusNodes[9],
                                    controller:
                                        profileform.linkedinLinkController,
                                    hintText: "Linkedin"),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    Settingsbutton(
                                      isPc: true,
                                      buttonheight: 40,
                                      onTap: () {
                                        profileState.update((state) {
                                          return state.copyWith(
                                            values: {
                                              ...state.values,
                                              'facebookLink': profileform
                                                  .facebookLinkController.text,
                                              'instagramLink': profileform
                                                  .instagramLinkController.text,
                                              'whatsappNumber': profileform
                                                  .whatsappNumberController
                                                  .text,
                                              'linkedinLink': profileform
                                                  .linkedinLinkController.text,
                                            },
                                          );
                                        });
                                        validateSocialLinks(context, ref);
                                        print(profileState.state.values);
                                      },
                                      text: 'Zapisz zmiany'.tr,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Settingsbutton(
                                          isPc: false,
                                          buttonheight: 50,
                                          onTap: () {},
                                          text: 'Wyłącz konto'.tr),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Settingsbutton(
                                        isPc: false,
                                        buttonheight: 50,
                                        onTap: () {},
                                        text: 'Usuń konto'.tr,
                                        isborder: true,
                                        backgroundcolor: false,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
