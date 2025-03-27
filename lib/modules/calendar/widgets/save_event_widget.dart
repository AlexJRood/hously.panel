import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/calendar/enums/appointment_type_enum.dart';
import 'package:hously_flutter/modules/calendar/state/appointment_type_provider.dart';
import 'package:hously_flutter/modules/calendar/state/appointments_provider.dart';
import 'package:hously_flutter/modules/calendar/state/popup_calendar_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/modules/calendar/widgets/events/event_tab_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/out_office_tab_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/scheduling_tab_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/task_tab_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/text_form_field_widget.dart';

class SaveEventWidget extends ConsumerWidget {
  final int index;
  final bool isMobile;

  const SaveEventWidget(
      {super.key, required this.index, this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentTypeState = ref.watch(appointmentTypeProvider);
    final popupCalendarWatch = ref.watch(popupCalendarProvider);
    final isEdit = ref.watch(appointmentsProvider).isEdit;
    final eventDetails = popupCalendarWatch.event;
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(35, 35, 35, 1),
          borderRadius: BorderRadius.circular(10)),
      width: isMobile ? screenSize.width : 550,
      height: isMobile ? screenSize.height * 0.65 : null,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Event',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  if (!isEdit)
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  if (isEdit)
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      onPressed: () {
                        ref.read(appointmentsProvider).deleteAppointment(
                              eventDetails,
                            );
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 15,
              ),
              child: Column(
                children: [
                  TextFormFieldWidget(
                    style: const TextStyle(
                        fontSize: 18, color: Color.fromRGBO(255, 255, 255, 1)),
                    text: eventDetails.title,
                    inputDecoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(0, 0, 0, 0.2),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none),
                        hintText: 'Add title',
                        hintStyle: const TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(255, 255, 255, 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none)),
                    onChanged: (title) {
                      final newEvent = eventDetails.copyWith(title: title);

                      ref.read(popupCalendarProvider).event = newEvent;
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: AppointmentTypeEnum.values.length,
                      itemBuilder: (context, index) {
                        final currentType = AppointmentTypeEnum.values[index];

                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: appointmentTypeState.appointmentTypeEnum ==
                                      currentType
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2)
                                  : null,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                currentType.type,
                                style: TextStyle(
                                  color: appointmentTypeState
                                              .appointmentTypeEnum ==
                                          currentType
                                      ? Theme.of(context).primaryColor
                                      : const Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          ),
                          onTap: () => appointmentTypeState
                              .appointmentTypeEnum = currentType,
                        );
                      },
                    ),
                  ),
                  switch (appointmentTypeState.appointmentTypeEnum) {
                    AppointmentTypeEnum.event => EventTabWidget(index: index),
                    AppointmentTypeEnum.outOfOffice => OutOfficeTabWidget(),
                    AppointmentTypeEnum.task => const TaskTabWidget(),
                    AppointmentTypeEnum.appointmentScheduling =>
                      const SchedulingTabWidget(),
                  },
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
