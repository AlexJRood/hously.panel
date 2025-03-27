import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/calendar/data/out_office_data.dart';
import 'package:hously_flutter/modules/calendar/models/out_office_model.dart';

final outOfficeProvider = ChangeNotifierProvider((ref) => OutOfficeProvider());

class OutOfficeProvider extends ChangeNotifier {
  var _outOffice = defaultOutOffice;
  OutOfficeModel get outOffice => _outOffice;
  set outOffice(OutOfficeModel outOffice) {
    _outOffice = outOffice;
    notifyListeners();
  }
}
