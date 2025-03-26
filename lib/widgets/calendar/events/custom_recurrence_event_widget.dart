import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/dialogs/calendar_popup.dart';
import 'package:hously_flutter/enums/event/end_type_enum.dart';
import 'package:hously_flutter/enums/event/frequencies_enum.dart';
import 'package:hously_flutter/enums/event/monthly_option_enum.dart';
import 'package:hously_flutter/enums/event/weekdays_enum.dart';
import 'package:hously_flutter/state_managers/screen/calendar/custom_recurrence_event_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/calendar/dropdown_field_widget.dart';
import 'package:hously_flutter/widgets/calendar/elevated_button.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';

class CustomRecurrenceEventWidget extends ConsumerWidget {
  final VoidCallback onCanceled;
  final VoidCallback onApproved;

  const CustomRecurrenceEventWidget({
    required this.onCanceled,
    required this.onApproved,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customRecurrenceState = ref.watch(customRecurrenceEventProvider);
    final theme = ref.watch(themeColorsProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Recurrence',
              style: TextStyle(color: theme.textFieldColor, fontSize: 17),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 320,
             
              child: Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      style: TextStyle(
                        color: theme.textFieldColor,
                      ),
                      text: '1',
                      textInputType: TextInputType.number,
                      inputDecoration: InputDecoration(
                          labelText: 'Repeat every (interval)',
                          labelStyle: TextStyle(
                            color: theme.textFieldColor,
                          )),
                      onChanged: (value) => customRecurrenceState.interval =
                          int.tryParse(value) ?? 1,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: DropDownWidget(
                      isDense: true,
                      currentValue: customRecurrenceState.frequency,
                      values: FrequenciesEnum.values,
                      texts: FrequenciesEnum.values
                          .map((value) => value.type)
                          .toList(),
                      onChanged: (frequency) {
                        if (frequency != null) {
                          customRecurrenceState.frequency = frequency;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Repeat Frequency',
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: true,
                        fillColor: theme.fillColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            if (customRecurrenceState.frequency == FrequenciesEnum.weekly)
              SizedBox(
                height: 35,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: WeekdaysEnum.values.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final currentDay = WeekdaysEnum.values
                        .map((value) => value.type)
                        .toList()[index];

                    return Row(
                      children: [
                        InkWell(
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: customRecurrenceState.selectedDays
                                      .contains(currentDay)
                                  ? Colors.blue
                                  : const Color(0xFFEEEEEE),
                            ),
                            child: Center(
                              child: Text(
                                currentDay,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: customRecurrenceState.selectedDays
                                          .contains(currentDay)
                                      ? Colors.white
                                      : null,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (customRecurrenceState.selectedDays
                                .contains(currentDay)) {
                              customRecurrenceState
                                  .removeSelectedDay(currentDay);
                            } else {
                              customRecurrenceState.addSelectedDay(currentDay);
                            }
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                    );
                  },
                ),
              ),
            if (customRecurrenceState.frequency == FrequenciesEnum.monthly)
              SizedBox(
                width: 320,
                child: DropDownWidget(
                  isDense: true,
                  currentValue: customRecurrenceState.monthlyOption,
                  values: MonthlyOptionEnum.values,
                  texts: MonthlyOptionEnum.values
                      .map((value) => value.type)
                      .toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      customRecurrenceState.monthlyOption = newValue;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Monthly Option',
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: true,
                    fillColor: theme.fillColor,
                  ),
                ),
              ),
            SizedBox(
              width: 320,
              child: DropDownWidget(
                isDense: true,
                currentValue: customRecurrenceState.endType,
                values: EndTypeEnum.values,
                texts: EndTypeEnum.values.map((value) => value.type).toList(),
                onChanged: (endType) {
                  if (endType != null) {
                    customRecurrenceState.endType = endType;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Ends',
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor: theme.fillColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (customRecurrenceState.endType == EndTypeEnum.onDate)
              InkWell(
                child: Text(
                  '${CalendarConst.monthsName[customRecurrenceState.endDate.month - 1]} ${customRecurrenceState.endDate.day},${customRecurrenceState.endDate.year}',
                  style: TextStyle(color: theme.textFieldColor),
                ),
                onTapDown: (event) => showCalendarPopup(
                  context: context,
                  event: event,
                  minDate: DateTime.now(),
                  onSelectionChanged: (details) {
                    if (details.date != null) {
                      customRecurrenceState.endDate = details.date!;
                    }
                    ref.read(navigationService).beamPop();
                  },
                ),
              ),
            if (customRecurrenceState.endType == EndTypeEnum.after)
              SizedBox(
                width: 320,
                height: 60,
                child: TextFormField(
                  initialValue: '1',
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Occurrences'),
                  onChanged: (value) {
                    customRecurrenceState.occurrences = int.tryParse(value);
                  },
                ),
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: 320,
              child: Row(
                children: [
                  const Spacer(),
                  ElevatedButtonWidget(
                    bgColor: Colors.transparent,
                    elevation: 0,
                    onTapped: onCanceled,
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButtonWidget(
                    onTapped: onApproved,
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
