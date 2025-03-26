import 'package:hously_flutter/models/calendar/booking_form_model.dart';
import 'package:uuid/uuid.dart';

final defaultBookingFormValue = BookingFormModel(
  id: const Uuid().v4(),
  fieldName: '',
  isRequired: false,
  isDeletable: true,
  isEditable: true,
);

final phoneNumberId = const Uuid().v4();
final phoneBookingFormField = BookingFormModel(
  id: phoneNumberId,
  fieldName: 'Phone number',
  isRequired: true,
  isDeletable: false,
  isEditable: false,
);
