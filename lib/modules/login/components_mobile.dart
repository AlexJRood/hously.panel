import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final Iterable<String>? autofillHints;
  final FocusNode? nextFocus;
  final bool obscureText;
  final TextEditingController?
      compareController; // For Confirm Password comparison

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.label,
    required this.autofillHints,
    this.nextFocus,
    this.obscureText = false,
    this.compareController, // Optional controller for Confirm Password
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocus?.requestFocus(),
      obscureText: obscureText,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: Color(0xff919191),
            fontWeight: FontWeight.w400,
            fontSize: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 1),
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 1.0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 1.0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 1.0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 12), // Adjust padding
      ),
      validator: (value) {
        // Check for empty value across all fields
        if (value == null || value.isEmpty) {
          return '$label is required';
        }

        // Specific validations based on the label
        switch (label) {
          case 'First Name':
            if (value.length < 2) {
              return 'First name must be at least 2 characters long';
            }
            if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
              return 'First name can only contain letters';
            }
            break;

          case 'Last Name':
            if (value.length < 2) {
              return 'Last name must be at least 2 characters long';
            }
            if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
              return 'Last name can only contain letters';
            }
            break;

          case 'Email':
            if (!GetUtils.isEmail(value)) {
              return 'Invalid email address';
            }
            break;

          case 'Phone Number':
            if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
              return 'Invalid phone number (e.g., +1234567890)';
            }
            break;

          case 'Password':
            if (value.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$')
                .hasMatch(value)) {
              return 'Password must contain at least one letter and one number';
            }
            break;

          case 'Confirm Password':
            if (compareController != null && value != compareController!.text) {
              return 'Passwords do not match';
            }
            break;

          default:
            // Default case for any other label (if applicable)
            return null;
        }

        return null; // Return null if validation passes
      },
    );
  }
}

class SocialButtonMobile extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;

  const SocialButtonMobile({
    Key? key,
    required this.imagePath,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.white, // Keep background unchanged
      borderRadius: BorderRadius.circular(8), // Ensure ripple effect is clipped
      child: InkWell(
        splashColor: Colors.black12,
        borderRadius:
            BorderRadius.circular(8), // Ensure splash follows the shape
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), // Slight rounding
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                height: 30,
                width: 30,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              Text(
                label,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xffE2E8F0),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('or'),
        ),
        Expanded(
          child: Divider(
            color: Color(0xffE2E8F0),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
