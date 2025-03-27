import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/utils/custom_error_handler.dart';
import 'package:intl/intl.dart';

class ProfileState {
  final Map<String, String> values;

  ProfileState({required this.values});

  ProfileState copyWith({Map<String, String>? values}) {
    return ProfileState(values: values ?? this.values);
  }
}

final profileProvider = StateProvider<ProfileState>((ref) {
  return ProfileState(values: {
    'firstName': '',
    'lastName': '',
    'email': '',
    'phoneNumber': '',
    'dateOfBirth': '',
    'facebookLink': '',
    'instagramLink': '',
    'whatsappNumber': '',
    'linkedinLink': '',
    'country': '',
    'gender': '',
  });
});

bool validatePersonalInfo(BuildContext context, WidgetRef ref) {
  // ignore: deprecated_member_use
  final profileState = ref.read(profileProvider.state);

  List<String> personalFields = [
    'firstName',
    'lastName',
    'email',
    'phoneNumber',
    'dateOfBirth',
    'country',
    'gender',
  ];

  for (var field in personalFields) {
    if (profileState.state.values[field]?.isEmpty ?? true) {
      final warningSnackbar = Customsnackbar().showSnackBar(
        "Warning",
        'Missing field: $field',
        "warning",
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(warningSnackbar);
      return false; // Validation fails, return false
    }
  }

  final successSnackbar = Customsnackbar().showSnackBar(
    "Success",
    'Successfully uploaded Personal information',
    "success",
    () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    },
  );
  ScaffoldMessenger.of(context).showSnackBar(successSnackbar);
  return true; // Validation succeeds, return true
}

bool validateSocialLinks(BuildContext context, WidgetRef ref) {
  final profileState = ref.read(profileProvider.state);

  List<String> socialFields = [
    'facebookLink',
    'instagramLink',
    'whatsappNumber',
    'linkedinLink',
  ];

  for (var field in socialFields) {
    if (profileState.state.values[field]?.isEmpty ?? true) {
      final warningSnackbar = Customsnackbar().showSnackBar(
        "Warning",
        'Missing field: $field',
        "warning",
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(warningSnackbar);
      return false; // Validation fails, return false
    }
  }

  final successSnackbar = Customsnackbar().showSnackBar(
    "Success",
    'Successfully uploaded Social links',
    "success",
    () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    },
  );
  ScaffoldMessenger.of(context).showSnackBar(successSnackbar);
  return true; // Validation succeeds, return true
}

// Profile StateNotifier to manage form data


class ProfileFormNotifier extends StateNotifier<ProfileFormState> {
  ProfileFormNotifier() : super(ProfileFormState());

  // Reset Fields
  void resetFields() {
    state = state.copyWith(
      selectedCountry: null,
      selectedDateOfBirth: null,
      selectedGender: null,
      selectedCountryCode: null,
    );
  }

  // Set Date of Birth
  void setDateOfBirth(DateTime? date) {
    state = state.copyWith(
      selectedDateOfBirth: date,
      selectedDate: formatDate(date),
    );
  }

  // Set Gender
  void setGender(String? value) {
    state = state.copyWith(selectedGender: value);
  }

  // Set Country
  void setCountry(String? value) {
    state = state.copyWith(selectedCountry: value);
  }

  // Set Country Code (when user types or selects country)
  void setCountryCode(CountryCode value) {
    state = state.copyWith(
      selectedCountryCode: value,
      countryCodeText: value.dialCode ?? "",
    );
    state.countryCodeController.text = value.dialCode ?? "";
  }

  // Handle Country Code Change
  void handleCountryCodeChange(List<Map<String, String>> countries) {
    final typedCode = state.countryCodeController.text;
    for (final country in countries) {
      if (country['dialCode'] == typedCode) {
        setCountryCode(CountryCode.fromCountryCode(country['flag']!));
        break;
      }
    }
  }

  // Format Date
  String? formatDate(DateTime? date) {
    if (date == null) return null;
    return DateFormat('yyyy-MM-dd').format(date);
  }
}

