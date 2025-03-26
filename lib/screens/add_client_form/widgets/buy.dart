import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/add_client_form/components/usercontact/user_contact_custom_text_field.dart';
import 'package:hously_flutter/screens/add_client_form/controllers/buy_controlers.dart';
import 'package:hously_flutter/screens/add_client_form/controllers/transaction_controlers.dart';
import 'package:hously_flutter/screens/add_client_form/provider/buy_filter_provider.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/transaction.dart';
import 'package:hously_flutter/screens/add_client_form/components/event/event_view_widget.dart';



import 'package:hously_flutter/screens/add_client_form/const/buy_crm_add_filters.dart';

// done
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_filltered_button.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_key_property_button.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_filters_widget.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_estate_filtered_button.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_custom_drop_down.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_additional_info_filtered_button.dart';




class BuyWidget extends ConsumerWidget {
  final GlobalKey<FormState> buyFormKey;

  final bool isMobile;

  const BuyWidget({super.key, required this.buyFormKey, this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownValues = ref.watch(crmAddDropdownProvider);    
    final buyControllers = ref.watch(buySearchControllersProvider);
    final buyOfferCache = ref.watch(buyOfferFilterCacheProvider.notifier);

    
    
    final tranactionIsSellerController = ref.watch(transactionControllersProvider);
    tranactionIsSellerController.isBuyerController.value = true;

    return Form(
      key: buyFormKey,
      child: Column(
        spacing: 20,
        children: [
          Column(
            children: [
              Container(
                height: 48,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(35, 35, 35, 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6),
                        topLeft: Radius.circular(6))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent search',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      Icon(
                        Icons.expand_more,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(50, 50, 50, 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Expanded(
                        child: UserContactCustomTextField(
                          id: 99,
                          valueKey: 'title',
                          hintText: 'Title',
                          controller: buyControllers.titleController, // Sprawdź, czy to TextEditingController
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Title cannot be empty";
                            }
                            return null;
                          },
                          onChanged: (valueKey, value) {
                            buyOfferCache.addFilter(
                              valueKey,
                              value,
                            );
                          },
                        ),
                      ),


                      const SizedBox(height: 30),



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
                                    color: Color.fromRGBO(
                                        145, 145, 145, 1)), // Add search icon
                              ),
                            ),
                          ),
                          // const SizedBox(width: 20),
                          // Row(
                          //   children: [
                          //     const Text(
                          //       'Saved Search',
                          //       style: TextStyle(
                          //           color: Color.fromRGBO(255, 255, 255, 1),
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w500),
                          //     ),
                          //     IconButton(
                          //         onPressed: () {},
                          //         icon: const Icon(
                          //           Icons.favorite_border,
                          //           color: Color.fromRGBO(255, 255, 255, 1),
                          //         ))
                          //   ],
                          // )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        spacing: 12,
                        children: [
                          CrmAddFilteredButton(
                            text: 'Na sprzedaż'.tr,
                            filterValue: 'sell',
                            filterKey: 'offer_type',
                            minHeight: 32,
                            minWidth: 120,
                          ),
                          CrmAddFilteredButton(
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
                                child: CrmAddEstateTypeFilteredButton(
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
                      if (!isMobile)
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
                                        child: CrmAddKeyPropertyButton(
                                            text: 'Primary',
                                            filterValue: 'Primary',
                                            filterKey: 'key_property'),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: CrmAddKeyPropertyButton(
                                            text: 'Secondary',
                                            filterValue: 'Secondary',
                                            filterKey: 'key_property'),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  CrmAddCustomDropdown(
                                    label: 'Type of building',
                                    options:
                                        FilterPopConst.typeOfBuildingOptions,
                                    value: dropdownValues['typeOfBuilding']!,
                                    onChanged: (newValue) {
                                      ref.read(crmAddDropdownProvider.notifier)
                                          .updateValue(
                                              'typeOfBuilding', newValue!,ref);
                                    },
                                    width: 405,
                                    height: 46,
                                  ),
                                  const SizedBox(height: 16),
                                  CrmAddCustomDropdown(
                                    label: 'Building Material',
                                    options:
                                        FilterPopConst.buildingMaterialOptions,
                                    value: dropdownValues['buildingMaterial']!,
                                    onChanged: (newValue) {
                                      ref.read(crmAddDropdownProvider.notifier)
                                          .updateValue(
                                              'buildingMaterial', newValue!,ref);
                                    },
                                    width: 405,
                                    height: 46,
                                  ),
                                  const SizedBox(height: 16),
                                  CrmAddCustomDropdown(
                                    label: 'Heating type',
                                    options: FilterPopConst.heatingTypeOptions,
                                    value: dropdownValues['heatingType']!,
                                    onChanged: (newValue) {
                                      ref.read(crmAddDropdownProvider.notifier)
                                          .updateValue(
                                              'heatingType', newValue!,ref);
                                    },
                                    width: 405,
                                    height: 46,
                                  ),
                                  const SizedBox(height: 16),
                                  CrmAddCustomDropdown(
                                    label: 'Advertiser',
                                    options: FilterPopConst.advertiserOptions,
                                    value: dropdownValues['advertiser']!,
                                    onChanged: (newValue) {
                                      ref.read(crmAddDropdownProvider.notifier)
                                          .updateValue('advertiser', newValue!,ref);                                          
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: VerticalDivider(
                                      color: Color.fromRGBO(90, 90, 90, 1),
                                      width: 13),
                                )),
                            const Expanded(
                              child: PcFiltersWidget(),
                            )
                          ],
                        ),
                      if (isMobile)
                        Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
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
                                      child: CrmAddKeyPropertyButton(
                                          text: 'Primary',
                                          filterValue: 'Primary',
                                          filterKey: 'key_property'),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: CrmAddKeyPropertyButton(
                                          text: 'Secondary',
                                          filterValue: 'Secondary',
                                          filterKey: 'key_property'),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 12),
                                CrmAddCustomDropdown(
                                  label: 'Type of building',
                                  options: FilterPopConst.typeOfBuildingOptions,
                                  value: dropdownValues['typeOfBuilding']!,
                                  onChanged: (newValue) {
                                    ref
                                        .read(crmAddDropdownProvider.notifier)
                                        .updateValue(
                                            'typeOfBuilding', newValue!,ref);
                                  },
                                  width: 405,
                                  height: 46,
                                ),
                                const SizedBox(height: 16),
                                CrmAddCustomDropdown(
                                  label: 'Building Material',
                                  options:
                                      FilterPopConst.buildingMaterialOptions,
                                  value: dropdownValues['buildingMaterial']!,
                                  onChanged: (newValue) {
                                    ref
                                        .read(crmAddDropdownProvider.notifier)
                                        .updateValue(
                                            'buildingMaterial', newValue!,ref);
                                  },
                                  width: 405,
                                  height: 46,
                                ),
                                const SizedBox(height: 16),
                                CrmAddCustomDropdown(
                                  label: 'Heating type',
                                  options: FilterPopConst.heatingTypeOptions,
                                  value: dropdownValues['heatingType']!,
                                  onChanged: (newValue) {
                                    ref.read(crmAddDropdownProvider.notifier)
                                        .updateValue('heatingType', newValue!,ref);
                                  },
                                  width: 405,
                                  height: 46,
                                ),
                                const SizedBox(height: 16),
                                CrmAddCustomDropdown(
                                  label: 'Advertiser',
                                  options: FilterPopConst.advertiserOptions,
                                  value: dropdownValues['advertiser']!,
                                  onChanged: (newValue) {
                                    ref.read(crmAddDropdownProvider.notifier)
                                        .updateValue('advertiser', newValue!,ref);
                                  },
                                  width: 405,
                                  height: 46,
                                ),
                              ],
                            ),
                            if (!isMobile)
                              const SizedBox(
                                  height: 322,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    child: VerticalDivider(
                                        color: Color.fromRGBO(90, 90, 90, 1),
                                        width: 13),
                                  )),
                            const PcFiltersWidget()
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
                                child: CrmAddAdditionalInfoFilteredButton(
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
                          
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 55,
                                width: 150,
                                color: Colors.transparent,
                                child: ElevatedButton(
                                  style: elevatedButtonStyleRounded10,
                                  onPressed:(){
                                    ref.read(buyOfferFilterCacheProvider.notifier).clearFilters(ref);
                                  }, 
                                  child: Center(
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        SvgPicture.asset(AppIcons.close),
                                        const Text("clear")
                                      ],
                                    )
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          TransactionCardWidget(
            isMobile: isMobile,
          ),
          ViewWidget(
            isMobile: isMobile,
          )
        ],
      ),
    );
  }
}
