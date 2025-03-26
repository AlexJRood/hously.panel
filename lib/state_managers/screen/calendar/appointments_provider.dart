import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/calendar/event_data.dart';
import 'package:hously_flutter/models/calendar/event_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final appointmentsProvider =
    ChangeNotifierProvider((ref) => AppointmentsProvider());

class AppointmentsProvider extends ChangeNotifier {
  bool _isEdit = false;
  bool get isEdit => _isEdit;
  set isEdit(bool isEdit) {
    _isEdit = isEdit;
    notifyListeners();
  }

  var _appointments = <Appointment>[];
  List<Appointment> get appointments => _appointments;
  set appointments(List<Appointment> appointments) {
    _appointments = appointments;
    notifyListeners();
  }

  var _events = <EventModel>[];
  List<EventModel> get events => _events;
  set events(List<EventModel> events) {
    _events = events;
    notifyListeners();
  }

  void init(BuildContext context) {
    _appointments = _getDataSource(context);
    notifyListeners();
  }

  void onDragEnded(AppointmentDragEndDetails details) {
    final draggedAppointment = details.appointment as Appointment;
    final updatedAppointment = Appointment(
      startTime: details.droppingTime!,
      endTime: details.droppingTime!.add(
          draggedAppointment.endTime.difference(draggedAppointment.startTime)),
      subject: draggedAppointment.subject,
      color: draggedAppointment.color,
    );

    _appointments.remove(draggedAppointment);
    _appointments.add(updatedAppointment);
  }

  List<Appointment> _getDataSource(BuildContext context) {
    final appointments = <Appointment>[];
    final today = DateTime.now();
    final startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    final endTime = startTime.add(const Duration(hours: 1));
    final currentId = '${DateTime.now().millisecondsSinceEpoch}';

    appointments.add(Appointment(
      id: currentId,
      startTime: startTime,
      endTime: endTime,
      subject: 'Team Meeting',
      
      color: Theme.of(context).primaryColor,
      //color need to be changed for blackwhilte colorscheme
    ));
    events.add(defaultEvent.copyWith(
      id: currentId,
      title: 'Team Meeting',
      from: startTime,
      to: endTime,
    ));

    return appointments;
  }

  void saveAppointment({
    required EventModel event,
    required int index,
    required String customRecurrence,
    required BuildContext context,
  }) {
    if (_isEdit) {
      _events[index] = event;
      _appointments[index] = Appointment(
        id: event.id,
        startTime: event.from,
        endTime: event.to,
        color: Theme.of(context).primaryColor,
        subject: event.title,
        notes: event.description,
        location: event.location,
        recurrenceRule: customRecurrence,
      );
    } else {
      final currentId = '${DateTime.now().millisecondsSinceEpoch}';

      _events.add(event.copyWith(id: currentId));
      _appointments.add(Appointment(
        id: currentId,
        startTime: event.from,
        endTime: event.to,
        color: Theme.of(context).primaryColor,
        subject: event.title,
        notes: event.description,
        location: event.location,
        recurrenceRule: customRecurrence,
      ));
    }

    notifyListeners();
  }

  void deleteAppointment(EventModel event) {
    _appointments.removeWhere((appointment) => appointment.id == event.id);
    _events.removeWhere((newEvent) => newEvent.id == event.id);

    notifyListeners();
  }
}
