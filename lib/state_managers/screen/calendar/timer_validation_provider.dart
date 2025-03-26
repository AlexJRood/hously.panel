import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerValidationProvider =
    ChangeNotifierProvider((ref) => TimerValidationProvider());

class TimerValidationProvider extends ChangeNotifier {
  String _fieldId = '';
  String get fieldId => _fieldId;
  set fieldId(String fieldId) {
    _fieldId = fieldId;
    Future.delayed(const Duration(milliseconds: 200), () => notifyListeners());
  }

  bool _timerValidation1 = false;
  bool get timerValidation1 => _timerValidation1;
  set timerValidation1(bool timerValidation1) {
    _timerValidation1 = timerValidation1;
  }

  bool _timerValidation2 = false;
  bool get timerValidation2 => _timerValidation2;
  set timerValidation2(bool timerValidation2) {
    _timerValidation2 = timerValidation2;
  }
}
