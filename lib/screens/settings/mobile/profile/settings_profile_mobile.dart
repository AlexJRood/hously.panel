import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/screens/settings/components/gradient_dropdown.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_components.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_photocard_edit.dart';
import 'package:hously_flutter/screens/settings/components/settings_button.dart';
import 'package:hously_flutter/screens/settings/components/pro_container_mobile.dart';
import 'package:hously_flutter/screens/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/screens/settings/provider/profile_provider.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:intl/intl.dart';

class SettingsProfileMobile extends ConsumerStatefulWidget {
  const SettingsProfileMobile({super.key});

  @override
  ConsumerState<SettingsProfileMobile> createState() =>
      _SettingsProfileMobileState();
}

class _SettingsProfileMobileState extends ConsumerState<SettingsProfileMobile> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Simulate some heavy initialization work. Replace with your logic.
    await Future.delayed(const Duration(seconds: 1));
    // For example, initialize controllers with existing user data here

    // Once done, update the _loading flag.
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final profileform = ref.watch(profileFormProvider);
    final theme = ref.watch(themeColorsProvider);
    final userdata = ref.watch(userProvider).asData!.value;

    if (_loading) {
      return Scaffold(
        backgroundColor: theme.mobileBackground,
        body: Center(
          child: CircularProgressIndicator(
            color: theme.popupcontainertextcolor,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: theme.mobileBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            MobileSettingsAppbar(
                title: "Profile",
                onPressed: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      MobilePhotoCardEdit(
                        imageUrl: userdata!.avatarUrl!,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Edit Profile",
                            style:
                                TextStyle(color: theme.popupcontainertextcolor),
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
                            countryCodeFocus: FocusNode(),
                            countryCodeHint: "",
                            phoneNumberHint: "Phone",
                            phoneNumberController:
                                profileform.phoneNumberController,
                            phoneNumberFocus: profileform.profileFocusNodes[3],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: GradientDateDropdown(
                              value: "12/02/25",
                              isPc: false,
                              selectedDate: profileform.selectedDateOfBirth,
                              hintText: 'Date Of Birth',
                              onDateSelected: (date) {
                                ref
                                    .read(profileFormProvider.notifier)
                                    .setDateOfBirth(date);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
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
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: GradientDropdownCountry(
                              isPc: false,
                              value: "India",
                              hintText: 'Select Country',
                              countries: countries,
                              selectedCountry: profileform.selectedCountry,
                              onChanged: (value) {
                                ref
                                    .read(profileFormProvider.notifier)
                                    .setCountry(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ProContainer(
                            title: 'Odblokuj funkcje premium dzięki PRO'.tr,
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
                                    color: theme.popupcontainertextcolor),
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
                              controller: profileform.facebookLinkController,
                              hintText: "Facebook"),
                          GradientTextFieldMobile(
                              focusNode: profileform.profileFocusNodes[6],
                              value: "John",
                              reqNode: profileform.profileFocusNodes[7],
                              controller: profileform.instagramLinkController,
                              hintText: "Instagram"),
                          GradientTextFieldMobile(
                              focusNode: profileform.profileFocusNodes[7],
                              value: "John",
                              reqNode: profileform.profileFocusNodes[8],
                              controller: profileform.whatsappNumberController,
                              hintText: "Whatsapp"),
                          GradientTextFieldMobile(
                              focusNode: profileform.profileFocusNodes[8],
                              value: "john",
                              reqNode: profileform.profileFocusNodes[9],
                              controller: profileform.linkedinLinkController,
                              hintText: "Linkedin"),
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
  }
}
