
import 'package:hously_flutter/enums/decline_meeting_enum.dart';
import 'package:hously_flutter/enums/event/repeat_enum.dart';
import 'package:hously_flutter/models/calendar/out_office_model.dart';

final defaultOutOffice = OutOfficeModel(
  id: '',
  title: 'Out of office',
  from: DateTime.now(),
  to: DateTime.now(),
  repeat: RepeatEnum.doesNotRepeat,
  autoCancel: true,
  declineMeeting: DeclineMeetingEnum.newMeetings,
  message: 'Declined because I am out of office.',
);