// State Model for Profile Form
class ProfileFormState {
  final String? selectedGender;
  final String? selectedCountry;
  final CountryCode? selectedCountryCode;
  final DateTime? selectedDateOfBirth;
  final String? selectedDate;
  final String? countryCodeText;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController dateOfBirthController;
  final TextEditingController facebookLinkController;
  final TextEditingController instagramLinkController;
  final TextEditingController whatsappNumberController;
  final TextEditingController linkedinLinkController;
  final TextEditingController countryController;
  final TextEditingController genderController;
  final TextEditingController countryCodeController;
  final List<FocusNode> profileFocusNodes;

  ProfileFormState({
    this.selectedGender,
    this.selectedCountry,
    this.selectedCountryCode,
    this.selectedDateOfBirth,
    this.selectedDate,
    this.countryCodeText,
    TextEditingController? firstName,
    TextEditingController? lastName,
    TextEditingController? email,
    TextEditingController? phoneNumber,
    TextEditingController? dateOfBirth,
    TextEditingController? facebookLink,
    TextEditingController? instagramLink,
    TextEditingController? whatsappNumber,
    TextEditingController? linkedinLink,
    TextEditingController? country,
    TextEditingController? gender,
    TextEditingController? countryCode,
    List<FocusNode>? focusNodes,
  })  : firstNameController = firstName ?? TextEditingController(),
        lastNameController = lastName ?? TextEditingController(),
        emailController = email ?? TextEditingController(),
        phoneNumberController = phoneNumber ?? TextEditingController(),
        dateOfBirthController = dateOfBirth ?? TextEditingController(),
        facebookLinkController = facebookLink ?? TextEditingController(),
        instagramLinkController = instagramLink ?? TextEditingController(),
        whatsappNumberController = whatsappNumber ?? TextEditingController(),
        linkedinLinkController = linkedinLink ?? TextEditingController(),
        countryController = country ?? TextEditingController(),
        genderController = gender ?? TextEditingController(),
        countryCodeController = countryCode ?? TextEditingController(text: "+48"),
        profileFocusNodes = focusNodes ?? List.generate(10, (index) => FocusNode());

  // CopyWith Method for State Updates
  ProfileFormState copyWith({
    String? selectedGender,
    String? selectedCountry,
    CountryCode? selectedCountryCode,
    DateTime? selectedDateOfBirth,
    String? selectedDate,
    String? countryCodeText,
    TextEditingController? firstName,
    TextEditingController? lastName,
    TextEditingController? email,
    TextEditingController? phoneNumber,
    TextEditingController? dateOfBirth,
    TextEditingController? facebookLink,
    TextEditingController? instagramLink,
    TextEditingController? whatsappNumber,
    TextEditingController? linkedinLink,
    TextEditingController? country,
    TextEditingController? gender,
    TextEditingController? countryCode,
    List<FocusNode>? focusNodes,
  }) {
    return ProfileFormState(
      selectedGender: selectedGender ?? this.selectedGender,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCountryCode: selectedCountryCode ?? this.selectedCountryCode,
      selectedDateOfBirth: selectedDateOfBirth ?? this.selectedDateOfBirth,
      selectedDate: selectedDate ?? this.selectedDate,
      countryCodeText: countryCodeText ?? this.countryCodeText,
      firstName: firstName ?? firstNameController,
      lastName: lastName ?? lastNameController,
      email: email ?? emailController,
      phoneNumber: phoneNumber ?? phoneNumberController,
      dateOfBirth: dateOfBirth ?? dateOfBirthController,
      facebookLink: facebookLink ?? facebookLinkController,
      instagramLink: instagramLink ?? instagramLinkController,
      whatsappNumber: whatsappNumber ?? whatsappNumberController,
      linkedinLink: linkedinLink ?? linkedinLinkController,
      country: country ?? countryController,
      gender: gender ?? genderController,
      countryCode: countryCode ?? countryCodeController,
      focusNodes: focusNodes ?? profileFocusNodes,
    );
  }
}

// Riverpod Provider for Profile Form
final profileFormProvider =
    StateNotifierProvider<ProfileFormNotifier, ProfileFormState>((ref) {
  return ProfileFormNotifier();
});
