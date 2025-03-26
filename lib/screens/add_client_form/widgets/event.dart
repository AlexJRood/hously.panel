import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/send_form_provider.dart';
import 'package:hously_flutter/screens/add_client_form/components/usercontact/user_contact_custom_text_field.dart';
import '../components/event/event_dete_time_picker.dart';
import 'package:table_calendar/table_calendar.dart';

final showScheduleEventProvider = StateProvider<bool>((ref) => false);
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class AddEventCardWidget extends ConsumerWidget {
  final bool isMobile;
  const AddEventCardWidget({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addClientForm = ref.watch(addClientFormProvider);
    final addClientFormNotifier = ref.read(addClientFormProvider.notifier);
    final selectedDate = ref.watch(selectedDateProvider);

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(50, 50, 50, 1),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Event',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Color.fromRGBO(200, 200, 200, 1),
                  ),
                  onPressed: () {
                    ref.read(showScheduleEventProvider.notifier).state = false;
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Układ zależny od `isMobile`
            isMobile
                ? Column(
                      children: [
                        _buildCalendarContent(ref, selectedDate, addClientForm, addClientFormNotifier),
                        const SizedBox(height:20),
                        _buildEventContent(ref, selectedDate, addClientForm, addClientFormNotifier),
                      ]
                    )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex:1, child: _buildCalendarContent(ref, selectedDate, addClientForm, addClientFormNotifier)),
                      Expanded(flex:2, child: _buildEventContent(ref, selectedDate, addClientForm, addClientFormNotifier)),
                    ]
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventContent(WidgetRef ref, DateTime selectedDate, var addClientForm, var addClientFormNotifier) {
    return Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UserContactCustomTextField(
              id: 29,
              hintText: 'Add title',
              valueKey: 'title',
              controller: addClientForm.eventTitleController,
              validator: (value) => value == null || value.isEmpty ? "Description can't be empty" : null,
              onChanged: (valueKey, value) {
                addClientFormNotifier.updateTextField(
                  addClientForm.eventTitleController,
                  value,
                );
              },
            ),
            DateTimePickerWidget(isMobile: isMobile),
            UserContactCustomTextField(
              id: 30,
              valueKey: 'location',
              hintText: 'Add location',
              controller: addClientForm.eventLocationController,
              validator: (value) => value == null || value.isEmpty ? "Location can't be empty" : null,
              onChanged: (valueKey, value) {
                addClientFormNotifier.updateTextField(
                  addClientForm.eventLocationController,
                  value,
                );
              },
            ),
            UserContactCustomTextField(
              maxLines: 3,
              id: 31,
              valueKey: 'note',
              hintText: 'Add notes',
              controller: addClientForm.eventDescriptionController,
              validator: (value) => value == null || value.isEmpty ? "Notes can't be empty" : null,
              onChanged: (valueKey, value) {
                addClientFormNotifier.updateTextField(
                  addClientForm.eventDescriptionController,
                  value,
                );
              },
            ),
          ],
        );
  }




  Widget _buildCalendarContent(WidgetRef ref, DateTime selectedDate, var addClientForm, var addClientFormNotifier) {
    return TableCalendar(
          firstDay: DateTime.utc(2000, 1, 1),
          lastDay: DateTime.utc(2100, 12, 31),
          focusedDay: selectedDate,
          selectedDayPredicate: (day) => isSameDay(day, selectedDate),
          onDaySelected: (selectedDay, focusedDay) {
            ref.read(selectedDateProvider.notifier).state = selectedDay;
          },
          calendarStyle: CalendarStyle(
            defaultTextStyle: const TextStyle(color: Colors.white),
            todayTextStyle: const TextStyle(color: Colors.white),
            selectedDecoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Colors.grey[700],
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(color: Colors.white),
          ),
      );
  }
}
