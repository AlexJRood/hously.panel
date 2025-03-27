import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/utils/extensions/string_extension.dart';
import 'package:hously_flutter/modules/calendar/state/timer_validation_provider.dart';
import 'package:hously_flutter/modules/calendar/widgets/text_form_field_widget.dart';

class TimerFieldsWidget extends ConsumerWidget {
  final ValueChanged<String>? onChanged1;
  final ValueChanged<String>? onChanged2;
  final String text1;
  final String text2;
  final String fieldId;

  const TimerFieldsWidget({
    super.key,
    this.onChanged1,
    this.onChanged2,
    required this.text1,
    required this.text2,
    required this.fieldId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerValidationState = ref.watch(timerValidationProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 160,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 75,
                    child: TextFormFieldWidget(
                      autoValidationMode: AutovalidateMode.onUserInteraction,
                      text: text1,
                      inputDecoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                      onChanged: onChanged1,
                      validator: (time) {
                        final timerValidationState =
                            ref.read(timerValidationProvider);
                        if (time == null ||
                            time.isEmpty ||
                            !time.timeValidation()) {
                          timerValidationState.timerValidation1 = true;
                        } else {
                          timerValidationState.timerValidation1 = false;
                        }

                        return null;
                      },
                    ),
                  ),
                  const Text('-'),
                  SizedBox(
                    width: 75,
                    child: TextFormFieldWidget(
                      autoValidationMode: AutovalidateMode.onUserInteraction,
                      text: text2,
                      inputDecoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                      onChanged: onChanged2,
                      validator: (time) {
                        final timerValidationState =
                            ref.read(timerValidationProvider);
                        if (time == null ||
                            time.isEmpty ||
                            !time.timeValidation()) {
                          timerValidationState.timerValidation2 = true;
                        } else {
                          timerValidationState.timerValidation2 = false;
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if ((timerValidationState.timerValidation1 ||
                timerValidationState.timerValidation2) &&
            timerValidationState.fieldId == fieldId)
          Text(
            'Invalid ${timerValidationState.timerValidation1 ? 'start' : 'end'} time',
            style: const TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
