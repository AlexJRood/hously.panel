import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/enums/appointment_type_enum.dart';
import 'package:hously_flutter/state_managers/screen/calendar/appointment_type_provider.dart';
import 'package:hously_flutter/state_managers/screen/calendar/appointments_provider.dart';
import 'package:hously_flutter/state_managers/screen/calendar/popup_calendar_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/calendar/events/event_tab_widget.dart';
import 'package:hously_flutter/widgets/calendar/out_office_tab_widget.dart';
import 'package:hously_flutter/widgets/calendar/scheduling_tab_widget.dart';
import 'package:hously_flutter/widgets/calendar/task_tab_widget.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';

class SaveEventWidget extends ConsumerWidget {
  final int index;

  const SaveEventWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentTypeState = ref.watch(appointmentTypeProvider);
    final popupCalendarWatch = ref.watch(popupCalendarProvider);
    final isEdit = ref.watch(appointmentsProvider).isEdit;
    final eventDetails = popupCalendarWatch.event;
    final theme = ref.watch(themeColorsProvider);
    return Container(
      color: theme.fillColor,
      width: 400,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                bottom: 2.0,
                left: 5,
                right: 5,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: theme.textFieldColor,
                    ),
                    onPressed: () => ref.read(navigationService).beamPop(),
                  ),
                  const Spacer(),
                  if (isEdit)
                    IconButton(
                      icon: Icon(Icons.delete, color: theme.textFieldColor),
                      onPressed: () {
                        ref.read(appointmentsProvider).deleteAppointment(
                              eventDetails,
                            );
                        ref.read(navigationService).beamPop();
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
                    style: TextStyle(fontSize: 18, color: theme.textFieldColor),
                    text: eventDetails.title,
                    inputDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: theme.textFieldColor, width: 1)),
                        hintText: 'Add title',
                        hintStyle: TextStyle(
                            fontSize: 18, color: theme.textFieldColor),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                                color: theme.textFieldColor, width: 1))),
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
                                      : theme.textFieldColor.withOpacity(0.8),
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
