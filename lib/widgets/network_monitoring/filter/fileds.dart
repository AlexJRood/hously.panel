import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/search_page/filters_provider.dart';
import 'package:intl/intl.dart';

final networkMonitoringFilterButtonProvider = StateNotifierProvider<
    NetworkMonitoringFilterButtonNotifier, Map<String, dynamic>>((ref) {
  return NetworkMonitoringFilterButtonNotifier();
});

class NetworkMonitoringFilterButtonNotifier
    extends StateNotifier<Map<String, dynamic>> {
  NetworkMonitoringFilterButtonNotifier() : super({});

  void updateFilterNM(String key, dynamic value) {
    state = {...state, key: value};
  }

  void updateRangeFilterNM(String key, RangeValues values) {
    state = {...state, key: values};
  }

  void clearUiFiltersNM() {
    state = {};
  }

  void loadSavedFilters(Map<String, dynamic> savedFilters) {
    state = savedFilters;
  }
}

class NetworkMonitoringFilterButton extends ConsumerWidget {
  final String text;
  final String filterKey;
  final String filterValue;
  final double width;

  const NetworkMonitoringFilterButton({
    super.key,
    required this.text,
    required this.filterKey,
    required this.filterValue,
     this.width = 240
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isSelected = ref.watch(networkMonitoringFilterButtonProvider
        .select((state) => state[filterKey] == filterValue));
    final currentthememode = ref.watch(themeProvider);
    final selectedTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorLight
        : currentthememode == ThemeMode.light
            ? AppColors.textColorLight
            : AppColors.textColorDark;

    return InkWell(
      onTap: () {
        final filterNotifier =
            ref.read(networkMonitoringFilterCacheProvider.notifier);
        if (isSelected) {
          ref
              .read(networkMonitoringFilterButtonProvider.notifier)
              .updateFilterNM(filterKey, null);
          filterNotifier.removeFilterNM(filterKey);
        } else {
          ref
              .read(networkMonitoringFilterButtonProvider.notifier)
              .updateFilterNM(filterKey, filterValue);
          filterNotifier.addFilterNM(filterKey, filterValue);
        }
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(colors: [
                    const Color.fromRGBO(166, 215, 227, 1).withOpacity(0.25),
                    const Color.fromRGBO(87, 148, 221, 1).withOpacity(0.25),
                  ])
                : null,
            color: !isSelected ? const Color.fromRGBO(41, 41, 41, 1) : null,
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    color:  selectedTextColor )),
          ),
        ),
      ),
    );
  }
}

class NetworkMonitoringEstateTypeFilterButton extends ConsumerWidget {
  final String text;
  final String filterKey;
  final String filterValue;

  const NetworkMonitoringEstateTypeFilterButton({
    super.key,
    required this.text,
    required this.filterKey,
    required this.filterValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> selectedValues = List<String>.from(ref.watch(
        networkMonitoringFilterButtonProvider
            .select((state) => state[filterKey] ?? [])));
    final bool isSelected = selectedValues.contains(filterValue);
    final currentthememode = ref.watch(themeProvider);
    final selectedTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorLight
        : currentthememode == ThemeMode.light
            ? AppColors.textColorLight
            : AppColors.textColorDark;

    return InkWell(
      onTap: () {
        if (isSelected) {
          selectedValues.remove(filterValue);
        } else {
          selectedValues.add(filterValue);
        }
        ref
            .read(networkMonitoringFilterButtonProvider.notifier)
            .updateFilterNM(filterKey, selectedValues);
        ref
            .read(networkMonitoringFilterCacheProvider.notifier)
            .addFilterNM(filterKey, selectedValues.join(','));
      },
      child: Container(
        height: 46,
        width: 240,
        decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(colors: [
              const Color.fromRGBO(166, 215, 227, 1).withOpacity(0.25),
              const Color.fromRGBO(87, 148, 221, 1).withOpacity(0.25),
            ])
                : null,
            color: !isSelected ? const Color.fromRGBO(41, 41, 41, 1) : null,
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    color:  selectedTextColor )),
          ),
        ),
      ),
    );
  }
}

class NetworkMonitoringAdditionalInfoFilterButton extends ConsumerWidget {
  final String text;
  final String filterKey;

