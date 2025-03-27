import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/widgets/language/values.dart';
import 'package:hously_flutter/modules/settings/components/gradient_dropdown.dart';
import 'package:hously_flutter/modules/settings/components/mobile/mobile_settings_components.dart';
import 'package:hously_flutter/modules/settings/provider/profile_provider.dart';

import 'package:hously_flutter/modules/settings/components/pro_container_mobile.dart';
import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/modules/settings/components/security_screen_button.dart';

import 'package:hously_flutter/modules/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:intl/intl.dart';

class ProfileScreenPc extends ConsumerStatefulWidget {
  const ProfileScreenPc({
    super.key,
  });

  @override
  ConsumerState<ProfileScreenPc> createState() => _ProfileScreenPcState();
}

bool _loading = true;

class _ProfileScreenPcState extends ConsumerState<ProfileScreenPc> {
  Future<bool> updateVariable() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.read(profileProvider.notifier);
    final theme = ref.watch(themeColorsProvider);
    final profileform = ref.watch(profileFormProvider);

    return FutureBuilder<bool>(
        future: updateVariable(),
        builder: (context, snapshot) {
          bool isLoaded = snapshot.data ?? false;
          if (!isLoaded) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingText(
                            text: 'Mój Profil'.tr,
                          ),
                          const PhotoSelector(
                            imageUrl: 'assets/images/image.png',
                          ),
                          Settingsbutton(
                              isPc: true,
                              buttonheight: 35,
                              onTap: () {},
                              text: 'Upload new photo'.tr)
                        ],
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            ProContainer(
                              title: 'Odblokuj funkcje premium dzięki PRO'.tr,
                              subtitle:
                                  'Uzyskaj dostęp do ekskluzywnych treści i funkcji zaprojektowanych, aby pomóc Ci robić więcej, szybciej'
                                      .tr,
                            ),
                            const SizedBox(height: 15)
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: HeadingText(text: 'Informacje osobiste'.tr)),
                      const Spacer(),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 135),
                        child: Settingsbutton(
                          isPc: true,
                          buttonheight: 40,
                          onTap: () {
                            profileState.update((state) {
                              return state.copyWith(
                                values: {
                                  ...state.values,
                                  'firstName':
                                      profileform.firstNameController.text,
                                  'lastName':
                                      profileform.lastNameController.text,
                                  'email': profileform.emailController.text,
                                  'phoneNumber':
                                      profileform.phoneNumberController.text,
                                  'dateOfBirth': profileform.selectedDate ?? '',
                                  'gender': profileform.selectedGender ?? '',
                                  'country': profileform.selectedCountry ?? '',
                                },
                              );
                            });
                            bool isPersonalInfoValid =
                                validatePersonalInfo(context, ref);
                            if (isPersonalInfoValid) {
                              profileform.firstNameController.clear();
                              profileform.lastNameController.clear();
                              profileform.emailController.clear();
                              profileform.phoneNumberController.clear();
                              profileform.dateOfBirthController.clear();
                              ref
                                  .read(profileFormProvider.notifier)
                                  .resetFields();
                            } else {}
                            print(profileState.state.values);
                          },
                          text: 'Zapisz zmiany'.tr,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GradientTextField(
                        focusNode: profileform.profileFocusNodes[0],
                        reqNode: profileform.profileFocusNodes[1],
                        controller: profileform.firstNameController,
                        hintText: 'First Name',
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: GradientTextField(
                        focusNode: profileform.profileFocusNodes[1],
                        reqNode: profileform.profileFocusNodes[2],
                        controller: profileform.lastNameController,
                        hintText: 'Last Name',
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: GradientTextField(
                        focusNode: profileform.profileFocusNodes[2],
                        reqNode: profileform.profileFocusNodes[3],
                        controller: profileform.emailController,
                        hintText: 'Email',
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GradientPhoneNumberTwoFields(
                          value: "",
                          isSuffix: false,
                          countryCodeController:
                              profileform.countryCodeController,
                          countryCodeFocus: profileform.profileFocusNodes[3],
                          countryCodeHint: "",
                          phoneNumberHint: "Phone",
                          phoneNumberController:
                              profileform.phoneNumberController,
                          phoneNumberFocus: profileform.profileFocusNodes[4],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GradientDateDropdown(
                          value: "",
                          isPc: true,
                          selectedDate: profileform.selectedDateOfBirth,
                          hintText: 'Date Of Birth',
                          onDateSelected: (date) {
                            setState(() {
                              ref
                                  .read(profileFormProvider.notifier)
                                  .setDateOfBirth(date);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: GradientDropdown(
                        isPc: true,
                        value: "",
                        selectedItem: profileform.selectedGender,
                        items: const ['Male', 'Female', 'Other'],
                        onChanged: (value) {
                          ref
                              .read(profileFormProvider.notifier)
                              .setGender(value);
                        },
                        hintText: 'Gender',
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GradientDropdownCountry(
                          isPc: true,
                          value: "",
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
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      HeadingText(text: 'Linki społecznościowe'.tr),
                      const Spacer(),
                      Settingsbutton(
                        isPc: true,
                        buttonheight: 40,
                        onTap: () {
                          profileState.update((state) {
                            return state.copyWith(
                              values: {
                                ...state.values,
                                'facebookLink':
                                    profileform.facebookLinkController.text,
                                'instagramLink':
                                    profileform.instagramLinkController.text,
                                'whatsappNumber':
                                    profileform.whatsappNumberController.text,
                                'linkedinLink':
                                    profileform.linkedinLinkController.text,
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
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GradientTextField(
                              focusNode: profileform.profileFocusNodes[5],
                              reqNode: profileform.profileFocusNodes[6],
                              controller: profileform.facebookLinkController,
                              hintText: 'Facebook')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GradientTextField(
                              focusNode: profileform.profileFocusNodes[6],
                              reqNode: profileform.profileFocusNodes[7],
                              controller: profileform.instagramLinkController,
                              hintText: 'Instagram')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GradientTextField(
                              focusNode: profileform.profileFocusNodes[7],
                              reqNode: profileform.profileFocusNodes[8],
                              controller: profileform.whatsappNumberController,
                              hintText: 'Whatsapp')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GradientTextField(
                              focusNode: profileform.profileFocusNodes[8],
                              reqNode: profileform.profileFocusNodes[9],
                              controller: profileform.linkedinLinkController,
                              hintText: 'Linkedin')),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadingText(text: 'Usunięcie konta'.tr),
                              const SizedBox(
                                height: 15,
                              ),
                              SubtitleText(
                                text:
                                    'Jeśli wyłączysz swoje konto, możesz je ponownie aktywować w dowolnym momencie'
                                        .tr,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Expanded(
                        child: NotificationWidget(
                          imageUrl: 'assets/images/image.png',
                          title: 'New Post: Your Dream Home Awaits',
                          subtitle:
                              'Explore our latest listings and find the perfect place to call home. Start your journey today!',
                          timeString: '1h ago',
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Settingsbutton(
                        isPc: true,
                        buttonheight: 40,
                        onTap: () {},
                        text: 'Wyłącz konto'.tr,
                      ),
                      const SizedBox(width: 5),
                      Settingsbutton(
                        isPc: true,
                        backgroundcolor: false,
                        isborder: true,
                        buttonheight: 40,
                        onTap: () {},
                        text: 'Usuń konto'.tr,
                      ),
                      Spacer(),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
