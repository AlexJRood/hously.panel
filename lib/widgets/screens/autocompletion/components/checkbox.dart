import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  CustomCheckbox({
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!isChecked);
      },
      child: Container(
        width: 25, // Customize the size to match your design
        height: 25,
        decoration: BoxDecoration(
          color: isChecked ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(4), // Rounded corners
          border: Border.all(
            color: Colors.black, // Border color
            width: 2, // Border thickness
          ),
        ),
        child: isChecked
            ? Center(
                child: Icon(
                  Icons.check, // Checkmark icon
                  color: Colors.white,
                  size: 20, // Size of the checkmark
                ),
              )
            : null,
      ),
    );
  }
}
