import 'package:flutter_riverpod/flutter_riverpod.dart';



class SelectedIndexNotifierPc extends StateNotifier<int> {
  SelectedIndexNotifierPc() : super(0); // Initial index is 0

  // Method to update the selected index
  void updateIndex(int newIndex) {
    state = newIndex;
  }
}

// Create a StateNotifierProvider for the SelectedIndexNotifier
final selectedIndexProviderPC = StateNotifierProvider<SelectedIndexNotifierPc, int>(
  (ref) => SelectedIndexNotifierPc(),
);