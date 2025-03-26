import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/calendar/booking_form_data.dart';
import 'package:hously_flutter/models/calendar/booking_form_model.dart';

final addItemBookingProvider =
    ChangeNotifierProvider((ref) => AddItemBookingProvider());

class AddItemBookingProvider extends ChangeNotifier {
  BookingFormModel _bookingFormModel = defaultBookingFormValue;
  BookingFormModel get bookingFormModel => _bookingFormModel;
  set bookingFormModel(BookingFormModel bookingFormModel) {
    _bookingFormModel = bookingFormModel;
    notifyListeners();
  }

  void init(BookingFormModel bookingFormModel) {
    _bookingFormModel = bookingFormModel;
    notifyListeners();
  }
}
