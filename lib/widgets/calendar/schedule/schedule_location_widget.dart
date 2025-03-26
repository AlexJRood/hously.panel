import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/enums/schedule/meeting_location_enum.dart';
import 'package:hously_flutter/state_managers/screen/calendar/schedule_appointment_provider.dart';
import 'package:hously_flutter/widgets/calendar/auto_location_field.dart';
import 'package:hously_flutter/widgets/calendar/dropdown_field_widget.dart';
import 'package:hously_flutter/widgets/calendar/events/event_web_option.dart';
import 'package:hously_flutter/widgets/calendar/schedule/divider_widget.dart';

class ScheduleLocationWidget extends ConsumerWidget {
  const ScheduleLocationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;
    const widgetSpace = 10.0;
    final controller = QuillController.basic();

    return EventWebOption(
      crossAxisAlignment: CrossAxisAlignment.start,
      iconData: Icons.video_call,
      secondWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Location and conferencing',
            style: TextStyle(color: Colors.black),
          ),
          const Text(
            'Would you like to meet in person, via phone, or video conference?',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: widgetSpace),
          DropDownWidget(
            isDense: true,
            currentValue: scheduleData.meetingLocation,
            values: MeetingLocationEnum.values,
            decoration: const InputDecoration(contentPadding: EdgeInsets.zero),
            texts:
                MeetingLocationEnum.values.map((value) => value.type).toList(),
            onChanged: (meetingLocation) {
              final scheduleAppointmentState =
                  ref.read(scheduleAppointmentProvider);
              if (meetingLocation == null) return;

              final newScheduleData = scheduleData.copyWith(
                meetingLocation: meetingLocation,
              );

              scheduleAppointmentState.scheduleModel = newScheduleData;
              scheduleAppointmentState.changePhoneNumberField(
                meetingLocation == MeetingLocationEnum.phoneCall,
              );
            },
          ),
          const SizedBox(height: widgetSpace),
          switch (scheduleData.meetingLocation) {
            MeetingLocationEnum.googleMeet => const Text(
                'A Meet link will be generated after booking',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            MeetingLocationEnum.inPerson => AddLocationWidget(),
            MeetingLocationEnum.phoneCall => const Text(
                'The person making the appointment will provide the phone number',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            MeetingLocationEnum.none => const SizedBox.shrink(),
          },
          const SizedBox(height: widgetSpace),
          const DividerWidget(),
          const SizedBox(height: widgetSpace),
          QuillToolbar.simple(
            controller: controller,
            configurations: const QuillSimpleToolbarConfigurations(
              showCodeBlock: false,
              showQuote: false,
              showStrikeThrough: false,
              showFontFamily: false,
              showFontSize: false,
              showInlineCode: false,
              showSearchButton: false,
              showIndent: false,
              showDirection: false,
              showColorButton: false,
              showBackgroundColorButton: false,
              showJustifyAlignment: false,
              showAlignmentButtons: false,
              showCenterAlignment: false,
              showClipboardCopy: false,
              showClipboardCut: false,
              showClipboardPaste: false,
              showDividers: false,
              showHeaderStyle: false,
              showLeftAlignment: false,
              showLineHeightButton: false,
              showListCheck: false,
              showRedo: false,
              showRightAlignment: false,
              showSmallButton: false,
              showSubscript: false,
              showSuperscript: false,
              showUndo: false,
            ),
          ),
          Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: QuillEditor.basic(controller: controller),
          ),
          const SizedBox(height: widgetSpace),
          const DividerWidget(),
          const SizedBox(height: widgetSpace),
        ],
      ),
    );
  }
}
