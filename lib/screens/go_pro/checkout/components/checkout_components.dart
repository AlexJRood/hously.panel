import 'package:country_flags/country_flags.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class GradientTextFieldcheckout extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode reqNode;
  final TextInputType keyboardType;

  const GradientTextFieldcheckout({
    Key? key,
    required this.focusNode,
    required this.reqNode,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  _GradientTextFieldcheckoutState createState() =>
      _GradientTextFieldcheckoutState();
}

class _GradientTextFieldcheckoutState
    extends ConsumerState<GradientTextFieldcheckout> {
  late FocusNode _focusNode;

  late bool _isFocused;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode;
    _isFocused = false;

    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    // No need to dispose `_focusNode` if it's passed in from outside.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: CustomBackgroundGradients.textFieldGradient(context, ref),
      ),
      child: TextField(
        cursorColor: theme.popupcontainertextcolor,
        style: TextStyle(
          color: _isFocused
              ? theme.whitewhiteblack
              : colorscheme == FlexScheme.blackWhite
                  ? Theme.of(context).colorScheme.onSecondary
                  : theme.themeTextColor,
        ),
        controller: widget.controller,
        focusNode: _focusNode,
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(widget.reqNode);
        },
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(
            color: _isFocused
                ? theme.whitewhiteblack
                : colorscheme == FlexScheme.blackWhite
                    ? Theme.of(context).colorScheme.onSecondary
                    : theme.themeTextColor,
          ),
          labelText: widget.hintText,
          labelStyle: TextStyle(color: theme.themeTextColor, fontSize: 14),
          filled: true,
          fillColor:
              _isFocused ? theme.gradienttextfillcolor : Colors.transparent,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent)),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class GradientDropdownCountrycheckout extends ConsumerStatefulWidget {
  final String hintText;
  final List<Map<String, String>>
      countries; // Each country has 'name' and 'countryCode'
  final String? selectedCountry;
  final ValueChanged<String?> onChanged;

  const GradientDropdownCountrycheckout({
    Key? key,
    required this.hintText,
    required this.countries,
    required this.selectedCountry,
    required this.onChanged,
  }) : super(key: key);

  @override
  _GradientDropdownCountrycheckoutState createState() =>
      _GradientDropdownCountrycheckoutState();
}

class _GradientDropdownCountrycheckoutState
    extends ConsumerState<GradientDropdownCountrycheckout> {
  @override
  Widget build(BuildContext context) {
    final colorscheme = ref.watch(colorSchemeProvider);
    final theme = ref.watch(themeColorsProvider);
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: CustomBackgroundGradients.textFieldGradient(context, ref),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          buttonStyleData: const ButtonStyleData(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
          ),
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
            scrollbarTheme: ScrollbarThemeData(
                thumbColor: WidgetStatePropertyAll(
                    ref.watch(themeColorsProvider).textFieldColor)),
            maxHeight: 300,
            decoration: BoxDecoration(
              color: ref.watch(themeColorsProvider).popupcontainercolor,
            ),
          ),
          hint: Text(
            widget.hintText,
            style: TextStyle(
              color: ref
                  .watch(themeColorsProvider)
                  .themeTextColor
                  .withOpacity(0.8),
              fontSize: 14,
            ),
          ),
          value: widget.selectedCountry,
          onChanged: (value) {
            widget.onChanged(value);
          },
          iconStyleData: IconStyleData(
            iconEnabledColor:
                ref.watch(themeColorsProvider).themeTextColor.withOpacity(0.8),
          ),
          items: widget.countries.map((country) {
            return DropdownMenuItem<String>(
              value: country['name'],
              child: Row(
                children: [
                  CountryFlag.fromCountryCode(
                    country['flag']!,
                    width: 30,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    country['name']!,
                    style: TextStyle(
                      color: country['name'] == widget.selectedCountry
                          ? Theme.of(context).primaryColor
                          : ref
                              .watch(themeColorsProvider)
                              .popupcontainertextcolor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          selectedItemBuilder: (BuildContext context) {
            return widget.countries.map((country) {
              return Row(
                children: [
                  CountryFlag.fromCountryCode(
                    country['flag']!,
                    width: 30,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    country['name']!,
                    style: TextStyle(
                        color: colorscheme == FlexScheme.blackWhite
                            ? Theme.of(context).colorScheme.onSecondary
                            : theme.textColor),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }
}

class Successpagebutton extends ConsumerWidget {
  final double buttonheight;
  final VoidCallback onTap;
  final String text;
  final bool backgroundcolor;
  final bool isborder;
  final bool hasicon;
  const Successpagebutton({
    Key? key,
    this.hasicon = false,
    required this.buttonheight,
    required this.onTap,
    required this.text,
    this.isborder = false,
    this.backgroundcolor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final currentMode = ref.watch(isDefaultDarkSystemProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    return hasicon
        ? SizedBox(
            height: buttonheight,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.attach_file_sharp,
                color: currentMode
                    ? Colors.lightBlueAccent
                    : colorscheme == FlexScheme.blackWhite
                        ? Theme.of(context).colorScheme.onSecondary
                        : theme.textFieldColor,
              ),
              iconAlignment: IconAlignment.start,
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: isborder
                          ? BorderSide(
                              width: 2,
                              color: currentMode
                                  ? Colors.lightBlueAccent
                                  : colorscheme == FlexScheme.blackWhite
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                      : theme.textFieldColor,
                            )
                          : BorderSide.none),
                ),
                backgroundColor: WidgetStatePropertyAll(backgroundcolor
                    ? currentMode
                        ? theme.settingsButtoncolor
                        : Theme.of(context).colorScheme.primary
                    : Colors.transparent),
              ),
              onPressed: onTap,
              label: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: currentMode
                      ? Colors.lightBlueAccent
                      : colorscheme == FlexScheme.blackWhite
                          ? Theme.of(context).colorScheme.onSecondary
                          : theme.textFieldColor,
                  fontSize: 11,
                ),
              ),
            ),
          )
        : SizedBox(
            height: buttonheight,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: isborder
                          ? BorderSide(width: 2, color: theme.textFieldColor)
                          : BorderSide.none),
                ),
                backgroundColor: WidgetStatePropertyAll(backgroundcolor
                    ? currentMode
                        ? theme.settingsButtoncolor
                        : Theme.of(context).colorScheme.primary
                    : Colors.transparent),
              ),
              onPressed: onTap,
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: currentMode
                      ? Colors.lightBlueAccent
                      : colorscheme == FlexScheme.blackWhite
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).iconTheme.color,
                  fontSize: 11,
                ),
              ),
            ),
          );
  }
}

