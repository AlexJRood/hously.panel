import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastMessage({
  required String message,
  Toast toastLength = Toast.LENGTH_SHORT,
  ToastGravity toastGravity = ToastGravity.TOP,
  Color bgColor = Colors.red,
  Color textColor = Colors.white,
  dynamic webBgColor = "linear-gradient(to right, #ff0000, #ff0000)",
  dynamic webPosition = 'top',
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: toastGravity,
    timeInSecForIosWeb: 3,
    backgroundColor: bgColor,
    textColor: textColor,
    webBgColor: webBgColor,
    webPosition: webPosition,
    fontSize: 16.0,
  );
}
