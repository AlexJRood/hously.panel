import 'package:country_flags/country_flags.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:intl/intl.dart';

final isDropdownOpenProvider =
    StateNotifierProvider<DropdownNotifier, bool>((ref) => DropdownNotifier());

class DropdownNotifier extends StateNotifier<bool> {
  DropdownNotifier() : super(false);

  void openDropdown() => state = true;
  void closeDropdown() => state = false;
  void toggleDropdown() => state = !state;
}

class GradientDateDropdown extends ConsumerStatefulWidget {
  final DateTime? selectedDate;
  final String hintText;
  final bool isPc;
  final ValueChanged<DateTime?> onDateSelected;
  final String value;

  const GradientDateDropdown({
    Key? key,
    required this.isPc,
    required this.selectedDate,
    required this.hintText,
    required this.value,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _GradientDateDropdownState createState() => _GradientDateDropdownState();
}

class _GradientDateDropdownState extends ConsumerState<GradientDateDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _toggleDropdown() {
    final isDropdownOpen = ref.read(isDropdownOpenProvider);
    if (isDropdownOpen) {
      ref.read(isDropdownOpenProvider.notifier).closeDropdown();
      closeDropdown();
    } else {
      ref.read(isDropdownOpenProvider.notifier).openDropdown();
      _openDropdown();
    }
  }

  @override
  void dispose() {
    closeDropdown(); // Ensure dropdown is closed before disposing
    super.dispose();
  }

  void _openDropdown() {
    if (!mounted) return;

    final overlay = Overlay.of(context);
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 5),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: CalendarWidget(
                ref: ref,
                selectedDate: widget.selectedDate,
                onDateSelected: (value) {
                  widget.onDateSelected(value);
                  ref.read(isDropdownOpenProvider.notifier).closeDropdown();
                  closeDropdown();
                },
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);
  }

  void closeDropdown() {
    if (!mounted) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    return GestureDetector(
      onTap: _toggleDropdown,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: Container(
          height: 50,
          padding:
              const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: CustomBackgroundGradients.textFieldGradient(context, ref),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.selectedDate != null
                      ? DateFormat('dd/MM/yyyy').format(widget.selectedDate!)
                      : widget.hintText,
                  style: TextStyle(
                    color: widget.selectedDate != null
                        ? theme.themeTextColor
                        : theme.themeTextColor.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ),
              widget.isPc
                  ? Icon(Icons.arrow_drop_down, color: theme.themeTextColor)
                  : IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              widget.value,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: theme.themeTextColor),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: theme.themeTextColor,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientDropdown extends ConsumerStatefulWidget {
  final String hintText;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final bool gradientcontroller;
  final bool isPc;
  final String value;
  const GradientDropdown({
    Key? key,
    required this.isPc,
    required this.value,
    required this.hintText,
    this.gradientcontroller = true,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  _GradientDropdownState createState() => _GradientDropdownState();
}

class _GradientDropdownState extends ConsumerState<GradientDropdown> {
  @override
  Widget build(BuildContext context) {
    final colorscheme = ref.watch(colorSchemeProvider);
    final theme = ref.watch(themeColorsProvider);
    return Container(
      height: 50,
      padding: const EdgeInsets.only(right: 10, left: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: widget.gradientcontroller
              ? CustomBackgroundGradients.textFieldGradient(context, ref)
              : CustomBackgroundGradients.textFieldGradient2(context, ref)),
      child: DropdownButton<String>(
        value: widget.selectedItem,
        onChanged: widget.onChanged,
        hint: Text(
          widget.hintText,
          style: TextStyle(
              color: theme.themeTextColor.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.normal),
        ),
        icon: widget.isPc
            ? const Icon(Icons.keyboard_arrow_down_rounded)
            : IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        widget.value,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: theme.themeTextColor),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: theme.themeTextColor,
                      size: 18,
                    ),
                  ],
                ),
              ),
        iconEnabledColor: theme.themeTextColor,
        dropdownColor: ref.watch(themeColorsProvider).popupcontainercolor,
        underline: const SizedBox(),
        isExpanded: true,
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                    color: theme.popupcontainertextcolor,
                    fontWeight: FontWeight.normal),
              ));
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return widget.items.map((items) {
            return Align(
              alignment: Alignment.centerLeft,
              child: Text(
                items,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: colorscheme == FlexScheme.blackWhite
                        ? Theme.of(context).colorScheme.onSecondary
                        : theme.themeTextColor),
              ),
            );
          }).toList();
        },
      ),
    );
  }
}

class GradientDropdownCountry extends ConsumerStatefulWidget {
  final String hintText;
  final List<Map<String, String>>
      countries; // Each country has 'name' and 'countryCode'
  final String? selectedCountry;
  final bool isPc;
  final String value;
  final ValueChanged<String?> onChanged;

  const GradientDropdownCountry({
    Key? key,
    required this.isPc,
    required this.value,
    required this.hintText,
    required this.countries,
    required this.selectedCountry,
    required this.onChanged,
  }) : super(key: key);

  @override
  _GradientDropdownCountryState createState() =>
      _GradientDropdownCountryState();
}

class _GradientDropdownCountryState
    extends ConsumerState<GradientDropdownCountry> {
  @override
  Widget build(BuildContext context) {
    final colorscheme = ref.watch(colorSchemeProvider);
    final theme = ref.watch(themeColorsProvider);
    return Stack(
      children: [
        Container(height: 50,
          padding: const EdgeInsets.only(right: 10),
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
                icon: widget.isPc
                    ? const Icon(Icons.keyboard_arrow_down_rounded)
                    : IntrinsicWidth(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                widget.value,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: theme.themeTextColor),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: theme.themeTextColor,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                iconEnabledColor: ref
                    .watch(themeColorsProvider)
                    .themeTextColor
                    .withOpacity(0.8),
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
                          fontWeight: FontWeight.normal,
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
                                : theme.themeTextColor),
                      ),
                    ],
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CalendarWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final WidgetRef ref;

  const CalendarWidget({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).iconTheme.color,
      ),
      child: Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).primaryColor,
            onSurface: theme.textFieldColor,
            onPrimary: Theme.of(context).iconTheme.color!,
          ),
        ),
        child: CalendarDatePicker(
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          onDateChanged: (date) {
            onDateSelected(date);
            ref.read(isDropdownOpenProvider.notifier).closeDropdown();
          },
        ),
      ),
    );
  }
}
