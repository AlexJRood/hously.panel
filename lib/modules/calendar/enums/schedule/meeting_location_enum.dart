enum MeetingLocationEnum {
  googleMeet,
  inPerson,
  phoneCall,
  none;

  String get type => switch (this) {
        googleMeet => 'Google Meet video conferencing',
        inPerson => 'In-person meeting',
        phoneCall => 'Phone call',
        none => 'None / to be specified later',
      };

  MeetingLocationEnum get calendarView => switch (this) {
        googleMeet => MeetingLocationEnum.googleMeet,
        inPerson => MeetingLocationEnum.inPerson,
        phoneCall => MeetingLocationEnum.phoneCall,
        none => MeetingLocationEnum.none,
      };

  static MeetingLocationEnum fromString(String input) =>
      MeetingLocationEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => googleMeet,
      );
}
