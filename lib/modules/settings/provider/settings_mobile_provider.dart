import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to manage selected index in settings
class SelectedIndexNotifierMobile extends StateNotifier<int> {
  SelectedIndexNotifierMobile() : super(-1);

  void setIndex(int index) {
    state = index;
  }
}

final selectedIndexProvidermobile =
    StateNotifierProvider<SelectedIndexNotifierMobile, int>((ref) {
  return SelectedIndexNotifierMobile();
});
