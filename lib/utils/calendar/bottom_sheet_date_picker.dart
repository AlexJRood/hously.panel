import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/extensions/context_extension.dart';
import 'package:hously_flutter/widgets/calendar/elevated_button.dart';

void showDateModal({
  required String title,
  required BuildContext context,
  required DateTime initialDate,
  required ValueChanged<DateTime> onDateTimeChanged,
}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        height: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  const Text('Thu, Oct 10, 2024 15:17'),
                ],
              ),
            ),
            Expanded(
              child: _buildDatePicker(
                context: context,
                initialDate: initialDate,
                onDateTimeChanged: onDateTimeChanged,
              ),
            ),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: context.screenWidth * 0.45,
                    child: ElevatedButtonWidget(
                      bgColor: const Color(0xFFEEEEEE),
                      elevation: 0,
                      onTapped: () {},
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: context.screenWidth * 0.45,
                    child: ElevatedButtonWidget(
                      elevation: 0,
                      child: const Text(
                        'Ok',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      onTapped: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Date picker widget
Widget _buildDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required ValueChanged<DateTime> onDateTimeChanged,
}) {
  return SizedBox(
    height: 180,
    child: CupertinoDatePicker(
      mode: CupertinoDatePickerMode.dateAndTime,
      initialDateTime: initialDate,
      onDateTimeChanged: onDateTimeChanged,
      // onDateTimeChanged: (DateTime date) {
      //   setState(() {
      //     _selectedDate = date;
      //   });
      //   Navigator.pop(context);
      // },
    ),
  );
}
