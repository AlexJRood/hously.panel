import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/network_monitoring/filter/fileds.dart';

class EstateTypeWidget extends StatelessWidget {
  final double dynamicSpace;
  final double dynamicBoxHeightGroupSmall;

  const EstateTypeWidget({
    super.key,
    required this.dynamicSpace,
    required this.dynamicBoxHeightGroupSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: Text('Rodzaj nieruchomości'.tr,
                  style: AppTextStyles.interSemiBold16
                      .copyWith(color: Theme.of(context).iconTheme.color)),
            ),
          ],
        ),
        SizedBox(height: dynamicBoxHeightGroupSmall),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            mainAxisSpacing: 8.0, // Vertical spacing
            crossAxisSpacing: 8.0, // Horizontal spacing
            childAspectRatio: 4, // Adjust height based on your button size
          ),
          itemCount: estateFilters.length,
          itemBuilder: (context, index) {
            final filter = estateFilters[index];
            return NetworkMonitoringEstateTypeFilterButton(
              text: filter['text']!.tr,
              filterValue: filter['filterValue']!,
              filterKey: 'estate_type',
            );
          },
        )
      ],
    );
  }
}