class Failiurepagebutton extends ConsumerWidget {
  final double buttonheight;
  final VoidCallback onTap;
  final String text;
  final bool backgroundcolor;
  final bool isborder;
  final bool hasicon;
  const Failiurepagebutton({
    Key? key,
    this.hasicon = false,
    required this.buttonheight,
    required this.onTap,
    required this.text,
    this.isborder = false,
    this.backgroundcolor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final currentMode = ref.watch(isDefaultDarkSystemProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    return hasicon
        ? SizedBox(
            height: buttonheight,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.refresh_rounded,
                color: currentMode
                    ? Colors.lightBlueAccent
                    : colorscheme == FlexScheme.blackWhite
                        ? Theme.of(context).colorScheme.onSecondary
                        : theme.textFieldColor,
              ),
              iconAlignment: IconAlignment.start,
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: isborder
                          ? BorderSide(
                              width: 2,
                              color: currentMode
                                  ? Colors.lightBlueAccent
                                  : colorscheme == FlexScheme.blackWhite
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                      : theme.textFieldColor,
                            )
                          : BorderSide.none),
                ),
                backgroundColor: WidgetStatePropertyAll(backgroundcolor
                    ? currentMode
                        ? theme.settingsButtoncolor
                        : Theme.of(context).colorScheme.primary
                    : Colors.transparent),
              ),
              onPressed: onTap,
              label: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color:  currentMode
                      ? Colors.lightBlueAccent
                      : colorscheme == FlexScheme.blackWhite
                          ? Theme.of(context).colorScheme.onSecondary
                          : theme.textFieldColor,
                  fontSize: 11,
                ),
              ),
            ),
          )
        : SizedBox(
            height: buttonheight,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: isborder
                          ? BorderSide(
                              width: 2,
                              color: Theme.of(context).iconTheme.color!)
                          : BorderSide.none),
                ),
                backgroundColor: WidgetStatePropertyAll(backgroundcolor
                    ? currentMode
                        ? theme.settingsButtoncolor
                        : Theme.of(context).colorScheme.primary
                    : Colors.transparent),
              ),
              onPressed: onTap,
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: currentMode
                      ? Colors.lightBlueAccent
                      : colorscheme == FlexScheme.blackWhite
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).iconTheme.color,
                  fontSize: 11,
                ),
              ),
            ),
          );
  }
}
