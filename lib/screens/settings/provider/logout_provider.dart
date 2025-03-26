import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier to manage toggle state
class ToggleNotifier extends StateNotifier<bool> {
  ToggleNotifier() : super(false); // Initial state is false

  void toggle() {
    state = !state; // Toggle the value
  }
}

// Provider for toggle state
final toggleProviderlogout = StateNotifierProvider<ToggleNotifier, bool>((ref) {
  return ToggleNotifier();
});
