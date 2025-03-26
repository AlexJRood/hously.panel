import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final popupTimerProvider = ChangeNotifierProvider(
  (ref) => PopupTimerProvider(),
);

class PopupTimerProvider extends ChangeNotifier {
  Duration _changedDuration = const Duration();
  Duration get changedDuration => _changedDuration;
  set changedDuration(Duration duration) {
    _changedDuration = duration;
    notifyListeners();
  }
}
