import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageNotifier extends StateNotifier<Locale> {
  LanguageNotifier() : super(const Locale('pl')); // Default language is English

  String get code => state.languageCode;

  // Set language and persist it
  Future<void> setLanguage(String languageCode) async {
    final newLocale = Locale(languageCode);
    state = newLocale;
    Get.updateLocale(newLocale);
    print('Language changed to: $languageCode');
    await _saveLanguage(languageCode);
  }

  // Initialize language from SharedPreferences
  Future<void> initializeLanguage() async {
    final savedLanguage = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('selected_language') ?? 'en');
    setLanguage(savedLanguage); // Call setLanguage to update the state
  }

  // Save language preference to SharedPreferences
  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', languageCode);
  }

  void detectSystemLanguage() {
    final systemLocale = window.locale.languageCode; // 'en', 'pl', etc.
    if (systemLocale == 'pl') {
      setLanguage('pl');
    } else {
      setLanguage('en'); // Default to English if unsupported
    }
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, Locale>(
      (ref) => LanguageNotifier(),
);



// StateNotifier to manage the visibility state
class VisibilityNotifier extends StateNotifier<bool> {
  VisibilityNotifier() : super(false); // Initial state is hidden (false)

  // Toggle visibility
  void toggleVisibility() {
    state = !state;
    print('Visibility toggled: $state');
  }

  // Set visibility directly
  void setVisibility(bool value) {
    state = value;
    print('Visibility set to: $value');
  }
}

// Provider for VisibilityNotifier
final visibilityProvider = StateNotifierProvider<VisibilityNotifier, bool>(
      (ref) => VisibilityNotifier(),
);
