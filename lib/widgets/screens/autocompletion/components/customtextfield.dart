import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/design.dart';

class CustomTextField extends ConsumerWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isReadOnly;
  final String hintText;

  final IconData prefixIcon;
  final List<String> selectedDistricts; // Change this to List<String>
  final bool isloading;
  final VoidCallback onClear;
  final ValueChanged<String> onChanged;
  final VoidCallback onTap;

  const CustomTextField({
    Key? key,
    required this.isloading,
    required this.controller,
    required this.focusNode,
    required this.isReadOnly,
    required this.hintText,
    required this.prefixIcon,
    required this.selectedDistricts,
    required this.onClear,
    required this.onChanged,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final currentthememode = ref.watch(themeProvider);

    final textFieldColor = (currentthememode == ThemeMode.system ||
            currentthememode == ThemeMode.light)
        ? Colors.black
        : Colors.white;
    final cursorcolor = Theme.of(context).primaryColor;

    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    return TextField(
      style: AppTextStyles.interMedium14dark.copyWith(color: textFieldColor),
      readOnly: isReadOnly,
      controller: controller,
      focusNode: focusNode,
      cursorColor:
          currentthememode == ThemeMode.system ? Colors.black : cursorcolor,
      decoration: InputDecoration(
        hoverColor: Colors.transparent,
        fillColor: inputDecorationTheme.fillColor,
        contentPadding: const EdgeInsets.only(top: 5),
        hintText: hintText,
        hintStyle:
            AppTextStyles.interMedium14dark.copyWith(color: textFieldColor),
        prefixIcon: Icon(
          prefixIcon,
          color: textFieldColor,
        ),
        suffixIcon: Container(
            padding: const EdgeInsets.only(right: 8.0),
            child: (focusNode.hasFocus && controller.text.isNotEmpty) ||
                    selectedDistricts.isNotEmpty
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 5),
                      if (selectedDistricts.isNotEmpty)
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black,
                          child: Text(
                            selectedDistricts.length.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: onClear,
                        icon: Icon(
                          Icons.close,
                          size: 25,
                          color: textFieldColor,
                        ),
                      ),
                    ],
                  )
                : SizedBox()),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
