import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/calendar/event_data.dart';
import 'package:hously_flutter/enums/event/guest_permission_enum.dart';
import 'package:hously_flutter/enums/event/notification_period_enum.dart';
import 'package:hously_flutter/models/calendar/event_model.dart';
import 'package:hously_flutter/models/calendar/guest_model.dart';
import 'package:hously_flutter/models/calendar/reminder_model.dart';

final popupCalendarProvider = ChangeNotifierProvider(
  (ref) => PopupCalendarProvider(),
);

class PopupCalendarProvider extends ChangeNotifier {
  EventModel _event = defaultEvent;
  EventModel get event => _event;
  set event(EventModel event) {
    _event = event;
    notifyListeners();
  }

  bool _hasModify = false;
  bool get hasModify => _hasModify;
  set hasModify(bool hasModify) {
    _hasModify = hasModify;
    notifyListeners();
  }

  bool _hasInvite = true;
  bool get hasInvite => _hasInvite;
  set hasInvite(bool hasInvite) {
    _hasInvite = hasInvite;
    notifyListeners();
  }

  bool _hasSeeGuest = true;
  bool get hasSeeGuest => _hasSeeGuest;
  set hasSeeGuest(bool hasSeeGuest) {
    _hasSeeGuest = hasSeeGuest;
    notifyListeners();
  }

  List<GuestPermissionsEnum> getCurrentPermissions() {
    return [
      if (_hasModify) GuestPermissionsEnum.modifyEvent,
      if (_hasInvite) GuestPermissionsEnum.inviteOthers,
      if (_hasSeeGuest) GuestPermissionsEnum.seeGuestList,
    ];
  }

  List<bool> allPermissions() => [_hasModify, _hasInvite, _hasSeeGuest];

  void addReminder() {
    final newReminders = _event.reminders.toList();
    newReminders.add(
      Reminder(
        id: '${DateTime.now().millisecondsSinceEpoch}',
        counter: 10,
        periodEnum: NotificationPeriodEnum.minutes,
      ),
    );
    final newEvents = _event.copyWith(reminders: newReminders);
    _event = newEvents;
    notifyListeners();
  }

  void removeAtReminder(int index) {
    final newReminders = _event.reminders.toList();
    newReminders.removeAt(index);
    final newEvents = _event.copyWith(reminders: newReminders);
    _event = newEvents;
    notifyListeners();
  }

  void addGuest(String text) {
    final newGuests = _event.guests.toList();
    newGuests.add(
      Guest(
        id: '${DateTime.now().millisecondsSinceEpoch}',
        emailAddress: text,
        isOrganizer: false,
        guestColor: Colors.yellow,
        guestPermissions: getCurrentPermissions(),
      ),
    );
    final newEvents = _event.copyWith(guests: newGuests);
    _event = newEvents;
    notifyListeners();
  }

  void removeAtGuest(Guest guest) {
    final newGuests = _event.guests.toList();
    newGuests.removeWhere((newGuest) => newGuest.id == guest.id);
    final newEvents = _event.copyWith(guests: newGuests);
    _event = newEvents;
    notifyListeners();
  }

  void onChangePermission(
    GuestPermissionsEnum guestPermissions,
    bool permissionAccess,
  ) {
    switch (guestPermissions) {
      case GuestPermissionsEnum.modifyEvent:
        hasModify = permissionAccess;
        return;
      case GuestPermissionsEnum.inviteOthers:
        hasInvite = permissionAccess;
        return;
      case GuestPermissionsEnum.seeGuestList:
        hasSeeGuest = permissionAccess;
        return;
    }
  }
}
