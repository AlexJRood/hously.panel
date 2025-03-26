import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:country_code_picker/country_code_picker.dart';

class GradientTextFieldMobile extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final bool isObscure;
  final FocusNode reqNode;
  final TextInputType keyboardType;
  final String value;
  final bool isSuffix;
  const GradientTextFieldMobile({
    Key? key,
    required this.focusNode,
    this.isSuffix = true,
    this.isObscure = false,
    required this.value,
    required this.reqNode,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  _GradientTextFieldMobileState createState() =>
      _GradientTextFieldMobileState();
}

class _GradientTextFieldMobileState
    extends ConsumerState<GradientTextFieldMobile> {
  late FocusNode _focusNode;
  late bool _isFocused;
  late bool _obscureText; // New state for toggling password visibility

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode;
    _isFocused = false;
    _obscureText = widget.isObscure; // Initialize with given obscure state

    _focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    if (_focusNode != widget.focusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    final colorscheme = ref.watch(colorSchemeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
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
          obscureText: _obscureText, // Use state to toggle text visibility
          onSubmitted: (_) {
            FocusScope.of(context).requestFocus(widget.reqNode);
          },
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            suffixIcon: widget.isSuffix
                ? widget.isObscure
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility, // Change icon based on state
                          color: _isFocused
                              ? theme.whitewhiteblack
                              : colorscheme == FlexScheme.blackWhite
                                  ? Theme.of(context).colorScheme.onSecondary
                                  : theme.themeTextColor,
                        ),
                        onPressed: _toggleObscureText, // Toggle visibility
                      )
                    : IntrinsicWidth(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                widget.value,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: _isFocused
                                      ? theme.whitewhiteblack
                                      : colorscheme == FlexScheme.blackWhite
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                          : theme.themeTextColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: _isFocused
                                  ? theme.whitewhiteblack
                                  : colorscheme == FlexScheme.blackWhite
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                      : theme.themeTextColor,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                      )
                : const SizedBox(),
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
      ),
    );
  }
}

/// A mapping of dial codes to ISO country codes (for demo purposes).

/// A mapping of dial codes to ISO country codes (for demo purposes).

class GradientPhoneNumberTwoFields extends ConsumerStatefulWidget {
  final TextEditingController countryCodeController;
  final TextEditingController phoneNumberController;
  final FocusNode countryCodeFocus;
  final FocusNode phoneNumberFocus;
  final String value;
  final bool isSuffix;

  /// Optional hint texts
  final String countryCodeHint;
  final String phoneNumberHint;

  /// Whether the phone number should be obscure (like a password).
  final bool isObscure;

  const GradientPhoneNumberTwoFields({
    Key? key,
    required this.isSuffix,
    required this.value,
    required this.countryCodeController,
    required this.phoneNumberController,
    required this.countryCodeFocus,
    required this.phoneNumberFocus,
    this.countryCodeHint = 'Code',
    this.phoneNumberHint = 'Phone',
    this.isObscure = false,
  }) : super(key: key);

  @override
  _GradientPhoneNumberTwoFieldsState createState() =>
      _GradientPhoneNumberTwoFieldsState();
}

