import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/components/checkbox.dart';

import 'package:hously_flutter/widgets/screens/autocompletion/components/customchip.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/components/customtextfield.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/components/textfieldcontainers.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/provider/autocompletion_provider.dart';

class Mytextfield extends ConsumerStatefulWidget {
  const Mytextfield({super.key});

  @override
  _MytextfieldState createState() => _MytextfieldState();
}

class _MytextfieldState extends ConsumerState<Mytextfield> {





  @override
  Widget build(BuildContext context) {
    print('rebuilded');
    final theme = ref.watch(themeColorsProvider);
    final model =
        ref.watch(myTextFieldViewModelProvider.notifier); // Watch the provider
    final state = ref.watch(myTextFieldViewModelProvider);
    const Color hovercolor = Color.fromARGB(270, 242, 243, 246);
    // Access specific values from the state map
    //  final isLoading = state['isLoading'];
    List recent = state['recentList'];
    final showRecentlySelected = model.filteredCities.isEmpty &&
        model.searchController.text.isEmpty &&
        state['recentList'].isNotEmpty;

    return Stack(
              children: [
                Textfieldcontainer(
                  height: model.isLoading || model.focusNode.hasFocus
                      ? 600
                      : 50, // Adjust height based on loading
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            return CustomTextField(
                              isloading: model.isLoading,
                              controller: model.selectedDistricts.isNotEmpty
                                  ? model.districtsController
                                  : model.searchController,
                              focusNode: model.focusNode,
                              isReadOnly: model.selectedDistricts.isNotEmpty,
                              hintText: "Search your location",
                              prefixIcon: Icons.search,
                              selectedDistricts: model.selectedDistricts,
                              onClear: () => model.clear(),
                              onChanged: (text) {
                                if (model.searchController.text.isEmpty) {
                                  model.clearExpandedCities();
                                }
                                model.filterCitiesAndDistricts(text);
                              },
                              onTap: () {
                                model.setLoading(true);
                                if (recent.isEmpty) {
                                  model.fetchAllCities();
                                }
                                if (model.searchController.text.isNotEmpty) {
                                  model.filterCitiesAndDistricts(
                                      model.searchController.text);
                                }
                                print(model.isLoading);
                              },
                            );
                          },
                        ),
                        (model.isLoading || model.focusNode.hasFocus)
                            ? Divider(color: theme.textFieldColor, thickness: 2)
                            : const SizedBox(),
                        ((model.isLoading || model.focusNode.hasFocus) &&
                                model.searchController.text.isEmpty &&
                                recent.isNotEmpty)
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "recently selected",
                                  style: TextStyle(
                                    color: theme.textFieldColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        (showRecentlySelected)
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: recent.length,
                                  itemBuilder: (context, index) {
                                    final recentItem = recent[index];

                                    return Material(
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Container(
                                          child: ListTile(
                                            title: Text(
                                              recentItem,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: theme.textFieldColor),
                                            ),
                                            onTap: () {
                                              model.handleRecentSelection(
                                                  recentItem);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(),
                        if (model.filteredCities.isNotEmpty)
                          Expanded(
                            child: ListView.builder(
                              itemCount: model.filteredCities.length,
                              itemBuilder: (context, index) {
                                final city = model.filteredCities[index];
                                final String cityName = city.city;
                                final districts = city.districts;
                                final isExpanded =
                                    model.isCityExpanded(cityName);
                                return Column(
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ListTile(
                                          title: Text(
                                            cityName,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: theme.textFieldColor),
                                          ),
                                          trailing: (districts != null &&
                                                  districts.isNotEmpty)
                                              ? SizedBox(
                                                  width: 40,
                                                  height: 30,
                                                  child: GestureDetector(
                                                    child: Icon(
                                                      color:
                                                          theme.textFieldColor,
                                                      isExpanded
                                                          ? Icons
                                                              .keyboard_arrow_up
                                                          : Icons
                                                              .keyboard_arrow_down,
                                                      size: 30,
                                                    ),
                                                    onTap: () {
                                                      model.toggleCityExpansion(
                                                          cityName);
                                                    },
                                                  ),
                                                )
                                              : null,
                                          onTap: () {
                                            //   print(model.selectedDistricts);
                                            model.handleCitySelection(
                                                cityName, city);
                                          },
                                        ),
                                      ),
                                    ),
                                    if (isExpanded &&
                                        districts != null &&
                                        districts.isNotEmpty)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: Column(
                                          children:
                                              districts.values.map((district) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: ListTile(
                                                title: Text(district,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: theme
                                                            .textFieldColor)),
                                                onTap: () {
                                                  model.selectDistrictFromList(
                                                      district, city);
                                                },
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
          
        if ((model.isLoading) && model.selectedDistricts.isNotEmpty)
          GestureDetector(
              onTap: () {
                model.setLoading(true);
              },
              child: SecondContainer(
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (model.selectedDistricts.isNotEmpty)
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: model.selectedDistricts.map(
                            (district) {
                              return Customchip(
                                country: district,
                                onRemove: () {
                                  if (model.selectedDistricts.isEmpty) {
                                    model.clear();
                                  }
                                  if (model.selectedDistricts.length == 1) {
                                    model.clear();
                                  }
                                  model.onCityChecked(false, district);
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    const SizedBox(height: 5),
                    if (model.cityInfo != null &&
                        model.cityInfo!.districts != null)
                      Expanded(
                        child: Scrollbar(
                          thickness: 10,
                          controller: model.scrollController,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: model.scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: ListTile(
                                      hoverColor: hovercolor,
                                      title: Container(
                                        height: 40,
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          model.cityInfo!.city,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: theme.textFieldColor),
                                        ),
                                      ),
                                      leading: CustomCheckbox(
                                        isChecked: model.isCityChecked,
                                        onChanged: (isChecked) {
                                          if (state['selectedDistricts']
                                              .isNotEmpty) {
                                            model.cleardistrict();

                                            model.onCityChecked(
                                                true, model.cityInfo!.city);
                                            print(
                                                "hello:${state['selectedDistricts']}");
                                          } else {
                                            bool newCheckedState =
                                                model.isCityChecked;
                                            model.onCityChecked(newCheckedState,
                                                model.cityInfo!.city);
                                          }
                                        },
                                      ),
                                      onTap: () {
                                        if (state['selectedDistricts']
                                            .isNotEmpty) {
                                          model.cleardistrict();

                                          model.onCityChecked(
                                              true, model.cityInfo!.city);
                                          print(
                                              "hello:${state['selectedDistricts']}");
                                        } else {
                                          bool newCheckedState =
                                              model.isCityChecked;
                                          model.onCityChecked(newCheckedState,
                                              model.cityInfo!.city);
                                        }
                                      }),
                                ),
                                for (var entry
                                    in model.cityInfo!.districts!.entries)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: ListTile(
                                        hoverColor: hovercolor,
                                        title: Container(
                                          height: 40,
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            entry.value,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: theme.textFieldColor),
                                          ),
                                        ),
                                        leading: CustomCheckbox(
                                          isChecked: model.selectedDistricts
                                              .contains(entry.value),
                                          onChanged: (isSelected) {
                                            if (isSelected != null) {
                                              model.handleDistrictSelection(
                                                  entry.value, isSelected);
                                            }
                                          },
                                        ),
                                        onTap: () {
                                          bool isSelected =
                                              !state['selectedDistricts']
                                                  .contains(entry.value);
                                          model.handleDistrictSelection(
                                              entry.value, isSelected);
                                        },
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
        
      ],
    );
  }
}
