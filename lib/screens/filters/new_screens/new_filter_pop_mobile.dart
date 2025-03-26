import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/screens/filters/new_widgets/grid_view_additional_info.dart';
import 'package:hously_flutter/screens/filters/new_widgets/grid_view_state_type.dart';
import 'package:hously_flutter/screens/filters/new_widgets/mobile_filters_area_widget.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;
import '../../../const/filters_pop_const.dart';
import '../../../data/design/design.dart';
import '../new_widgets/custom-drop_down.dart';
import '../new_widgets/filltered_button.dart';
import '../new_widgets/key_property_button.dart';

class NewFilterPopMobile extends ConsumerWidget {
  const NewFilterPopMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownValues = ref.watch(dropdownProvider);
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    const lineSpacer = '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ';
    return Stack(
      children: [
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: AppColors.dark75,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Center(
            child: Container(
              width: screenWidth,
              height: math.max(screenHeight * 0.91, 400),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(50, 50, 50, 1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Column(
                        spacing: 12,
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
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ))
                            ],
                          ),
                          Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: FilteredButton(
                                  text: 'Na sprzedaż'.tr,
                                  filterValue: 'sell',
                                  filterKey: 'offer_type',
                                  minHeight: 48,
                                ),
                              ),
                              Expanded(
                                child: FilteredButton(
                                  text: 'Na wynajem'.tr,
                                  filterValue: 'rent',
                                  filterKey: 'offer_type',
                                  minHeight: 48,
                                ),
                              )
                            ],
                          ),
                          const Text(lineSpacer,
                            style:
                            TextStyle(color: Color.fromRGBO(90, 90, 90, 1)),
                            maxLines: 1,
                          ),
                          Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Property Type',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700),
                              ),
                              const GridViewEstateTypes(
                                  estateTypes: FilterPopConst.estateTypes),
                              Column(
                                spacing: 16,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Key Property Features',
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
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
                                    width: screenWidth,
                                    height: 46,
                                  ),
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
                                    width: screenWidth,
                                    height: 46,
                                  ),
                                  CustomDropdown(
                                    label: 'Heating type',
                                    options: FilterPopConst.heatingTypeOptions,
                                    value: dropdownValues['heatingType']!,
                                    onChanged: (newValue) {
                                      ref
                                          .read(dropdownProvider.notifier)
                                          .updateValue('heatingType', newValue!);
                                    },
                                    width: screenWidth,
                                    height: 46,
                                  ),
                                  CustomDropdown(
                                    label: 'Advertiser',
                                    options: FilterPopConst.advertiserOptions,
                                    value: dropdownValues['advertiser']!,
                                    onChanged: (newValue) {
                                      ref
                                          .read(dropdownProvider.notifier)
                                          .updateValue('advertiser', newValue!);
                                    },
                                    width: screenWidth,
                                    height: 46,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Text(lineSpacer,
                            style:
                            TextStyle(color: Color.fromRGBO(90, 90, 90, 1)),
                            maxLines: 1,
                          ),
                          const MobileFiltersAreaWidget(lineSpacer: lineSpacer),
                          const Text(lineSpacer,
                            style:
                            TextStyle(color: Color.fromRGBO(90, 90, 90, 1)),
                            maxLines: 1,
                          ),
                          Column(
                            spacing: 10,
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
                              GridViewAdditionalInfo(
                                  additionalInfo: FilterPopConst.additionalInfo)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 68,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
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
                                        color: const Color.fromRGBO(
                                            87, 148, 221, 0.2),
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
                          ),
                        ))
                  ],
                ),
              ),
            ))
      ],
    );
  }
}


