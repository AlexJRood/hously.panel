import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';

import 'package:hously_flutter/screens/add_client_form/const/sell_crm_add_filters.dart';
import 'package:hously_flutter/screens/add_client_form/components/sell/sell_estate_filtered_button.dart';
import 'package:hously_flutter/screens/add_client_form/components/sell/sell_additional_info_filtered_button.dart';
import 'package:hously_flutter/screens/add_client_form/components/sell/sell_add_filltered_button.dart';
import 'package:hously_flutter/screens/add_client_form/components/sell/sell_custom_drop_down.dart';
import 'package:hously_flutter/screens/add_client_form/components/sell/sell_custom_text_field.dart';
import 'package:hously_flutter/screens/add_client_form/components/sell/advertisment_information_image_widget.dart';
import 'package:hously_flutter/screens/add_client_form/controllers/sell_controlers.dart';
import 'package:hously_flutter/screens/add_client_form/controllers/transaction_controlers.dart';


import 'package:hously_flutter/screens/add_client_form/provider/send_form_provider.dart';
import 'package:hously_flutter/screens/add_client_form/provider/sell_estate_data_provider.dart';


import 'package:hously_flutter/screens/add_client_form/widgets/transaction.dart';
import 'package:hously_flutter/screens/add_client_form/components/event/event_view_widget.dart';



