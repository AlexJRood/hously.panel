import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoolStateNotifier extends StateNotifier<bool> {
  BoolStateNotifier() : super(false);

  void toggle() {
    state = !state;
  }

  // Function to set the boolean value directly
  void setState(bool newState) {
    state = newState;
  }
}

final isClickprovider = StateNotifierProvider<BoolStateNotifier, bool>((ref) {
  return BoolStateNotifier();
});


final toggleProvider = StateProvider<bool>((ref) => false);

void toggleBoolean(WidgetRef ref) {
  final currentValue = ref.read(toggleProvider.notifier).state;
  ref.read(toggleProvider.notifier).state = !currentValue; // Toggle the value
}
