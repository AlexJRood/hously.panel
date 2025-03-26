import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/state_managers/screen/calendar/add_item_booking_provider.dart';
import 'package:hously_flutter/state_managers/screen/calendar/schedule_appointment_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/calendar/check_box_text.dart';
import 'package:hously_flutter/widgets/calendar/elevated_button.dart';
import 'package:hously_flutter/widgets/calendar/event_input_decoration.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';

class AddBookingItemDialog extends ConsumerWidget {
  final VoidCallback onAdded;

  const AddBookingItemDialog({super.key, required this.onAdded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;
    final bookingFormData = ref.watch(addItemBookingProvider).bookingFormModel;
    final theme = ref.watch(themeColorsProvider);
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 210,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add an item',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 200,
              height: 60,
              child: TextFormFieldWidget(
                text: bookingFormData.fieldName,
                inputDecoration: eventInputDecoration('', theme),
                onChanged: (fieldName) {
                  final newBookingFormData = bookingFormData.copyWith(
                    fieldName: fieldName,
                  );

                  ref.read(addItemBookingProvider).bookingFormModel =
                      newBookingFormData;
                },
              ),
            ),
            const SizedBox(height: 15),
            CheckBoxText(
              isActive: bookingFormData.isRequired,
              title: 'Required',
              onChanged: (isRequired) {
                final newBookingFormData = bookingFormData.copyWith(
                  isRequired: isRequired,
                );

                ref.read(addItemBookingProvider).bookingFormModel =
                    newBookingFormData;
              },
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Spacer(),
                ElevatedButtonWidget(
                  bgColor: Colors.transparent,
                  elevation: 0,
                  child: const Text('Cancel'),
                  onTapped: () => ref.read(navigationService).beamPop(),
                ),
                const SizedBox(width: 10),
                ElevatedButtonWidget(
                  onTapped: onAdded,
                  child: const Text(
                    'Add item',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
