import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/filters_pop_const.dart';
import 'custom-drop_down.dart';
import 'filltered_button.dart';
import 'filtered_slider.dart';

class PcFiltersWidget extends ConsumerWidget {
  const PcFiltersWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final dropdownValues = ref.watch(dropdownProvider);

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
              child: CustomDropdown(
                label: 'Advertiser',
                options:
                FilterPopConst.advertiserOptions,
                value: dropdownValues['advertiser']!,
                onChanged: (newValue) {
                  ref
                      .read(dropdownProvider.notifier)
                      .updateValue(
                      'advertiser', newValue!);
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
              child: CustomDropdown(
                label: 'Advertiser',
                options:
                FilterPopConst.advertiserOptions,
                value: dropdownValues['advertiser']!,
                onChanged: (newValue) {
                  ref
                      .read(dropdownProvider.notifier)
                      .updateValue(
                      'advertiser', newValue!);
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
              child: CustomDropdown(
                label: 'Advertiser',
                options:
                FilterPopConst.advertiserOptions,
                value: dropdownValues['advertiser']!,
                onChanged: (newValue) {
                  ref
                      .read(dropdownProvider.notifier)
                      .updateValue(
                      'advertiser', newValue!);
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
              child: CustomDropdown(
                label: 'Advertiser',
                options:
                FilterPopConst.advertiserOptions,
                value: dropdownValues['advertiser']!,
                onChanged: (newValue) {
                  ref
                      .read(dropdownProvider.notifier)
                      .updateValue(
                      'advertiser', newValue!);
                },
                width: 166,
                height: 32,
              ),
            ),
          ],
        ),
        const Text(
          'Floor area',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        const FilteredSlider(filterKey: 'floors'),
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
                FilteredButton(
                  text: 'Any',
                  filterValue: 'any',
                  filterKey: 'bathrooms',
                ),
                FilteredButton(
                  text: '1',
                  filterValue: '1',
                  filterKey: 'bathrooms',
                ),
                FilteredButton(
                  text: '2',
                  filterValue: '2',
                  filterKey: 'bathrooms',
                ),
                FilteredButton(
                  text: '3',
                  filterValue: '3',
                  filterKey: 'bathrooms',
                ),
                FilteredButton(
                  text: '4',
                  filterValue: '4',
                  filterKey: 'bathrooms',
                ),
                FilteredButton(
                  text: '5',
                  filterValue: '5',
                  filterKey: 'bathrooms',
                ),
                FilteredButton(
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