class _GradientPhoneNumberTwoFieldsState
    extends ConsumerState<GradientPhoneNumberTwoFields> {
  CountryCode? _selectedCountry;
  late FocusNode _phonefocus;
  late FocusNode _country;
  bool _isCountryCodeFocused = false;

  bool _isPhoneNumberFocused = false;

  @override
  void initState() {
    super.initState();

    _phonefocus = widget.phoneNumberFocus;
    _country = widget.countryCodeFocus;

    _phonefocus.addListener(_onFocusChangephone);

    _country.addListener(_onFocusChangecountry);

    widget.countryCodeController.addListener(_handleCountryCodeChange);
    if (widget.countryCodeController.text == "+1") {
      _selectedCountry = CountryCode.fromCountryCode('US'); // Default to US\
    } else {
      _selectedCountry =
          CountryCode.fromDialCode(widget.countryCodeController.text);
    }
  }

  @override
  void dispose() {
    widget.countryCodeFocus.removeListener(_onFocusChangephone);
    widget.phoneNumberFocus.removeListener(_onFocusChangecountry);
    widget.countryCodeController.removeListener(_handleCountryCodeChange);
    super.dispose();
  }

  void _onFocusChangephone() {
    if (mounted) {
      setState(() {
        _isPhoneNumberFocused = _phonefocus.hasFocus;
      });
    }
  }

  void _onFocusChangecountry() {
    if (mounted) {
      setState(() {
        _isCountryCodeFocused = _country.hasFocus;
      });
    }
  }

  void _handleCountryCodeChange() {
    final typedCode = widget.countryCodeController.text;
    for (final country in countries) {
      if (country['dialCode'] == typedCode) {
        setState(() {
          // Use the 'flag' key which represents the ISO country code
          _selectedCountry = CountryCode.fromCountryCode(country['flag']!);
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    final colorScheme = ref.watch(colorSchemeProvider);
    final screenwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: CustomBackgroundGradients.textFieldGradient(context, ref),
        ),
        child: Row(
          children: [
            Container(
              width: 110,
              child: TextField(
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(widget.phoneNumberFocus);
                },
                maxLength: 4,
                controller: widget.countryCodeController,
                focusNode: widget.countryCodeFocus,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _isCountryCodeFocused
                      ? theme.whitewhiteblack
                      : colorScheme == FlexScheme.blackWhite
                          ? Theme.of(context).colorScheme.onSecondary
                          : theme.themeTextColor,
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  counterStyle: const TextStyle(
                    height: double.minPositive,
                  ),
                  counterText: "",
                  prefixIcon: _selectedCountry != null
                      ? CountryCodePicker(
                          dialogSize: Size(screenwidth * 0.8, double.infinity),
                          favorite: ['US', 'IN', 'GB', 'PL'],
                          margin: const EdgeInsets.all(0),
                          showOnlyCountryWhenClosed: true,
                          closeIcon: Icon(
                            Icons.close,
                            color: theme.whitewhiteblack,
                          ),

                          emptySearchBuilder: (context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "No Country Found",
                                  style:
                                      TextStyle(color: theme.whitewhiteblack),
                                ),
                              ],
                            );
                          },
                          searchStyle: TextStyle(color: theme.whitewhiteblack),
                          textStyle: TextStyle(color: theme.whitewhiteblack),
                          dialogTextStyle:
                              TextStyle(color: theme.whitewhiteblack),
                          dialogBackgroundColor: theme.popupcontainercolor,
                          barrierColor: Colors.transparent,
                          backgroundColor: theme.popupcontainercolor,
                          padding: const EdgeInsets.all(0),
                          enabled: true,
                          initialSelection: _selectedCountry?.code,
                          showCountryOnly: false,
                          onChanged: (value) {
                            setState(() {
                              _selectedCountry = value;
                              widget.countryCodeController.text =
                                  _selectedCountry!.dialCode!;
                            });
                          },
                          alignLeft: false,
                          flagWidth: 25,
                          hideMainText: true,
                          // Use the standard dialog style:
                          pickerStyle: PickerStyle.dialog,
                          // Use a standard search decoration:
                          searchDecoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(0),
                            fillColor: theme.settingsMenutile,
                            filled: true,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            hintText: "Search",
                            hintStyle:
                                TextStyle(color: theme.popupcontainertextcolor),
                            prefixIcon: Icon(Icons.search,
                                color: theme.popupcontainertextcolor),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          // Standard dialog item padding:
                          dialogItemPadding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          // Standard header for the dialog:
                          headerText: "Select Country",
                          headerTextStyle: TextStyle(
                            fontSize: 18,
                            color: theme.whitewhiteblack,
                            fontWeight: FontWeight.bold,
                          ),
                          // Ensure the search field is visible:
                          hideSearch: false,
                          // Show the close icon for a clean close action:
                          hideCloseIcon: false,
                        )
                      : null,
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  hintText: widget.countryCodeHint,
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: _isCountryCodeFocused
                      ? theme.gradienttextfillcolor
                      : Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 1,
              color: Colors.grey[400],
              margin: const EdgeInsets.symmetric(horizontal: 4),
            ),
            Expanded(
              child: TextField(
                controller: widget.phoneNumberController,
                focusNode: widget.phoneNumberFocus,
                keyboardType: TextInputType.phone,
                cursorColor: theme.popupcontainertextcolor,
                style: TextStyle(
                  color: _isPhoneNumberFocused
                      ? theme.whitewhiteblack
                      : colorScheme == FlexScheme.blackWhite
                          ? Theme.of(context).colorScheme.onSecondary
                          : theme.themeTextColor,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  // suffixIcon: widget.isSuffix
                  //     ? IntrinsicWidth(
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 widget.value,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 style: TextStyle(
                  //                   color: _isPhoneNumberFocused
                  //                       ? theme.whitewhiteblack
                  //                       : colorScheme == FlexScheme.blackWhite
                  //                           ? Theme.of(context)
                  //                               .colorScheme
                  //                               .onSecondary
                  //                           : theme.themeTextColor,
                  //                 ),
                  //               ),
                  //             ),
                  //             const SizedBox(width: 5),
                  //             Icon(
                  //               Icons.arrow_forward_ios_outlined,
                  //               color: _isPhoneNumberFocused
                  //                   ? theme.whitewhiteblack
                  //                   : colorScheme == FlexScheme.blackWhite
                  //                       ? Theme.of(context)
                  //                           .colorScheme
                  //                           .onSecondary
                  //                       : theme.themeTextColor,
                  //               size: 18,
                  //             ),
                  //             const SizedBox(width: 5),
                  //           ],
                  //         ),
                  //       )
                  //     : SizedBox(),
                  labelText: widget.phoneNumberHint,
                  labelStyle:
                      TextStyle(color: theme.themeTextColor, fontSize: 14),
                  filled: true,
                  fillColor: _isPhoneNumberFocused
                      ? theme.gradienttextfillcolor
                      : Colors.transparent,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  floatingLabelStyle: TextStyle(
                    color: _isPhoneNumberFocused
                        ? theme.whitewhiteblack
                        : colorScheme == FlexScheme.blackWhite
                            ? Theme.of(context).colorScheme.onSecondary
                            : theme.themeTextColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
