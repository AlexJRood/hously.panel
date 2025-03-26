import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/network_monitoring/filter/fileds.dart';

class OfferTypeWidget extends StatelessWidget {
  final double dynamicBoxHeightGroupSmall;
  const OfferTypeWidget({required this.dynamicBoxHeightGroupSmall, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: dynamicBoxHeightGroupSmall,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: Text('Typ oferty'.tr,
                  style: AppTextStyles.interSemiBold16
                      .copyWith(color: Theme.of(context).iconTheme.color)),
            ),
          ],
        ),
         Row(
           spacing: 8,
           children: [
             Expanded(
               child: NetworkMonitoringFilterButton(
                text: 'Na sprzedaż'.tr,
                filterValue: 'sell',
                filterKey: 'offer_type',
                       ),
             ),
             Expanded(
               child: NetworkMonitoringFilterButton(
                 text: 'Na wynajem'.tr,
                 filterValue: 'rent',
                 filterKey: 'offer_type',
               ),
             ),
           ],
         ),

      ],
    );
  }

  // Pamiętaj, aby zdefiniować metody `NetworkMonitoringFilterButton` lub zaimportować je, jeśli są w oddzielnym pliku.
}
