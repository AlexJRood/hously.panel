import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/ad_provider.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/models/city_model.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/services/getcity_service.dart';

final myTextFieldViewModelProvider =
    StateNotifierProvider<MyTextFieldViewModel, Map<String, dynamic>>(
  (ref) => MyTextFieldViewModel(ref),
);

class MyTextFieldViewModel extends StateNotifier<Map<String, dynamic>> {
  final CityService _cityService = CityService();

  MyTextFieldViewModel(this.ref)
      : super({
          'filteredCities': [],
          'recentList': [],
          'selectedCityInfo': null,
          'selectedDistricts': <String>[],
          'expandedCities': <String, bool>{},
          'isCitySelected': false,
          'isCityChecked': false,
          'isLoading': false,
        });

  TextEditingController searchController = TextEditingController();
  TextEditingController districtsController = TextEditingController();
  FocusNode focusNode = FocusNode();

  bool get isLoading => state['isLoading'];
  bool get isCityChecked => state['isCityChecked'];
  List<String> get selectedDistricts =>
      List<String>.from(state['selectedDistricts']);
  City? get cityInfo => state['selectedCityInfo'] as City?;
  List<City> get filteredCities => List<City>.from(state['filteredCities']);
  ScrollController scrollController = ScrollController();
  final Ref ref; // Add ref to the view model

  void init() {
    focusNode.addListener(() {
      state = {...state, 'focus': focusNode.hasFocus};
    });
  }

  void passDataToFilterProvider(dynamic data) {
    final filterNotifier = ref.read(filterCacheProvider.notifier);
    filterNotifier.setSearchQuery(
        data); // Call your desired method on filterNotifier with data
  }

  void setLoading(bool val) {
    state = {...state, 'isLoading': val};
  }

  void clearExpandedCities() {
    state = {...state, 'expandedCities': {}};
  }

  Future<void> filterCitiesAndDistricts(String query) async {
    final List<City> cities = await _cityService.getCities();

    if (query.isEmpty) {
      state = {...state, 'filteredCities': []};
    } else {
      List<City> cityResults = cities.where((city) {
        return city.city.toLowerCase().contains(query.toLowerCase()) ||
            (city.districts?.values.any((district) =>
                    district.toLowerCase().contains(query.toLowerCase())) ??
                false);
      }).toList();

      state = {...state, 'filteredCities': cityResults};
    }
  }

  Future<void> fetchAllCities() async {
    final List<City> cities = await _cityService.getCities();

    state = {...state, 'filteredCities': cities};
  }

  bool isCityExpanded(String cityCountry) {
    return state['expandedCities'][cityCountry] ?? false;
  }

  void toggleCityExpansion(String cityCountry) {
    final expandedCities = Map<String, bool>.from(state['expandedCities']);
    expandedCities[cityCountry] = !isCityExpanded(cityCountry);
    state = {...state, 'expandedCities': expandedCities};
  }

  void cleardistrict() {
    state['selectedDistricts'].clear();
  }

  void onDistrictChanged(String districtName, bool isSelected) {
    List<String> updatedSelectedDistricts =
        List<String>.from(selectedDistricts);

    if (isSelected) {
      updatedSelectedDistricts.add(districtName);
    } else {
      updatedSelectedDistricts.remove(districtName);
    }

    updateDistrictsText(districtName);

    state = {...state, 'selectedDistricts': updatedSelectedDistricts};
    // state['recentList'].add(districtName);
  }

  void updateDistrictsText(String selected) {
    districtsController.text = state['selectedDistricts'].join(', ');
    passDataToFilterProvider(districtsController.text);
  }

  void recentlistAdd(String recentCityCountry) {
    // Ensure the recent list only contains unique items
    List<String> recentList = List<String>.from(state['recentList']);
    if (!recentList.contains(recentCityCountry)) {
      if (recentList.length == 3) {
        recentList.removeLast(); // Keep recent list size to 3
      }
      recentList.insert(0, recentCityCountry); // Add to the front of the list
    }
    state = {...state, 'recentList': recentList};
    print(recentList);
  }

