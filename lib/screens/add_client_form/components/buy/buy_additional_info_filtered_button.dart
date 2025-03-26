import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/buy_filter_provider.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_from_filter_components.dart';



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
      buyOfferfilterButtonProvider.select((state) => state[filterKey] ?? false),
    );

    return InkWell(
      onTap: () {
        final filterNotifier = ref.read(buyOfferFilterCacheProvider.notifier);
        if (isSelected) {
          ref.read(buyOfferfilterButtonProvider.notifier).updateFilter(filterKey, false);
          filterNotifier.removeFilter(filterKey);
        } else {
          ref.read(buyOfferfilterButtonProvider.notifier).updateFilter(filterKey, true);
          filterNotifier.addFilter(filterKey, 'true');
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
