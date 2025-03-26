import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/calendar/booking_form_data.dart';
import 'package:hously_flutter/state_managers/screen/calendar/add_item_booking_provider.dart';
import 'package:hously_flutter/state_managers/screen/calendar/schedule_appointment_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/calendar/elevated_button.dart';
import 'package:hously_flutter/widgets/calendar/schedule/add_booking_item_dialog.dart';

class BookingFormWidget extends ConsumerWidget {
  const BookingFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;
    final addItemBookingState = ref.watch(addItemBookingProvider);
    const widgetSpace = 10.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Icon(Icons.list),
        ),
        Expanded(
          child: ExpansionTile(
            title: const Text('Maximum bookings per day'),
            subtitle: const Text(
              'Limit how many booked appointments to accept in a single day',
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: widgetSpace),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  children: scheduleData.formItems
                      .map(
                        (value) => Container(
                          margin: const EdgeInsets.only(right: 10, bottom: 10),
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFBDBDBD)),
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 10,
                            children: [
                              Text(
                                '${value.fieldName}${value.isRequired ? '*' : ''}',
                              ),
                              if (value.isEditable)
                                InkWell(
                                  child: const Icon(
                                    Icons.edit,
                                    size: 18,
                                  ),
                                  onTap: () {
                                    addItemBookingState.init(value);
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: AddBookingItemDialog(
                                            onAdded: () {
                                              ref
                                                  .read(
                                                      scheduleAppointmentProvider)
                                                  .editBookingFormItem(
                                                    currentBooking: value,
                                                    newBooking:
                                                        addItemBookingState
                                                            .bookingFormModel,
                                                  );
                                              ref
                                                  .read(navigationService)
                                                  .beamPop();
                                            },
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              if (value.isDeletable)
                                InkWell(
                                  child: const Icon(
                                    Icons.close,
                                    size: 18,
                                  ),
                                  onTap: () => ref
                                      .read(scheduleAppointmentProvider)
                                      .deleteBookingFormItem(value),
                                ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '*Required',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,
                child: ElevatedButtonWidget(
                  child: const Row(
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(),
                      Text(
                        'Add an item',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onTapped: () {
                    addItemBookingState.init(defaultBookingFormValue);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: AddBookingItemDialog(
                            onAdded: () {
                              ref
                                  .read(scheduleAppointmentProvider)
                                  .addBookingFormItem(
                                    addItemBookingState.bookingFormModel,
                                  );
                              ref.read(navigationService).beamPop();
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
