import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/utils/custom_error_handler.dart';

class SecuritySettings {
  Map<String, bool> settings;

  SecuritySettings({
    Map<String, bool>? initialSettings,
  }) : settings = initialSettings ??
            {
              'changepassword': false,
              'changepin': false,
              'removepin': false,
              'setupauthentication': false,
            };

  void toggleSetting(String key) {
    if (settings.containsKey(key)) {
      settings[key] = !settings[key]!;
    }
  }
}

class SecuritySettingsNotifier extends StateNotifier<SecuritySettings> {
  SecuritySettingsNotifier() : super(SecuritySettings());

  void toggleSetting(String key) {
    state.toggleSetting(key);
    state = SecuritySettings(initialSettings: Map.from(state.settings));
  }

  void resetSettings() {
    state = SecuritySettings();
  }
}

final securitySettingsProvider =
    StateNotifierProvider<SecuritySettingsNotifier, SecuritySettings>(
  (ref) => SecuritySettingsNotifier(),
);

class ChangepasswordProvider {
  final Map<String, String> values;

  ChangepasswordProvider({required this.values});

  ChangepasswordProvider copyWith({Map<String, String>? values}) {
    return ChangepasswordProvider(values: values ?? this.values);
  }
}

final changepasswordprovider = StateProvider<ChangepasswordProvider>((ref) {
  return ChangepasswordProvider(values: {
    'currentpassword': '',
    'newpassword': '',
    'confirmnewpassword': '',
  });
});

class ChangepinProvider {
  final Map<String, String> values;

  ChangepinProvider({required this.values});

  ChangepinProvider copyWith({Map<String, String>? values}) {
    return ChangepinProvider(values: values ?? this.values);
  }
}

final changepinprovider = StateProvider<ChangepinProvider>((ref) {
  return ChangepinProvider(values: {
    'currentpin': '',
    'newpin': '',
    'confirmnewpin': '',
  });
});

class RemovepinProvider {
  final Map<String, String> values;

  RemovepinProvider({required this.values});

  RemovepinProvider copyWith({Map<String, String>? values}) {
    return RemovepinProvider(values: values ?? this.values);
  }
}

final removepinprovider = StateProvider<RemovepinProvider>((ref) {
  return RemovepinProvider(values: {
    'removepin': '',
    
  });
});
Map<String, String> get fieldDisplayNames => {
      'currentpassword': 'Current Password',
      'newpassword': 'New Password',
      'confirmnewpassword': 'Confirm New Password',
      'currentpin': 'Current Pin',
      'newpin': 'New Pin',
      'confirmnewpin': 'Confirm New',
      'removepin': 'remove pin'
    };

bool validatechangepassword(BuildContext context, WidgetRef ref,
    List<String> changepasswordfields, StateProvider validatorprovider) {
  final validate = ref.read(validatorprovider.notifier);

  for (var field in changepasswordfields) {
    if (validate.state.values[field]?.isEmpty ?? true) {
      final displayName = fieldDisplayNames[field] ?? field;

      final warningSnackbar = Customsnackbar().showSnackBar(
        "Warning",
        'Missing field: $displayName',
        "warning",
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(warningSnackbar);
      return false; // Validation failed
    }
  }

  if (!areNewPasswordsMatching(context, ref)) {
    return false; // Passwords do not match
  }

  final succesSnackbar = Customsnackbar().showSnackBar(
    "Success",
    'Successfully changed password',
    "success",
    () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    },
  );

  ScaffoldMessenger.of(context).showSnackBar(succesSnackbar);

  return true; // Validation successful
}

bool areNewPasswordsMatching(BuildContext context, WidgetRef ref) {
  final profileState = ref.read(changepasswordprovider.notifier);

  final newPassword = profileState.state.values['newpassword'];
  final confirmNewPassword = profileState.state.values['confirmnewpassword'];

  if (newPassword != confirmNewPassword) {
    final warningSnackbar = Customsnackbar().showSnackBar(
      "Warning",
      'New password and confirmation password do not match.',
      "warning",
      () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(warningSnackbar);
    return false;
  }
  return true;
}
