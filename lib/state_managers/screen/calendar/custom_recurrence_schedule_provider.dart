import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final customRecurrenceScheduleProvider =
    ChangeNotifierProvider((ref) => CustomRecurrenceScheduleProvider());

class CustomRecurrenceScheduleProvider extends ChangeNotifier {
  var _interval = 1;
  int get interval => _interval;
  set interval(int interval) {
    _interval = interval;
    notifyListeners();
  }

  var _endDate = DateTime.now();
  DateTime get endDate => _endDate;
  set endDate(DateTime endDate) {
    _endDate = endDate;
    notifyListeners();
  }

  var _hasEnd = false;
  bool get hasEnd => _hasEnd;
  set hasEnd(bool hasEnd) {
    _hasEnd = hasEnd;
    notifyListeners();
  }
}
