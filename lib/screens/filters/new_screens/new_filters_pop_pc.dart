import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/filters_pop_const.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/filters/new_widgets/estate_filtered_button.dart';
import 'package:hously_flutter/screens/filters/new_widgets/filltered_button.dart';
import 'package:hously_flutter/screens/filters/new_widgets/pc_filters_widget.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import '../new_widgets/additional_info_filtered_button.dart';
import '../new_widgets/custom-drop_down.dart';
import '../new_widgets/key_property_button.dart';

class NewFiltersPopPc extends ConsumerWidget {
  const NewFiltersPopPc({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownValues = ref.watch(dropdownProvider);
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Stack(
      children: [
        Center(
          child: Container(
            width: math.max(screenWidth * 0.7, 450),
            height: math.max(screenHeight * 0.91, 400),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(50, 50, 50, 1),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                                color: Colors.white), // For text color
                            cursorColor: Colors.white, // Cursor color
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(45, 45, 45,
                                  1), // Match the dark background color
                              hintText:
                              'Search region, suburb or postcode', // Add placeholder text
                              hintStyle: const TextStyle(
                                  color: Color.fromRGBO(145, 145, 145, 1),
                                  fontSize: 14), // Placeholder text color
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Rounded corners
                                borderSide: BorderSide.none, // No border
                              ),
                              suffixIcon: SvgPicture.asset(AppIcons.search,
                                  height: 18,
                                  width: 18,
                                  color: const Color.fromRGBO(
                                      145, 145, 145, 1)), // Add search icon
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            const Text(
                              'Saved Search',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      spacing: 12,
                      children: [
                        FilteredButton(
                          text: 'Na sprzedaż'.tr,
                          filterValue: 'sell',
                          filterKey: 'offer_type',
                          minHeight: 32,
                          minWidth: 120,
                        ),
                        FilteredButton(
                          text: 'Na wynajem'.tr,
                          filterValue: 'rent',
                          filterKey: 'offer_type',
                          minHeight: 32,
                          minWidth: 120,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Property Type',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          alignment: WrapAlignment
                              .start, // Align children to the start
                          spacing: 12, // Horizontal spacing
                          runSpacing: 12, // Vertical spacing
                          children:
                          FilterPopConst.estateTypes.map((estateType) {
                            return ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 120, // Minimum width for buttons
                                maxWidth: 180, // Maximum width for buttons
                              ),
                              child: EstateTypeFilteredButton(
                                text: estateType['text']!.tr,
                                filterValue: estateType['filterValue']!,
                                filterKey: 'estate_type',
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Key Property Features',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 12),
                              const Row(
                                children: [
                                  Expanded(
                                    child: KeyPropertyButton(
                                        text: 'Primary',
                                        filterValue: 'Primary',
                                        filterKey: 'key_property'),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: KeyPropertyButton(
                                        text: 'Secondary',
                                        filterValue: 'Secondary',
                                        filterKey: 'key_property'),
                                  )
                                ],
                              ),
                              const SizedBox(height: 12),
                              CustomDropdown(
                                label: 'Type of building',
                                options: FilterPopConst.typeOfBuildingOptions,
                                value: dropdownValues['typeOfBuilding']!,
                                onChanged: (newValue) {
                                  ref
                                      .read(dropdownProvider.notifier)
                                      .updateValue(
                                      'typeOfBuilding', newValue!);
                                },
                                width: 405,
                                height: 46,
                              ),
                              const SizedBox(height: 16),
                              CustomDropdown(
                                label: 'Building Material',
                                options:
                                FilterPopConst.buildingMaterialOptions,
                                value: dropdownValues['buildingMaterial']!,
                                onChanged: (newValue) {
                                  ref
                                      .read(dropdownProvider.notifier)
                                      .updateValue(
                                      'buildingMaterial', newValue!);
                                },
                                width: 405,
                                height: 46,
                              ),
                              const SizedBox(height: 16),
                              CustomDropdown(
                                label: 'Heating type',
                                options: FilterPopConst.heatingTypeOptions,
                                value: dropdownValues['heatingType']!,
                                onChanged: (newValue) {
                                  ref
                                      .read(dropdownProvider.notifier)
                                      .updateValue('heatingType', newValue!);
                                },
                                width: 405,
                                height: 46,
                              ),
                              const SizedBox(height: 16),
                              CustomDropdown(
                                label: 'Advertiser',
                                options: FilterPopConst.advertiserOptions,
                                value: dropdownValues['advertiser']!,
                                onChanged: (newValue) {
                                  ref
                                      .read(dropdownProvider.notifier)
                                      .updateValue('advertiser', newValue!);
                                },
                                width: 405,
                                height: 46,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            height: 322,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: VerticalDivider(
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                  width: 13),
                            )),
                        const Expanded(
                          child:PcFiltersWidget() ,
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Additional Features',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        Wrap(
                          alignment: WrapAlignment
                              .start, // Align children to the start
                          spacing: 12, // Horizontal spacing
                          runSpacing: 12, // Vertical spacing
                          children: FilterPopConst.additionalInfo
                              .map((additionalInfo) {
                            return ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 120, // Minimum width for buttons
                                maxWidth: 180, // Maximum width for buttons
                              ),
                              child: AdditionalInfoFilteredButton(
                                text: additionalInfo['text']!.tr,
                                filterKey: additionalInfo['filterKey']!,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 48,
                          width: 152,
                          color: Colors.transparent,
                          child: const Center(
                            child: Text(
                              'Advanced filters',
                              style: TextStyle(
                                  color: AppColors.light,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 48,
                              width: 55,
                              color: Colors.transparent,
                              child: const Center(
                                child: Text('Clear',
                                    style: TextStyle(
                                      color: AppColors.light50,
                                    )),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              height: 48,
                              width: 65,
                              decoration: BoxDecoration(
                                  color:
                                  const Color.fromRGBO(87, 148, 221, 0.2),
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Center(
                                child: Text('Search',
                                    style: TextStyle(
                                      color: AppColors.light50,
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
