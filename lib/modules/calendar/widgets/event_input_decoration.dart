import 'package:flutter/material.dart';
import 'package:hously_flutter/theme/apptheme.dart';

InputDecoration eventInputDecoration(String hintName, ThemeColors theme) {
  return InputDecoration(
    hintText: hintName,
    hintStyle: TextStyle(color: theme.textFieldColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: theme.textFieldColor),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: theme.textFieldColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: theme.textFieldColor)),
  );
}
