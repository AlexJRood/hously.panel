import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/modules/calendar/state/schedule_appointment_provider.dart';
import 'package:hously_flutter/modules/calendar/widgets/check_box_text.dart';
import 'package:hously_flutter/modules/calendar/widgets/text_form_field_widget.dart';

class BookedAppointmentWidget extends ConsumerWidget {
  const BookedAppointmentWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;
    const widgetSpace = 10.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SvgPicture.asset(AppIcons.calendar),
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
              CheckBoxText(
                isActive: scheduleData.hasLimit,
                title: 'Test',
                titleWidget: SizedBox(
                  width: 100,
                  child: TextFormFieldWidget(
                    text: '${scheduleData.limitNumber}',
                    textInputType: TextInputType.number,
                    readOnly: !scheduleData.hasLimit,
                    style: TextStyle(
                      color: scheduleData.hasLimit ? Colors.black : Colors.grey,
                    ),
                    inputDecoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: scheduleData.hasLimit
                          ? const Color(0xFFEEEEEE)
                          : const Color(0xFFFAFAFA),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (limitNumber) {
                      if (limitNumber.isEmpty) return;

                      final newScheduleData = scheduleData.copyWith(
                        maxDays: int.parse(limitNumber),
                      );

                      ref.read(scheduleAppointmentProvider).scheduleModel =
                          newScheduleData;
                    },
                  ),
                ),
                onChanged: (hasLimit) {
                  final newScheduleData = scheduleData.copyWith(
                    hasLimit: hasLimit,
                  );

                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData;
                },
              ),
              const SizedBox(height: widgetSpace),
              const Text(
                'Guest permissions',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: widgetSpace),
              CheckBoxText(
                isActive: scheduleData.invitePermission,
                title: 'Test',
                crossAxisAlignment: CrossAxisAlignment.start,
                titleWidget: const SizedBox(
                  width: 380,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Guests can invite others',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(height: widgetSpace),
                      Text(
                        'After booking an appointment guests can modify the calendar event to invite others',
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                onChanged: (invitePermission) {
                  final newScheduleData = scheduleData.copyWith(
                    invitePermission: invitePermission,
                  );

                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData;
                },
              ),
              const SizedBox(height: widgetSpace),
            ],
          ),
        ),
      ],
    );
  }
}
