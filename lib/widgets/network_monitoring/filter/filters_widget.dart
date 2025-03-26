import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/network_monitoring/filter/fileds.dart';

class FiltersWidget extends StatelessWidget {
  final TextEditingController minSquareFootageController;
  final TextEditingController maxSquareFootageController;
  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final TextEditingController minPricePerMeterController;
  final TextEditingController maxPricePerMeterController;
  final TextEditingController minRoomsController;
  final TextEditingController maxRoomsController;
  final double dynamicBoxHeightGroupSmall;
  final double dynamiSpacerBoxWidth;
  final double dynamicBoxHeightGroup;
  final double dynamicBoxHeight;
  final double dynamicSpace;
  final dynamic ref;

  const FiltersWidget({
    super.key,
    required this.minSquareFootageController,
    required this.maxSquareFootageController,
    required this.minPriceController,
    required this.maxPriceController,
    required this.minPricePerMeterController,
    required this.maxPricePerMeterController,
    required this.minRoomsController,
    required this.maxRoomsController,
    required this.dynamicBoxHeightGroupSmall,
    required this.dynamiSpacerBoxWidth,
    required this.dynamicBoxHeightGroup,
    required this.dynamicBoxHeight,
    required this.dynamicSpace,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Material(
              color: Colors.transparent,
              child: Text('Filtry'.tr,
                  style: AppTextStyles.interSemiBold16
                      .copyWith(color: Colors.white)),
            ),
          ],
        ),
        SizedBox(height: dynamicBoxHeightGroupSmall),
        IntrinsicHeight(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: BuildNumberField(
                      controller: minSquareFootageController,
                      labelText: 'Metraż od'.tr,
                      filterKey: 'min_square_footage',
                    ),
                  ),
                  SizedBox(width: dynamiSpacerBoxWidth),
                  Expanded(
                    child: BuildNumberField(
                      controller: maxSquareFootageController,
                      labelText: 'Metraż do'.tr,
                      filterKey: 'max_square_footage',
                    ),
                  ),
                ],
              ),
              SizedBox(height: dynamicBoxHeightGroup),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: BuildNumberField(
                      controller: minPriceController,
                      labelText: 'Cena od'.tr,
                      filterKey: 'min_price',
                    ),
                  ),
                  SizedBox(width: dynamiSpacerBoxWidth),
                  Expanded(
                    child: BuildNumberField(
                      controller: maxPriceController,
                      labelText: 'Cena do'.tr,
                      filterKey: 'max_price',
                    ),
                  ),
                ],
              ),
              SizedBox(height: dynamicBoxHeightGroup),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: BuildNumberField(
                      controller: minPricePerMeterController,
                      labelText: 'Cena za metr od'.tr,
                      filterKey: 'min_price_per_meter',
                    ),
                  ),
                  SizedBox(width: dynamiSpacerBoxWidth),
                  Expanded(
                    child: BuildNumberField(
                      controller: maxPricePerMeterController,
                      labelText: 'Cena za metr do'.tr,
                      filterKey: 'max_price_per_meter',
                    ),
                  ),
                ],
              ),
              SizedBox(height: dynamicBoxHeightGroup),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: BuildNumberField(
                      controller: minRoomsController,
                      labelText: 'Rok budowy od'.tr,
                      filterKey: 'min_build_year',
                    ),
                  ),
                  SizedBox(width: dynamiSpacerBoxWidth),
                  Expanded(
                    child: BuildNumberField(
                      controller: maxRoomsController,
                      labelText: 'Rok budowy do'.tr,
                      filterKey: 'max_build_year',
                    ),
                  ),
                ],
              ),
              SizedBox(height: dynamicBoxHeight),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Text(
                          'Liczba pokoi'.tr,
                          style: AppTextStyles.interMedium.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: dynamicBoxHeightGroup),
                  SizedBox(
                    height: 80,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling issues
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5, // 2 columns
                        mainAxisSpacing: 8.0, // Vertical spacing
                        crossAxisSpacing: 8.0, // Horizontal spacing
                      ),
                      itemCount: roomFilters.length,
                      itemBuilder: (context, index) {
                        final filter = roomFilters[index];
                        return NetworkMonitoringFilterButton(
                          text: filter['text']!,
                          filterValue: filter['filterValue']!,
                          filterKey: 'rooms',
                          width: 41,
                        );
                      },
                    ),
                  )

                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
