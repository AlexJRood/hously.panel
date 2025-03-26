import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/provider/sell_estate_data_provider.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_from_filter_components.dart';

class CrmAddFilteredButton extends ConsumerWidget {
  final String text;
  final String filterKey;
  final String filterValue;
  final double? minHeight;
  final double? minWidth;
  final AlignmentGeometry? alignment;

  const CrmAddFilteredButton({
    super.key,
    required this.text,
    required this.filterKey,
    required this.filterValue,
    this.minHeight,
    this.minWidth,
    this.alignment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const selectedBackgroundColor = Color.fromRGBO(200, 200, 200, 1);
    const selectedTextColor = Color.fromRGBO(35, 35, 35, 1);

    const unselectedTextColor = Color.fromRGBO(255, 255, 255, 1);
    final bool isSelected = ref.watch(buyOfferfilterButtonProvider
        .select((state) => state[filterKey] == filterValue));

    return InkWell(
      onTap: () {
        final filterNotifier = ref.read(sellOfferFilterCacheProvider.notifier);
        if (isSelected) {
          ref.read(buyOfferfilterButtonProvider.notifier).updateFilter(filterKey, null);
          filterNotifier.removeData(filterKey);
        } else {
          ref
              .read(buyOfferfilterButtonProvider.notifier)
              .updateFilter(filterKey, filterValue);
          filterNotifier.addData(filterKey, filterValue);
        }
      },
      child: Container(
        constraints: (minHeight != null || minWidth != null)
            ? BoxConstraints(
          minHeight: minHeight ?? 0,
          minWidth: minWidth ?? 0,
        )
            : null,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        alignment: alignment ?? Alignment.centerLeft,
        decoration: BoxDecoration(
          color: isSelected ? selectedBackgroundColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.grey : Colors.grey,
          ),
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
