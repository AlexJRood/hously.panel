import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/screens/add_client_form/components/buy/buy_filtered_slider.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_filltered_button.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_custom_drop_down.dart';

import 'package:hously_flutter/screens/add_client_form/const/buy_crm_add_filters.dart';

class PcFiltersWidget extends ConsumerWidget {
  const PcFiltersWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final dropdownValues = ref.watch(crmAddDropdownProvider);

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CrmAddCustomDropdown(
                label: 'Advertiser',
                options:
                FilterPopConst.advertiserOptions,
                value: dropdownValues['advertiser']!,
                onChanged: (newValue) {
                  ref
                      .read(crmAddDropdownProvider.notifier)
                      .updateValue(
                      'advertiser', newValue!, ref);
                },
                width: 166,
                height: 32,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                  width: 15,
                  child: Divider(
                    color: Color.fromRGBO(
                        145, 145, 145, 1),
                  )),
            ),
            Expanded(
              child: CrmAddCustomDropdown(
                label: 'Advertiser',
                options:
                FilterPopConst.advertiserOptions,
                value: dropdownValues['advertiser']!,
                onChanged: (newValue) {
                  ref
                      .read(crmAddDropdownProvider.notifier)
                      .updateValue(
                      'advertiser', newValue!, ref);
                },
                width: 166,
                height: 32,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CrmAddCustomDropdown(
                label: 'Advertiser',
                options:
                FilterPopConst.advertiserOptions,
                value: dropdownValues['advertiser']!,
                onChanged: (newValue) {
                  ref
                      .read(crmAddDropdownProvider.notifier)
                      .updateValue(
                      'advertiser', newValue!, ref);
                },
                width: 166,
                height: 32,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                  width: 15,
                  child: Divider(
                    color: Color.fromRGBO(
                        145, 145, 145, 1),
                  )),
            ),
            Expanded(
              child: CrmAddCustomDropdown(
                label: 'Advertiser',
                options:
                FilterPopConst.advertiserOptions,
                value: dropdownValues['advertiser']!,
                onChanged: (newValue) {
                  ref
                      .read(crmAddDropdownProvider.notifier)
                      .updateValue(
                      'advertiser', newValue!, ref);
                },
                width: 166,
                height: 32,
              ),
            ),
          ],
        ),
        const Text(
          'Floors',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        const CrmAddFilteredSlider(filterKey: 'floors'),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 32,
              width: 100,
              decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius:
                  BorderRadius.circular(6)),
              child: const Center(
                child: Text(
                  'Min, m2',
                  style: TextStyle(
                    color: Color.fromRGBO(
                        145, 145, 145, 1),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              height: 32,
              width: 100,
              decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius:
                  BorderRadius.circular(6)),
              child: const Center(
                child: Text(
                  'Max, m2',
                  style: TextStyle(
                    color: Color.fromRGBO(
                        145, 145, 145, 1),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Row(
          spacing: 8,
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bedrooms',
              style: TextStyle(
                  color:
                  Color.fromRGBO(255, 255, 255, 1)),
            ),
            Wrap(
              spacing: 2,
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
        const Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bathrooms',
              style: TextStyle(
                  color:
                  Color.fromRGBO(255, 255, 255, 1)),
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 2,
              children: [
                CrmAddFilteredButton(
                  text: 'Any',
                  filterValue: 'any',
                  filterKey: 'bathrooms',
                ),
                CrmAddFilteredButton(
                  text: '1',
                  filterValue: '1',
                  filterKey: 'bathrooms',
                ),
                CrmAddFilteredButton(
                  text: '2',
                  filterValue: '2',
                  filterKey: 'bathrooms',
                ),
                CrmAddFilteredButton(
                  text: '3',
                  filterValue: '3',
                  filterKey: 'bathrooms',
                ),
                CrmAddFilteredButton(
                  text: '4',
                  filterValue: '4',
                  filterKey: 'bathrooms',
                ),
                CrmAddFilteredButton(
                  text: '5',
                  filterValue: '5',
                  filterKey: 'bathrooms',
                ),
                CrmAddFilteredButton(
                  text: '6+',
                  filterValue: '6+',
                  filterKey: 'bathrooms',
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
