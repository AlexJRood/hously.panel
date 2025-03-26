// Wrappers for specific use cases

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state_managers/data/filter_provider.dart';
import '../../../state_managers/data/landing_page_provider.dart';
import '../../screens/landing_page/filters_landing_page.dart';

class SelectionWidget extends ConsumerWidget {
  final String title;
  final List<String> options;
  final String? selectedOption;
  final IconData leadingIcon;
  final Function(String?) onSelect;
  final bool hasMultiTextFields;
  final bool hasSingleTextField;
  final String? hint1;
  final String? hint2;
  final void Function(String?)? onChange1;
  final void Function(String?)? onChange2;
  final TextEditingController? controller1;
  final TextEditingController? controller2;

  const SelectionWidget({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.leadingIcon,
    required this.onSelect,
    this.hasMultiTextFields = false,
    this.hasSingleTextField = false,
    this.hint1,
    this.hint2,
    this.onChange1,
    this.onChange2,
    this.controller1,
    this.controller2,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 400,
      width: 462,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color.fromRGBO(35, 35, 35, 1),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          if (hasMultiTextFields)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller1,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: hint1,
                      prefixIcon: Icon(
                        leadingIcon,
                        color: const Color.fromRGBO(145, 145, 145, 1),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(255, 255, 255, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: onChange1,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  '-',
                  style: TextStyle(
                    color: Color.fromRGBO(90, 90, 90, 1),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: hint2,
                      prefixIcon: Icon(
                        leadingIcon,
                        color: const Color.fromRGBO(145, 145, 145, 1),
                      ),
                      filled: true,
                      fillColor: const Color.fromRGBO(255, 255, 255, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: onChange2,
                  ),
                ),
              ],
            ),
          if (hasSingleTextField)
            TextField(
              controller: controller1,
              decoration: InputDecoration(
                hintText: hint1,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromRGBO(145, 145, 145, 1),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(255, 255, 255, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: onChange1,
            ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                final isSelected = option == selectedOption;

                return GestureDetector(
                  onTap: () => onSelect(isSelected ? null : option),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color.fromRGBO(233, 233, 233, 1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Container(
                        height: 32,
                        width: 32,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Center(
                          child: Icon(
                            leadingIcon,
                            color: const Color.fromRGBO(90, 90, 90, 1),
                          ),
                        ),
                      ),
                      title: Text(
                        option,
                        style: const TextStyle(
                          color: Color.fromRGBO(35, 35, 35, 1),
                        ),
                      ),
                      trailing: Icon(
                        isSelected
                            ? Icons.remove_circle_outline
                            : Icons.add_circle_outline,
                        color: const Color.fromRGBO(90, 90, 90, 1),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LocationSearchWidget extends ConsumerWidget {
  const LocationSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestedLocations = [
      'Germantown, 4949',
      'New York, 10001',
      'Los Angeles, 90001',
      'San Francisco, 94101',
      'Miami, 33101',
    ];
    final selectedLocation = ref.watch(selectedLocationProvider);

    return SelectionWidget(
      title: 'Suggested locations:',
      options: suggestedLocations,
      selectedOption: selectedLocation,
      leadingIcon: Icons.location_on,
      onSelect: (location) {
        if(location != null){
          ref.read(selectedLocationProvider.notifier).state = location;
          ref.read(isLocationVisibleProvider.notifier).state = false;
        }
      },
      hasSingleTextField: true,
    );
  }
}

class PriceRangeWidget extends ConsumerWidget {
  const PriceRangeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final priceRanges = [
      '\$0 - \$50k',
      '\$50k - \$100k',
      '\$100k - \$150k',
      '\$150k - \$200k',
      '\$200k - \$250k',
    ];
    final selectedPriceRange = ref.watch(selectedPriceRangeProvider);
    final controller1 = TextEditingController();
    final controller2 = TextEditingController();

    return SelectionWidget(
      title: 'Price range:',
      options: priceRanges,
      selectedOption: selectedPriceRange,
      leadingIcon: Icons.attach_money,
      onSelect: (priceRange) {
        if (priceRange != null) {
          try {
            final rangeParts = priceRange.split(' - ');
            final minValue = int.parse(rangeParts[0]
                .replaceAll('\$', '')
                .replaceAll('k', '000')
                .trim());
            final maxValue = int.parse(rangeParts[1]
                .replaceAll('\$', '')
                .replaceAll('k', '000')
                .trim());
            ref.read(selectedPriceRangeProvider.notifier).state = priceRange;
            ref.read(isPriceSelectedProvider.notifier).state = false;
            ref
                .read(filterCacheProvider.notifier)
                .addFilter('min_price', minValue);
            ref
                .read(filterCacheProvider.notifier)
                .addFilter('max_price', maxValue);
          } catch (e) {
            print('Error parsing price range: $e');
          }
        }
      },
      hasMultiTextFields: true,
      hint1: 'Min price',
      hint2: 'Max price',
      onChange1: (priceRange) {
        final unformattedValue = priceRange?.replaceAll(',', '');

        ref
            .read(filterCacheProvider.notifier)
            .addFilter('min_price', unformattedValue);
      },
      onChange2: (priceRange) {
        final unformattedValue = priceRange?.replaceAll(',', '');
        ref
            .read(filterCacheProvider.notifier)
            .addFilter('max_price', unformattedValue);
      },
      controller1: controller1,
      controller2: controller2,
    );
  }
}

class MeterRangeWidget extends ConsumerWidget {
  const MeterRangeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller1 = TextEditingController();
    final controller2 = TextEditingController();
    final meterRanges = [
      '0 - 50m²',
      '50 - 100m²',
      '100 - 150m²',
      '150 - 200m²',
      '200 - 250m²',
    ];
    final selectedMeterRange = ref.watch(selectedMeterRangeProvider);

    return SelectionWidget(
      title: 'Meter range:',
      options: meterRanges,
      selectedOption: selectedMeterRange,
      leadingIcon: Icons.straighten,
      onSelect: (meterRange) {
        if (meterRange != null) {
          try {
            final rangeParts = meterRange.split(' - ');
            final minValue =
                int.parse(rangeParts[0].replaceAll('m²', '').trim());
            final maxValue =
                int.parse(rangeParts[1].replaceAll('m²', '').trim());
            ref.read(selectedMeterRangeProvider.notifier).state = meterRange;
            ref.read(isSelectedMeterRangeProvider.notifier).state = false;
            ref
                .read(filterCacheProvider.notifier)
                .addFilter('min_square_footage', minValue);
            ref
                .read(filterCacheProvider.notifier)
                .addFilter('max_square_footage', maxValue);
          } catch (e) {
            print('Error parsing meter range: $e');
          }
        }
      },
      hasMultiTextFields: true,
      hint1: 'Min, m2',
      hint2: 'Max, m2',
      controller1: controller1,
      controller2: controller2,
      onChange1: (priceRange) {
        final unformattedValue = priceRange?.replaceAll(',', '');

        ref
            .read(filterCacheProvider.notifier)
            .addFilter('min_square_footage', unformattedValue);
      },
      onChange2: (priceRange) {
        final unformattedValue = priceRange?.replaceAll(',', '');

        ref
            .read(filterCacheProvider.notifier)
            .addFilter('max_square_footage', unformattedValue);
      },
    );
  }
}

class PropertyTypes extends ConsumerWidget {
  const PropertyTypes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertyTypes = [
      {'name': 'Mieszkanie', 'filterValue': 'Flat'},
      {'name': 'Kawalerka', 'filterValue': 'Studio'},
      {'name': 'Apartament', 'filterValue': 'Apartment'},
      {'name': 'Dom jednorodzinny', 'filterValue': 'House'},
      {'name': 'Bliźniak', 'filterValue': 'Twin house'},
      {'name': 'Szeregowiec', 'filterValue': 'Row house'},
      {'name': 'Inwestycje', 'filterValue': 'Invest'},
      {'name': 'Działki', 'filterValue': 'Lot'},
      {'name': 'Lokale użytkowe', 'filterValue': 'Commercial'},
      {'name': 'Hale i magazyny', 'filterValue': 'Warehouse'},
      {'name': 'Pokoje', 'filterValue': 'Room'},
      {'name': 'Garaże', 'filterValue': 'Garage'},
    ];

    // Extract property names for the options
    final propertyNames = propertyTypes.map((e) => e['name']!).toList();

    final selectedProperty = ref.watch(selectedPropertyProvider);

    return SelectionWidget(
      title: 'Choose property type:',
      options: propertyNames, // Pass only property names
      selectedOption: selectedProperty,
      leadingIcon: Icons.house_outlined,
      onSelect: (propertyName) {
        if (propertyName != null) {
          // Find the filter value corresponding to the selected property name
          final filterValue = propertyTypes.firstWhere(
                (element) => element['name'] == propertyName,
            orElse: () => {'filterValue': ''}, // Default empty filterValue
          )['filterValue'];

          // Update selectedPropertyType directly with filterValue
          if (filterValue != null && filterValue.isNotEmpty) {
            ref.read(selectedPropertyProvider.notifier).state = filterValue;
            ref.read(isPropertyVisibleProvider.notifier).state = false;
            ref
                .read(filterButtonProvider.notifier)
                .updateFilter('estate_type', filterValue);
            ref
                .read(filterCacheProvider.notifier)
                .addFilter('estate_type', filterValue);
          }
        }
      },
    );
  }
}
