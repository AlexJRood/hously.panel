import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/network_monitoring/filter/fileds.dart';

class AdditionalInfoWidget extends StatelessWidget {
  final double dynamicBoxHeightGroup; //
  final double dynamicSpace; //
  const AdditionalInfoWidget({
    required this.dynamicBoxHeightGroup,
    required this.dynamicSpace,
    super.key,
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
              child: Text('Dodatkowe informacje'.tr,
                  style: AppTextStyles.interSemiBold16
                      .copyWith(color: Theme.of(context).iconTheme.color)),
            ),
          ],
        ),
        SizedBox(height: dynamicBoxHeightGroup),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 2.5,
          ),
          itemCount: additionalFilters.length,
          itemBuilder: (context, index) {
            final filter = additionalFilters[index];
            return NetworkMonitoringAdditionalInfoFilterButton(
              text: filter['text']!,
              filterKey: filter['filterKey']!,
            );
          },
        )
      ],
    );
  }

  // Pamiętaj, aby zdefiniować metody `NetworkMonitoringAdditionalInfoFilterButton` lub zaimportować je, jeśli są w oddzielnym pliku.
}