  void onCityChecked(bool isChecked, String cityCountry) {
    if (!isChecked) {
      state['selectedDistricts'].remove(cityCountry);
    } else {
      state['selectedDistricts'].add(cityCountry);
    }

    updateDistrictsText(cityCountry);
    state = {
      ...state,
      'isCityChecked': isChecked,
    };
  }

  void selectDistrictFromList(String selectedCity, City cityInfo) {
    state = {
      ...state,
      'selectedCityInfo': cityInfo,
      'isCitySelected': false,
      'filteredCities': [],
    };

    searchController.text = selectedCity;
    setLoading(true);

    onDistrictChanged(selectedCity, true);
    updateDistrictsText(selectedCity);
    recentlistAdd(selectedCity);
  }

  void handleDistrictSelection(String district, bool isSelected) {
    searchController.clear();

    if (isSelected) {
      state = {...state, 'isCityChecked': false};
      onCityChecked(false, cityInfo!.city);
    }

    onDistrictChanged(district, isSelected);

    if ((cityInfo?.districts?.length) == state['selectedDistricts'].length) {
      cleardistrict();
      state = {...state, 'isCityChecked': true};

      onCityChecked(true, cityInfo!.city);
    } else if (!isSelected && state['selectedDistricts'].isEmpty) {
      state = {...state, 'isCityChecked': true};
      districtsController.text = cityInfo!.city;
      state['selectedDistricts'].add(cityInfo!.city);
    }
    updateDistrictsText(cityInfo!.city);
  }

  void handleCitySelection(String selectedCity, City? city) {
    if (city != null && city.districts != null) {
      state = {
        ...state,
        'selectedCityInfo': city,
        'isCitySelected': true,
        'filteredCities': [],
      };
      recentlistAdd(selectedCity);

      districtsController.text = selectedCity;
      setLoading(true);
      onCityChecked(true, selectedCity);
    } else {
      districtsController.text = selectedCity;
      searchController.text = selectedCity;

      print("this is working");

      passDataToFilterProvider(districtsController.text);
      districtsController.clear();
      print(districtsController.text);

      setLoading(false);
      recentlistAdd(selectedCity);
      focusNode.unfocus();
    }
  }

  Future<void> handleRecentSelection(String selectedCity) async {
    print("1");
    // Fetch the list of cities from the CityService
    final cities = await _cityService.getCities();

    // First, check if the selected item is a city by matching against the list of cities.
    final cityInfo = cities.firstWhere(
      (city) => city.city == selectedCity,
      orElse: () => City(
        city: '',
        districts: {}, // Return a placeholder City if not found
      ),
    );

    // Check if the cityInfo is valid
    if (cityInfo.city.isNotEmpty) {
      print("2");
      // If the city has valid info, check if districts is not null and contains items
      if (cityInfo.districts != null && cityInfo.districts!.isNotEmpty) {
        print("3");
        handleCitySelection(selectedCity, cityInfo);
      } else {
        print("4");
        // Handle the case where the city exists but has no districts
        handcitywithoutdistrict(selectedCity);
      }
    } else {
      print("5");
      // If the selected item is a district, find the corresponding city
      final districtCityInfo = cities.firstWhere(
        (city) =>
            city.districts != null &&
            city.districts!.values.contains(selectedCity),
        orElse: () => City(
          city: '',
          districts: {}, // Return a placeholder City if not found
        ),
      );

      // Ensure the districtCityInfo has valid info before proceeding
      if (districtCityInfo.city.isNotEmpty) {print("6");
        selectDistrictFromList(selectedCity, districtCityInfo);
      }
    }
  }

  void handcitywithoutdistrict(String selectedCity) {
    searchController.text = selectedCity; // Update the search controller
    recentlistAdd(selectedCity); // Add to recent list
    passDataToFilterProvider(selectedCity);
    setLoading(false); // Reset loading state
    focusNode.unfocus(); // Unfocus the search field
  }

  void clear() {
    state = {
      ...state,
      'selectedDistricts': <String>[],
      'selectedCityInfo': null,
      'isCitySelected': false,
      'filteredCities': [],
    };
    passDataToFilterProvider('');
    selectedDistricts.clear();
    searchController.clear();
    districtsController.clear();
  }
}
