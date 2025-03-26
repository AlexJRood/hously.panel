import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/sell_estate_data_provider.dart';
import 'package:hously_flutter/screens/add_client_form/components/sell/sell_data_components.dart';

class CrmAddEstateTypeFilteredButton extends ConsumerWidget {
  final String text;
  final String filterKey;
  final String filterValue;

  const CrmAddEstateTypeFilteredButton({
    super.key,
    required this.text,
    required this.filterKey,
    required this.filterValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Get selected value (only one allowed)
    final List<String> selectedValues = List<String>.from(
        ref.watch(sellOfferfilterButtonProvider.select((state) => state[filterKey] ?? [])));

    final bool isSelected = selectedValues.isNotEmpty && selectedValues.first == filterValue;

    const selectedBackgroundColor = Color.fromRGBO(200, 200, 200, 1);
    const selectedTextColor = Color.fromRGBO(35, 35, 35, 1);
    const unselectedTextColor = Color.fromRGBO(255, 255, 255, 1);

    return InkWell(
      onTap: () {
        List<String> newSelection = isSelected ? [] : [filterValue]; // ✅ Only one selection allowed

        ref.read(sellOfferfilterButtonProvider.notifier).updateFilter(filterKey, newSelection);
        ref.read(sellOfferFilterCacheProvider.notifier).addData(filterKey, newSelection.join(','));
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 175, minHeight: 48),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? selectedBackgroundColor : null,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? null : Border.all(color: Colors.grey),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            maxLines: 1,
            style: TextStyle(
              color: isSelected ? selectedTextColor : unselectedTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
