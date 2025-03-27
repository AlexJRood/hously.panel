import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final yearlyCalendarProvider = ChangeNotifierProvider(
  (ref) => YearlyCalendarProvider(),
);

class YearlyCalendarProvider extends ChangeNotifier {
  int _year = DateTime.now().year;
  int get year => _year;
  set year(int year) {
    _year = year;
    notifyListeners();
  }
}
