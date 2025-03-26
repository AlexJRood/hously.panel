enum GuestPermissionsEnum {
  modifyEvent,
  inviteOthers,
  seeGuestList;

  String get type => switch (this) {
        modifyEvent => 'Modify event',
        inviteOthers => 'Invite others',
        seeGuestList => 'See guest list',
      };

  GuestPermissionsEnum get calendarView => switch (this) {
        modifyEvent => GuestPermissionsEnum.modifyEvent,
        inviteOthers => GuestPermissionsEnum.inviteOthers,
        seeGuestList => GuestPermissionsEnum.seeGuestList,
      };

  static GuestPermissionsEnum fromString(String input) =>
      GuestPermissionsEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => modifyEvent,
      );
}