  const NetworkMonitoringAdditionalInfoFilterButton({
    super.key,
    required this.text,
    required this.filterKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(networkMonitoringFilterButtonProvider
        .select((state) => state[filterKey] ?? false));
    final currentthememode = ref.watch(themeProvider);

    final selectedTextColor = currentthememode == ThemeMode.system
        ? AppColors.textColorLight
        : currentthememode == ThemeMode.light
            ? AppColors.textColorLight
            : AppColors.textColorDark;

    return InkWell(
      onTap: () {
        final currentState = ref
                .read(networkMonitoringFilterButtonProvider.notifier)
                .state[filterKey] ??
            false;
        final newState = !currentState;
        ref
            .read(networkMonitoringFilterButtonProvider.notifier)
            .updateFilterNM(filterKey, newState);

        if (newState) {
          ref
              .read(networkMonitoringFilterCacheProvider.notifier)
              .addFilterNM(filterKey, 'true');
        } else {
          ref
              .read(networkMonitoringFilterCacheProvider.notifier)
              .removeFilterNM(filterKey);
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(colors: [
              const Color.fromRGBO(166, 215, 227, 1).withOpacity(0.25),
              const Color.fromRGBO(87, 148, 221, 1).withOpacity(0.25),
            ])
                : null,
            color: !isSelected ? const Color.fromRGBO(41, 41, 41, 1) : null,
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
          child: Center(
            child: Text(text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    color:  selectedTextColor)),
          ),
        ),
      ),
    );
  }
}

class BuildTextField extends ConsumerWidget {
  const BuildTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.filterKey,
  });

  final TextEditingController controller;
  final String labelText;
  final String filterKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 35.0,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          ref
              .read(networkMonitoringFilterCacheProvider.notifier)
              .addFilterNM(filterKey, value);
        },
        style:
            AppTextStyles.interMedium14dark.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: const TextStyle(color: Colors.white),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

class BuildNumberField extends ConsumerWidget {
  const BuildNumberField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.filterKey,
  });

  final TextEditingController controller;
  final String labelText;
  final String filterKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = NumberFormat('#,###');

    return SizedBox(
      height: 50.0,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          TextInputFormatter.withFunction((oldValue, newValue) {
            if (newValue.text.isEmpty) {
              return newValue.copyWith(text: '');
            }
            final int value = int.parse(newValue.text.replaceAll(',', ''));
            final String newText = formatter.format(value);
            return newValue.copyWith(
              text: newText,
              selection: TextSelection.collapsed(offset: newText.length),
            );
          }),
        ],
        style: AppTextStyles.interMedium14dark,
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: const TextStyle(color: Colors.white),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        onChanged: (value) {
          final unformattedValue = value.replaceAll(',', '');
          ref
              .read(networkMonitoringFilterCacheProvider.notifier)
              .addFilterNM(filterKey, unformattedValue);
        },
      ),
    );
  }
}

class BuildDropdownButtonFormField extends ConsumerWidget {
  const BuildDropdownButtonFormField({
    super.key,
    this.currentValue,
    required this.items,
    required this.filterKey,
    required this.labelText,
  });

  final String? currentValue;
  final List<String> items;
  final String filterKey;
  final String labelText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 50,
      width: double.infinity, // Adjust width as needed
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          const Color.fromRGBO(166, 215, 227, 1)
              .withOpacity(0.25),
          const Color.fromRGBO(87, 148, 221, 1)
              .withOpacity(0.25),
        ]),
        borderRadius: BorderRadius.circular(10), // Increased border radius
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12), // Added padding
      child: DropdownButtonFormField<String>(
        value: currentValue,
        dropdownColor: Colors.black87,
        focusColor: Colors.transparent,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppTextStyles.interMedium14dark.copyWith(
                color: Colors.white,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          ref
              .read(networkMonitoringFilterButtonProvider.notifier)
              .updateFilterNM(filterKey, newValue);
          ref
              .read(networkMonitoringFilterCacheProvider.notifier)
              .addFilterNM(filterKey, newValue);
        },
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.white70, // Adjusted label color
            fontSize: 14,
          ),
          floatingLabelStyle: const TextStyle(color: Colors.white),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          fillColor: Colors.transparent,
          filled: true,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
        iconSize: 30.0,
      ),
    );
  }
}
