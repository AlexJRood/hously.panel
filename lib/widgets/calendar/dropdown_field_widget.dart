import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class DropDownWidget<T> extends ConsumerWidget {
  const DropDownWidget({
    super.key,
    this.texts = const [],
    this.values = const [],
    this.currentValue,
    this.decoration,
    this.onChanged,
    this.isExpanded,
    this.isDense = false,
    this.hasUnderLine = false,
  });

  final InputDecoration? decoration;
  final List<String> texts;
  final List<T> values;
  final T? currentValue;
  final ValueChanged<T?>? onChanged;
  final bool? isExpanded;
  final bool hasUnderLine;
  final bool isDense;

  @override
  Widget build(BuildContext context, WidgetRef ref) => hasUnderLine
      ? DropdownWidget(
          currentValue: currentValue,
          onChanged: onChanged,
          isExpanded: isExpanded,
          decoration: decoration,
          values: values,
          texts: texts,
          isDense: isDense,
        )
      : DropdownButtonHideUnderline(
          child: DropdownWidget(
            currentValue: currentValue,
            onChanged: onChanged,
            isExpanded: isExpanded,
            decoration: decoration,
            values: values,
            texts: texts,
            isDense: isDense,
          ),
        );
}

class DropdownWidget<T> extends ConsumerWidget {
  const DropdownWidget({
    super.key,
    required this.currentValue,
    required this.onChanged,
    required this.isExpanded,
    required this.decoration,
    required this.values,
    required this.texts,
    required this.isDense,
  });

  final T? currentValue;
  final ValueChanged<T?>? onChanged;
  final bool? isExpanded;
  final bool isDense;
  final InputDecoration? decoration;
  final List values;
  final List<String> texts;

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return DropdownButtonFormField<T>(
      borderRadius: BorderRadius.circular(8),
      value: currentValue,
      padding: EdgeInsets.zero,
      alignment: Alignment.centerLeft,
      isDense: isDense,
      onChanged: (value) {
        FocusScope.of(context).unfocus();
        onChanged?.call(value);
      },
      elevation: 0,
      dropdownColor: Theme.of(context).iconTheme.color!,
      //focusColor: Colors.white,
      isExpanded: isExpanded ?? true,
      decoration: decoration ??
          InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: true,
            fillColor: theme.fillColor,
          ),
      autofocus: false,
      iconSize: 25,
      icon: Icon(
        Icons.arrow_drop_down,
        color: theme.textFieldColor,
      ),
      items: List.generate(values.length, (index) {
        return DropdownMenuItem<T>(
          value: values[index],
          alignment: Alignment.centerLeft,
          child: Text(
            texts[index],
            style: TextStyle(fontSize: 16, color: theme.textFieldColor),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        );
      }),
    );
  }
}
