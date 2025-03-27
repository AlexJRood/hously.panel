import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.text,
    this.onFieldSubmitted,
    this.onTapped,
    this.hintText,
    this.dateOnPressed,
    this.onEditingComplete,
    this.ref,
    this.timeOnPressed,
    this.isSearch = false,
    this.readOnly = false,
    this.isRequired = false,
    this.maxLines = 1,
    this.border,
    this.inputFormatters,
    this.validator,
    this.autoValidationMode,
    this.onChanged,
    this.textInputType,
    this.suffixIcon,
    this.prefix,
    this.obscureText = false,
    this.autoFocus = false,
    this.contentPadding,
    this.inputDecoration,
    this.clearController,
    this.hintStyle,
    this.filledColor,
    this.textAlign = TextAlign.start,
    this.style = const TextStyle(color: Colors.black),
  });

  final String text;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTapped;
  final String? hintText;
  final VoidCallback? dateOnPressed;
  final VoidCallback? timeOnPressed;
  final VoidCallback? onEditingComplete;
  final WidgetRef? ref;
  final bool isSearch;
  final bool readOnly;
  final bool isRequired;
  final bool obscureText;
  final bool autoFocus;
  final EdgeInsetsGeometry? contentPadding;
  final int maxLines;
  final InputBorder? border;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidationMode;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Function? clearController;
  final InputDecoration? inputDecoration;
  final TextStyle? hintStyle;
  final Color? filledColor;
  final TextAlign textAlign;
  final TextStyle style;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
    late TextEditingController controller;
    final focusNode = FocusNode();

    @override
    void initState() {
      super.initState();

      controller = TextEditingController(text: widget.text);
      if (widget.autoFocus) focusNode.requestFocus();
    }

    @override
    void didUpdateWidget(covariant TextFormFieldWidget oldWidget) {
      super.didUpdateWidget(oldWidget);

      if (oldWidget.text != widget.text && !focusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => controller.text = widget.text,
        );
      }

      if (widget.clearController != null) {
        widget.clearController!(() => clearTextField());
      }
    }

    void clearTextField() {
      controller.clear();
    }

  @override
  Widget build(BuildContext context) => TextFormField(
        onChanged: widget.onChanged,
        autovalidateMode: widget.autoValidationMode,
        style: widget.style,
        readOnly: widget.readOnly,
        maxLines: widget.maxLines,
        focusNode: focusNode,
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
        onEditingComplete: widget.onEditingComplete,
        textAlign: widget.textAlign,
        decoration: widget.inputDecoration ??
            InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              filled: true,
              fillColor: widget.filledColor ?? Colors.white,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefix,
              contentPadding: widget.contentPadding,
            ),
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator,
        controller: controller,
        inputFormatters: widget.inputFormatters,
        onTap: widget.onTapped,
      );
}
