import 'package:flutter/material.dart';


class DatePickerTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const DatePickerTextField({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(labelText: label),
      onTap: () async {
        final now = DateTime.now();
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(now.year - 5),
          lastDate: DateTime(now.year + 5),
        );

        if (picked != null) {
          controller.text = picked.toIso8601String().split('T').first; // yyyy-MM-dd
        }
      },
    );
  }
}
