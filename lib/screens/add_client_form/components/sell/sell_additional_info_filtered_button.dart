import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/sell_estate_data_provider.dart';
import 'package:hously_flutter/screens/add_client_form/components/sell/sell_data_components.dart';



class CrmAddAdditionalInfoFilteredButton extends ConsumerWidget {
  final String text;
  final String filterKey;

  const CrmAddAdditionalInfoFilteredButton({
    super.key,
    required this.text,
    required this.filterKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Constants for selected and unselected states
    const selectedBackgroundColor = Color.fromRGBO(200, 200, 200, 1);
    const selectedTextColor = Color.fromRGBO(35, 35, 35, 1);
    const unselectedTextColor = Color.fromRGBO(255, 255, 255, 1);

    final bool isSelected = ref.watch(
      sellOfferfilterButtonProvider.select((state) => state[filterKey] ?? false),
    );

    return InkWell(
      onTap: () {
        final filterNotifier = ref.read(sellOfferFilterCacheProvider.notifier);
        if (isSelected) {
          ref.read(sellOfferfilterButtonProvider.notifier).updateFilter(filterKey, false);
          filterNotifier.removeData(filterKey);
        } else {
          ref.read(sellOfferfilterButtonProvider.notifier).updateFilter(filterKey, true);
          filterNotifier.addData(filterKey, 'true');
        }
      },
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 120,
          minHeight: 48
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? selectedBackgroundColor : null,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? null : Border.all(color: Colors.grey),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? selectedTextColor : unselectedTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
