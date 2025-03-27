import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/calendar/enums/event/guest_permission_enum.dart';
import 'package:hously_flutter/modules/calendar/enums/event/repeat_enum.dart';
import 'package:hously_flutter/modules/calendar/enums/event/visibility_type_enum.dart';
import 'package:hously_flutter/modules/calendar/models/event_model.dart';
import 'package:hously_flutter/modules/calendar/models/guest_model.dart';
import 'package:hously_flutter/modules/calendar/models/offer_preview_model.dart';

final defaultEvent = EventModel(
  id: '1',
  title: '',
  from: DateTime.now(),
  to: DateTime.now(),
  repeat: RepeatEnum.doesNotRepeat,
  timeZone: '',
  location: '',
  onlineCallLink: '',
  reminders: const [],
  guests: const [
    Guest(
      id: '',
      emailAddress: 'youremail@gmail.com',
      isOrganizer: true,
      guestColor: Colors.blue,
      guestPermissions: [
        GuestPermissionsEnum.inviteOthers,
        GuestPermissionsEnum.modifyEvent,
        GuestPermissionsEnum.seeGuestList,
      ],
    )
  ],
  busy: false,
  visibility: VisibilityTypeEnum.defaultVisibility,
  description: '',
  offerLink: '',
  offerPreview: const OfferPreview(id: '', keyMetrics: '', mainPhotoUrl: ''),
);
