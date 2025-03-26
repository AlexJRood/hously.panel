import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/screens/add_client_form/provider/buy_filter_provider.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_from_filter_components.dart';

class CrmAddCustomDropdown extends StatelessWidget {
  final String label;
  final List<String> options;
  final String value;
  final void Function(String?) onChanged;
  final double height;
  final double width;

  const CrmAddCustomDropdown({
    super.key,
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E), // Matches the dark dropdown background
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: SvgPicture.asset(AppIcons.iosArrowDown, color: Color(0xFF919191)),
          dropdownColor: const Color(0xFF2C2C2E), // Matches dropdown background
          style: const TextStyle(color: Colors.white),
          onChanged: onChanged,
          items: options
              .map((option) => DropdownMenuItem(
            value: option,
            child: Text(
              option,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ))
              .toList(),
        ),
      ),
    );
  }
}

class CrmAddDropdownStateNotifier extends StateNotifier<Map<String, String>> {
  CrmAddDropdownStateNotifier()
      : super({
    'typeOfBuilding': 'Apartment',
    'buildingMaterial': 'Concrete',
    'heatingType': 'Gas',
    'advertiser': 'Agent',
  });

  void updateValue(String key, String value, WidgetRef ref) {
    state = {...state, key: value};
        final filterNotifier = ref.read(buyOfferFilterCacheProvider.notifier);
          ref.read(buyOfferfilterButtonProvider.notifier).updateFilter(key, value);
          filterNotifier.addFilter(key, value);
  }
}

// Provider for DropdownStateNotifier
final crmAddDropdownProvider =
StateNotifierProvider<CrmAddDropdownStateNotifier, Map<String, String>>(
      (ref) => CrmAddDropdownStateNotifier(),
);