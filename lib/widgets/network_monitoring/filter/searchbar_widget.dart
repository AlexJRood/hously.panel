import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/search_page/filters_provider.dart';
import 'package:hously_flutter/widgets/network_monitoring/filter/dialog.dart'; // Import the new file

class SearchBarWidget extends ConsumerWidget {
  final TextEditingController searchController;
  final dynamic ref;
  final double dynamiSpacerBoxWidth;

  const SearchBarWidget({
    super.key,
    required this.searchController,
    required this.ref,
    required this.dynamiSpacerBoxWidth,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final textFieldColor = theme.textFieldColor;
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 35.0,
            child: TextField(
              controller: searchController,
              style: AppTextStyles.interRegular14
                  .copyWith(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Wyszukaj'.tr,
                hintStyle: const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
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
              onChanged: (value) => ref
                  .read(networkMonitoringFilterCacheProvider.notifier)
                  .setSearchQueryNM(value),
            ),
          ),
        ),
        SizedBox(width: dynamiSpacerBoxWidth),
        MaterialButton(
          onPressed: () {
            saveSearch(context, ref);
          },
          child: Row(
            children: [
              Text('',
                  style: TextStyle(color: Theme.of(context).iconTheme.color)),
              const SizedBox(width: 10),
              Icon(Icons.save, color: Theme.of(context).iconTheme.color),
            ],
          ),
        ),
      ],
    );
  }
}
