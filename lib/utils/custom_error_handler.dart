import 'package:flutter/material.dart';

class Customsnackbar {
  SnackBar showSnackBar(String title, String errorMessage, String errortype,
      void Function()? onPressed) {
    final custumsnack = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20), // Adjust the radius for more curve
      ),
      backgroundColor: getColorBasedOnErrorType(errortype),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14), // Reduced font size
            ),
          ),
          Flexible(
            child: Text(
              errorMessage,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ), // Reduced padding for the button
              ),
              child: Text(
                getbuttontext(errortype),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold), // Black text color
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    );
    return custumsnack;
  }

  Color getColorBasedOnErrorType(String errorType) {
    switch (errorType) {
      case 'error':
        return const Color.fromARGB(255, 150, 61, 61);
      case 'warning':
        return const Color.fromARGB(255, 255, 165, 0);
      case 'success':
        return const Color.fromARGB(255, 61, 150, 61);
      default:
        return const Color.fromARGB(255, 173, 216, 230);
    }
  }

  String getbuttontext(String errorType) {
    switch (errorType) {
      case 'error':
        return 'Retry';
      case 'warning':
        return 'Okay';
      case 'success':
        return 'Done';
      default:
        return 'Cancel';
    }
  }
}
