enum DeclineMeetingEnum {
  newMeetings,
  allMeetings;

  String get type => switch (this) {
        newMeetings => 'Only new meeting invitations',
        allMeetings => 'New and existing meetings',
      };

  DeclineMeetingEnum get calendarView => switch (this) {
        newMeetings => DeclineMeetingEnum.newMeetings,
        allMeetings => DeclineMeetingEnum.allMeetings,
      };

  static DeclineMeetingEnum fromString(String input) =>
      DeclineMeetingEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => newMeetings,
      );
}