class SellWidget extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final bool isMobile;
  const SellWidget({
    super.key,
    required this.formKey,
    this.isMobile = false,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addClientForm = ref.watch(addClientFormProvider);
    final addClientFormNotifier = ref.read(addClientFormProvider.notifier);
    final sellControllers = ref.watch(sellControllersProvider);
    
    final tranactionIsSellerController = ref.watch(transactionControllersProvider);
    tranactionIsSellerController.isSellerController.value = true;
    

    return Form(
      key: formKey,
      child: Column(
        spacing: 20,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(50, 50, 50, 1),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Column(
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
                          'Advertisment Information',
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
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 12,
                    children: [
                      const Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Photos',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          AdvertisementInformationImageWidget()
                        ],
                      ),
                      Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Type of offer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
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
                        ],
                      ),
                      Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'General Information',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          SellCustomTextField(
                            id: 10,
                            valueKey: 'title',
                            hintText: 'Add title',
                            controller: sellControllers.titleController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Title cannot be empty";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              addClientFormNotifier.updateTextField(
                                sellControllers.titleController,
                                value,
                              );
                            },
                          ),
                          SellCustomTextField(
                            id: 11,
                            valueKey: 'description',
                            hintText: 'Description',
                            controller: sellControllers.descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Description be empty";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              addClientFormNotifier.updateTextField(
                                sellControllers.descriptionController,
                                value,
                              );
                            },
                          ),
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
                                children: FilterPopConst.estateTypes
                                    .map((estateType) {
                                  return ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth:
                                          120, // Minimum width for buttons
                                      maxWidth:
                                          180, // Maximum width for buttons
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
                          Column(
                            spacing: 12,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Location',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Row(
                                spacing: 12,
                                children: [
                                  Expanded(
                                      child: AddClientFormCustomDropDown(
                                    options: [
                                      'option 1',
                                      'option 2',
                                      'option 3'
                                    ],
                                    valueKey: 'country',
                                    hintText: 'Country',
                                    id: 10,
                                  )),
                                  Expanded(
                                      child: AddClientFormCustomDropDown(
                                    options: [
                                      'option 1',
                                      'option 2',
                                      'option 3'
                                    ],
                                    valueKey: 'state',
                                    hintText: 'State',
                                    id: 11,
                                  )),
                                ],
                              ),
                              Row(
                                spacing: 12,
                                children: [
                                  const Expanded(
                                      child: AddClientFormCustomDropDown(
                                    options: [
                                      'option 1',
                                      'option 2',
                                      'option 3'
                                    ],
                                    valueKey: 'city',
                                    hintText: 'City',
                                    id: 12,
                                  )),
                                  Expanded(
                                    child: SellCustomTextField(
                                      id: 15,
                                      valueKey: 'street',
                                      hintText: 'Street Address',
                                      controller:
                                          sellControllers.streetController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Address be empty";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        addClientFormNotifier.updateTextField(
                                          sellControllers.streetController,
                                          value,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 12,
                                children: [
                                  Expanded(
                                    child: SellCustomTextField(
                                      id: 16,
                                      valueKey: 'postal_code',
                                      hintText: 'Zipcode',
                                      controller: sellControllers.zipcodeController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Zipcode be empty";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {

                                      },
                                    ),
                                  ),
                                  const Expanded(
                                      child: AddClientFormCustomDropDown(
                                    options: [
                                      'option 1',
                                      'option 2',
                                      'option 3'
                                    ],
                                    valueKey: 'distance_filter',
                                    hintText: 'Distance Filter',
                                    id: 13,
                                  )),
                                ],
                              ),
                            ],
                          ),
                          const Column(
                            spacing: 12,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Key Property Features',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                spacing: 12,
                                children: [
                                  Expanded(
                                      child: AddClientFormCustomDropDown(
                                    options: [
                                      'option 1',
                                      'option 2',
                                      'option 3'
                                    ],
                                    valueKey: 'building_type',
                                    hintText: 'Type of building',
                                    id: 14,
                                  )),
                                  Expanded(
                                      child: AddClientFormCustomDropDown(
                                    options: [
                                      'option 1',
                                      'option 2',
                                      'option 3'
                                    ],
                                    valueKey: 'building_material',
                                    hintText: 'Building Material',
                                    id: 15,
                                  )),
                                ],
                              ),
                              Row(
                                spacing: 12,
                                children: [
                                  Expanded(
                                      child: AddClientFormCustomDropDown(
                                    options: [
                                      'option 1',
                                      'option 2',
                                      'option 3'
                                    ],
                                    valueKey: 'heating_type',
                                    hintText: 'Heating type',
                                    id: 16,
                                  )),
                                  Expanded(
                                      child: AddClientFormCustomDropDown(
                                    options: [
                                      'option 1',
                                      'option 2',
                                      'option 3'
                                    ],
                                    valueKey: 'build_year',
                                    hintText: 'Build Year',
                                    id: 17,
                                  )),
                                ],
                              ),
                              Row(
                                spacing: 12,
                                children: [
                                  Expanded(
                                      child: AddClientFormCustomDropDown(
                                    options: [
                                      'option 1',
                                      'option 2',
                                      'option 3'
                                    ],
                                    valueKey: 'square_footage',
                                    hintText: 'Floor area, m2',
                                    id: 18,
                                  )),
                                  Expanded(
                                      child: AddClientFormCustomDropDown(
                                    options: [
                                      'option 1',
                                      'option 2',
                                      'option 3'
                                    ],
                                    valueKey: 'floor',
                                    hintText: 'Floor/Level',
                                    id: 19,
                                  )),
                                ],
                              ),
                            ],
                          ),
                          if (isMobile)
                            const Column(
                              spacing: 12,
                              children: [
                                Column(
                                  spacing: 12,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bedrooms',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1)),
                                    ),
                                    Row(
                                      spacing: 8,
                                      children: [
                                        CrmAddFilteredButton(
                                          text: 'Any',
                                          filterValue: 'any',
                                          filterKey: 'bedrooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '1',
                                          filterValue: '1',
                                          filterKey: 'rooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '2',
                                          filterValue: '2',
                                          filterKey: 'rooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '3',
                                          filterValue: '3',
                                          filterKey: 'rooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '4',
                                          filterValue: '4',
                                          filterKey: 'rooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '5',
                                          filterValue: '5',
                                          filterKey: 'rooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '6+',
                                          filterValue: '6+',
                                          filterKey: 'rooms',
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  spacing: 12,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bathrooms',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1)),
                                    ),
                                    Row(
                                      spacing: 8,
                                      children: [
                                        CrmAddFilteredButton(
                                          text: 'Any',
                                          filterValue: 'any',
                                          filterKey: 'bedrooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '1',
                                          filterValue: '1',
                                          filterKey: 'bedrooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '2',
                                          filterValue: '2',
                                          filterKey: 'bedrooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '3',
                                          filterValue: '3',
                                          filterKey: 'bedrooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '4',
                                          filterValue: '4',
                                          filterKey: 'bedrooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '5',
                                          filterValue: '5',
                                          filterKey: 'bedrooms',
                                        ),
                                        CrmAddFilteredButton(
                                          text: '6+',
                                          filterValue: '6+',
                                          filterKey: 'bedrooms',
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          if (!isMobile)
                            const Row(
                              spacing: 12,
                              children: [
                                Expanded(
                                  child: Column(
                                    spacing: 12,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bedrooms',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1)),
                                      ),
                                      Row(
                                        spacing: 8,
                                        children: [
                                          CrmAddFilteredButton(
                                            text: 'Any',
                                            filterValue: 'any',
                                            filterKey: 'bedrooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '1',
                                            filterValue: '1',
                                            filterKey: 'rooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '2',
                                            filterValue: '2',
                                            filterKey: 'rooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '3',
                                            filterValue: '3',
                                            filterKey: 'rooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '4',
                                            filterValue: '4',
                                            filterKey: 'rooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '5',
                                            filterValue: '5',
                                            filterKey: 'rooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '6+',
                                            filterValue: '6+',
                                            filterKey: 'rooms',
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: 12,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bathrooms',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1)),
                                      ),
                                      Row(
                                        spacing: 8,
                                        children: [
                                          CrmAddFilteredButton(
                                            text: 'Any',
                                            filterValue: 'any',
                                            filterKey: 'bedrooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '1',
                                            filterValue: '1',
                                            filterKey: 'bedrooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '2',
                                            filterValue: '2',
                                            filterKey: 'bedrooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '3',
                                            filterValue: '3',
                                            filterKey: 'bedrooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '4',
                                            filterValue: '4',
                                            filterKey: 'bedrooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '5',
                                            filterValue: '5',
                                            filterKey: 'bedrooms',
                                          ),
                                          CrmAddFilteredButton(
                                            text: '6+',
                                            filterValue: '6+',
                                            filterKey: 'bedrooms',
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          Column(
                            spacing: 12,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pricing Information',
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                spacing: 12,
                                children: [
                                  const SizedBox(
                                    width: 120,
                                    child: AddClientFormCustomDropDown(
                                      options: [
                                        'PLN',
                                        'EUR',
                                        'USD'
                                      ],
                                      valueKey: 'currency',
                                      hintText: 'Currency', //add translate every where here
                                      id: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: SellCustomTextField(
                                      id: 25,
                                      valueKey: 'price',
                                      hintText: 'Price',
                                      controller: sellControllers.priceController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Price be empty";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        addClientFormNotifier.updateTextField(
                                          sellControllers.priceController,
                                          value,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            spacing: 12,
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
                                alignment: WrapAlignment.start,
                                spacing: 12,
                                runSpacing: 12,
                                children: FilterPopConst.additionalInfo
                                    .map((additionalInfo) {
                                  return ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 120,
                                      maxWidth: 180,
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
                                    ref.read(sellOfferFilterCacheProvider.notifier).clearData(ref);
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
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          TransactionCardWidget(isMobile: isMobile),
          ViewWidget(
            isMobile: isMobile,
          )
        ],
      ),
    );
  }
}
