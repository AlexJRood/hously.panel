import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/screens/add_client_form/provider/add_client_form_provider.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/advertisment_information_image_widget.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/transaction_card_widget.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/user_contact_custom_text_field.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/view_widget.dart';
import '../../../const/filters_pop_const.dart';
import '../../../data/design/design.dart';
import '../../filters/new_widgets/additional_info_filtered_button.dart';
import '../../filters/new_widgets/estate_filtered_button.dart';
import '../../filters/new_widgets/filltered_button.dart';
import 'add_client_form_custom_drop_down.dart';

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
                          UserContactCustomTextField(
                            id: 10,
                            hintText: 'Add title',
                            controller: addClientForm.savedSearchTitleController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Title cannot be empty";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              addClientFormNotifier.updateTextField(
                                addClientForm.savedSearchTitleController,
                                value,
                              );
                            },
                          ),
                          UserContactCustomTextField(
                            id: 11,
                            hintText: 'Description',
                            controller:
                                addClientForm.draftDescriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Description be empty";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              addClientFormNotifier.updateTextField(
                                addClientForm.draftDescriptionController,
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
                                    hintText: 'City',
                                    id: 12,
                                  )),
                                  Expanded(
                                    child: UserContactCustomTextField(
                                      id: 15,
                                      hintText: 'Street Address',
                                      controller:
                                          addClientForm.eventLocationController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Address be empty";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        addClientFormNotifier.updateTextField(
                                          addClientForm.eventLocationController,
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
                                    child: UserContactCustomTextField(
                                      id: 16,
                                      hintText: 'Zipcode',
                                      controller:TextEditingController(text: '300'),
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
                                    hintText: 'Year B',
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
                                        FilteredButton(
                                          text: 'Any',
                                          filterValue: 'any',
                                          filterKey: 'bedrooms',
                                        ),
                                        FilteredButton(
                                          text: '1',
                                          filterValue: '1',
                                          filterKey: 'rooms',
                                        ),
                                        FilteredButton(
                                          text: '2',
                                          filterValue: '2',
                                          filterKey: 'rooms',
                                        ),
                                        FilteredButton(
                                          text: '3',
                                          filterValue: '3',
                                          filterKey: 'rooms',
                                        ),
                                        FilteredButton(
                                          text: '4',
                                          filterValue: '4',
                                          filterKey: 'rooms',
                                        ),
                                        FilteredButton(
                                          text: '5',
                                          filterValue: '5',
                                          filterKey: 'rooms',
                                        ),
                                        FilteredButton(
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
                                        FilteredButton(
                                          text: 'Any',
                                          filterValue: 'any',
                                          filterKey: 'bedrooms',
                                        ),
                                        FilteredButton(
                                          text: '1',
                                          filterValue: '1',
                                          filterKey: 'bedrooms',
                                        ),
                                        FilteredButton(
                                          text: '2',
                                          filterValue: '2',
                                          filterKey: 'bedrooms',
                                        ),
                                        FilteredButton(
                                          text: '3',
                                          filterValue: '3',
                                          filterKey: 'bedrooms',
                                        ),
                                        FilteredButton(
                                          text: '4',
                                          filterValue: '4',
                                          filterKey: 'bedrooms',
                                        ),
                                        FilteredButton(
                                          text: '5',
                                          filterValue: '5',
                                          filterKey: 'bedrooms',
                                        ),
                                        FilteredButton(
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
                                          FilteredButton(
                                            text: 'Any',
                                            filterValue: 'any',
                                            filterKey: 'bedrooms',
                                          ),
                                          FilteredButton(
                                            text: '1',
                                            filterValue: '1',
                                            filterKey: 'rooms',
                                          ),
                                          FilteredButton(
                                            text: '2',
                                            filterValue: '2',
                                            filterKey: 'rooms',
                                          ),
                                          FilteredButton(
                                            text: '3',
                                            filterValue: '3',
                                            filterKey: 'rooms',
                                          ),
                                          FilteredButton(
                                            text: '4',
                                            filterValue: '4',
                                            filterKey: 'rooms',
                                          ),
                                          FilteredButton(
                                            text: '5',
                                            filterValue: '5',
                                            filterKey: 'rooms',
                                          ),
                                          FilteredButton(
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
                                          FilteredButton(
                                            text: 'Any',
                                            filterValue: 'any',
                                            filterKey: 'bedrooms',
                                          ),
                                          FilteredButton(
                                            text: '1',
                                            filterValue: '1',
                                            filterKey: 'bedrooms',
                                          ),
                                          FilteredButton(
                                            text: '2',
                                            filterValue: '2',
                                            filterKey: 'bedrooms',
                                          ),
                                          FilteredButton(
                                            text: '3',
                                            filterValue: '3',
                                            filterKey: 'bedrooms',
                                          ),
                                          FilteredButton(
                                            text: '4',
                                            filterValue: '4',
                                            filterKey: 'bedrooms',
                                          ),
                                          FilteredButton(
                                            text: '5',
                                            filterValue: '5',
                                            filterKey: 'bedrooms',
                                          ),
                                          FilteredButton(
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
                                        'option 1',
                                        'option 2',
                                        'option 3'
                                      ],
                                      hintText: 'Currency',
                                      id: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: UserContactCustomTextField(
                                      id: 25,
                                      hintText: 'Price',
                                      controller: addClientForm.draftPriceController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Price be empty";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        addClientFormNotifier.updateTextField(
                                          addClientForm.draftPriceController,
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
                                    child: AdditionalInfoFilteredButton(
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
                            mainAxisAlignment: MainAxisAlignment.end,
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
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Center(
                                  child: Text('Save',
                                      style: TextStyle(
                                        color: AppColors.light50,
                                      )),
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
