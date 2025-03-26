import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/calendar/event_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
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
    _appointments = _getDataSource();
    notifyListeners();
  }

  Future<void> fetchEvents(dynamic ref) async {
    try {
      final response =
          await ApiServices.get(URLs.getCreateEvent, ref: ref, hasToken: true);

      if (response != null &&
          response.statusCode == 200 &&
          response.data != null) {
        final String responseBody = utf8.decode(response.data);
        final data = json.decode(responseBody);

        if (data['results'] != null) {
          final List<EventModel> fetchedEvents = (data['results'] as List)
              .map((e) => EventModel.fromJson(e))
              .toList();
          events = fetchedEvents;
          _appointments = fetchedEvents.map((event) {
            return Appointment(
              id: event.id,
              startTime: event.from,
              endTime: event.to,
              subject: event.title,
              notes: event.description,
              location: event.location,
              color: Colors.blueAccent,
            );
          }).toList();

          notifyListeners();
          print('Events fetched successfully');
        } else {
          print('No events found.');
        }
      } else {
        print('Events fetch failed');
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> addEvent(
      String? title, String? description, String? location) async {
    try {
      final body = {
        "title": (title == null || title.trim().isEmpty) ? 'Title' : title,
        "description": (description == null || description.trim().isEmpty) ? 'Description' : description,
        "location": (location == null || location.trim().isEmpty) ? 'Location' : location,
      };
      print(body);
      final response = await ApiServices.post(URLs.getCreateEvent,
          hasToken: true, data: body);
      if (response != null && response.statusCode == 201) {
        print('Event added successfully');
      } else {
        print('Event added failed');
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> editEvent(
      String eventId, String? title, String? description, String? location) async {
    try {
      final body = {
        "title": (title == null || title.trim().isEmpty) ? 'Title' : title,
        "description": (description == null || description.trim().isEmpty) ? 'Description' : description,
        "location": (location == null || location.trim().isEmpty) ? 'Location' : location,
      };
      print(body);
      final response = await ApiServices.patch(URLs.updateDetailEvent(eventId),
          data: body,
          hasToken: true);

      if (response != null && response.statusCode == 200) {
        print('event updated successfully');
      } else {
        print('event updated failed');
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void saveAppointment({
    required EventModel event,
    required int index,
    required String customRecurrence,
    required BuildContext context,
  }) {
    if (_isEdit) {
      // Update existing event
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
      // Create new event with unique ID
      final newId = '${DateTime.now().millisecondsSinceEpoch}';
      final newEvent = event.copyWith(id: newId);

      _events.add(newEvent);
      _appointments.add(Appointment(
        id: newId,
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

  List<Appointment> _getDataSource() {
    return events.map((event) {
      return Appointment(
        id: event.id,
        startTime: event.from,
        endTime: event.to,
        subject: event.title,
        notes: event.description,
        location: event.location,
        color: Colors.blueAccent, // Customize as needed
      );
    }).toList();
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
    notifyListeners();
  }
}
