// ignore_for_file: file_names

import 'package:flutter_riverpod/flutter_riverpod.dart';

// CurrencyNotifier to manage selected currency
class CurrencyNotifier extends StateNotifier<String> {
  CurrencyNotifier() : super('PLN'); // Default currency is 'PLN'

  void setCurrency(String currency) {
    state = currency;
  }
}

// Provider for CurrencyNotifier
final currencyProvider = StateNotifierProvider<CurrencyNotifier, String>((ref) {
  return CurrencyNotifier();
});
