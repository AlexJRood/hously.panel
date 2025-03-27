import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/calendar/enums/event/end_type_enum.dart';
import 'package:hously_flutter/modules/calendar/enums/event/frequencies_enum.dart';
import 'package:hously_flutter/modules/calendar/enums/event/monthly_option_enum.dart';

final customRecurrenceEventProvider =
    ChangeNotifierProvider((ref) => CustomRecurrenceEventProvider());

class CustomRecurrenceEventProvider extends ChangeNotifier {
  var _frequency = FrequenciesEnum.daily;
  FrequenciesEnum get frequency => _frequency;
  set frequency(FrequenciesEnum frequency) {
    _frequency = frequency;
    notifyListeners();
  }

  var _interval = 1;
  int get interval => _interval;
  set interval(int interval) {
    _interval = interval;
    notifyListeners();
  }

  final _selectedDays = <String>[];
  List<String> get selectedDays => _selectedDays;
  void addSelectedDay(String day) {
    if (!_selectedDays.contains(day)) {
      _selectedDays.add(day);
      notifyListeners();
    }
  }

  void removeSelectedDay(String day) {
    _selectedDays.remove(day);
    notifyListeners();
  }

  var _monthlyOption = MonthlyOptionEnum.dayBefore;
  MonthlyOptionEnum get monthlyOption => _monthlyOption;
  set monthlyOption(MonthlyOptionEnum monthlyOption) {
    _monthlyOption = monthlyOption;
    notifyListeners();
  }

  var _endDate = DateTime.now();
  DateTime get endDate => _endDate;
  set endDate(DateTime endDate) {
    _endDate = endDate;
    notifyListeners();
  }

  int? _occurrences;
  int? get occurrences => _occurrences;
  set occurrences(int? occurrences) {
    _occurrences = occurrences;
    notifyListeners();
  }

  var _endType = EndTypeEnum.never;
  EndTypeEnum get endType => _endType;
  set endType(EndTypeEnum endType) {
    _endType = endType;
    notifyListeners();
  }

  String generateRecurrenceRule() {
    var recurrenceRule = "FREQ=${_frequency.type}";

    if (_interval > 1) {
      recurrenceRule += ";INTERVAL=$_interval";
    }
    if (_frequency == FrequenciesEnum.weekly && _selectedDays.isNotEmpty) {
      recurrenceRule += ";BYDAY=${_selectedDays.join(",")}";
    }
    if (_frequency == FrequenciesEnum.monthly) {
      if (_monthlyOption == MonthlyOptionEnum.dayBefore) {
        final today = DateTime.now();
        int dayBefore = today.day - 1;
        recurrenceRule += ";BYMONTHDAY=$dayBefore";
      } else {
        recurrenceRule += ";BYDAY=2WE";
      }
    }
    if (_endType == EndTypeEnum.onDate) {
      recurrenceRule +=
          ";UNTIL=${_endDate.toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.')[0]}Z";
    } else if (_endType == EndTypeEnum.after && _occurrences != null) {
      recurrenceRule += ";COUNT=$_occurrences";
    }

    return recurrenceRule;
  }
}
