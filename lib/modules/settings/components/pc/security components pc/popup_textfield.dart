import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class PopupTextfield extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode reqNode;
  final TextInputType keyboardType;

  const PopupTextfield({
    Key? key,
    required this.focusNode,
    required this.reqNode,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PopupTextfieldState();
}

class _PopupTextfieldState extends ConsumerState<PopupTextfield> {
  late FocusNode _focusNode;

  late bool _isFocused;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode;
    _isFocused = false;

    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    return Container(
      padding: EdgeInsets.all(_isFocused ? 2 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: CustomBackgroundGradients.textfieldBorder(context, ref),
      ),
      child: TextField(
        cursorColor: theme.popupcontainertextcolor,
        style: TextStyle(color: theme.popupcontainertextcolor),
        controller: widget.controller,
        focusNode: _focusNode,
        onSubmitted: (_) {
          FocusScope.of(context).requestFocus(widget.reqNode);
        },
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: theme.popupcontainertextcolor),
          labelText: widget.hintText,
          labelStyle:
              TextStyle(color: theme.popupcontainertextcolor, fontSize: 14),
          filled: true,
          fillColor:
              _isFocused ? theme.popupcontainercolor : theme.popupcontainercolor.withOpacity(0.7),
          hintStyle: TextStyle(
            color: theme.textFieldColor,
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
