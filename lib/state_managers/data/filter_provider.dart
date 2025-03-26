import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
final hoveredPropertyProvider = StateProvider<AdsListViewModel?>((ref) => null);

class FiltersLogicNotifier
    extends StateNotifier<AsyncValue<List<AdsListViewModel>>> {
  FiltersLogicNotifier(dynamic ref) : super(const AsyncValue.loading()) {
    _loadFiltersAndApply(ref);
  }

  String get fullAddress {
    return [
      filters['street'],
      filters['city'],
      filters['state'],
      filters['country']
    ].where((element) => element != null && element.isNotEmpty).join(', ');
  }

  Map<String, dynamic> filters = {};
  String searchQuery = '';
  String excludeQuery = '';
  String sortOrder = '';
  String selectedCurrency = 'PLN';

  Future<void> _loadFiltersAndApply(dynamic ref) async {
    final prefs = await SharedPreferences.getInstance();
    searchQuery = prefs.getString('searchQuery') ?? '';
    excludeQuery = prefs.getString('excludeQuery') ?? '';
    applyFilters(ref);
  }

  // ignore: unused_element
  Future<void> _saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('searchQuery', searchQuery);
    await prefs.setString('excludeQuery', excludeQuery);
  }

  void applyFiltersFromCache(FilterCacheNotifier cache,dynamic ref) {
    filters = cache.filters;
    searchQuery = cache.searchQuery;
    excludeQuery = cache.excludeQuery;
    sortOrder = cache.sortOrder;
    selectedCurrency = cache.selectedCurrency;
    applyFilters(ref);
  }

  Future<void> applyFilters(dynamic ref) async {
    state = const AsyncValue.loading();

    Map<String, dynamic> authFilters = {};
    if (ApiServices.token != null && ApiServices.token!.isNotEmpty) {
      authFilters = {
        if (filters.containsKey('exclude_favorites'))
          'exclude_favorites': filters['exclude_favorites'],
        if (filters.containsKey('exclude_hide'))
          'exclude_hide': filters['exclude_hide'],
        if (filters.containsKey('exclude_displayed'))
          'exclude_displayed': filters['exclude_displayed'],
      };
    }

    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.apiAdvertisements,
        hasToken: true,
        queryParameters: {
          ...filters,
          if (searchQuery.isNotEmpty) 'search': searchQuery,
          if (excludeQuery.isNotEmpty) 'exclude': excludeQuery,
          if (sortOrder.isNotEmpty) 'sort': sortOrder,
          'currency': selectedCurrency,
          ...authFilters,
        },
      );

      if (response != null && response.statusCode == 200) {
        final decodedBody = utf8.decode(response.data);
        final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;
        final newList = listingsJson['results'] as List<dynamic>;

        final ads = newList.map((item) =>
                AdsListViewModel.fromJson(item as Map<String, dynamic>)).toList();
        state = AsyncValue.data(ads);
      } else {
        state = AsyncValue.error(
            'Failed to load advertisements', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // bool _isLoad = false; // Initialize the boolean flag to false
  // bool get isLoad =>_isLoad;
  Future<List<AdsListViewModel>> fetchAdvertisements(int pageKey, int pageSize,dynamic ref) async {
    try {
      final response = await ApiServices.get(
        ref:ref,
        '${URLs.apiAdvertisements}?page=$pageKey&pageSize=$pageSize',
        hasToken: true,
        queryParameters: {
          ...filters,
          if (searchQuery.isNotEmpty) 'search': searchQuery,
          if (excludeQuery.isNotEmpty) 'exclude': excludeQuery,
          if (sortOrder.isNotEmpty) 'sort': sortOrder,
          'currency': selectedCurrency,
        },
      );

      if (response != null && response.statusCode == 200) {
        final decodedBody = utf8.decode(response.data);
        final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;
        final newList = listingsJson['results'] as List<dynamic>;

        return newList.map((item) {
          return AdsListViewModel.fromJson(item as Map<String, dynamic>);
        }).toList();
      }
    } catch (e) {
      throw Exception('Failed to fetch advertisements');
    }
    return [];
  }
}

class FilterCacheNotifier extends StateNotifier<Map<String, dynamic>> {
  FilterCacheNotifier() : super({});

  Map<String, dynamic> filters = {};
  String searchQuery = '';
  String excludeQuery = '';
  String sortOrder = '';
  String selectedCurrency = 'PLN';

  void setSortOrder(String order) {
    sortOrder = order;
    state = {...state, 'sortOrder': order};
    
  }

  void setSearchQuery(String query) {
    searchQuery = query;
    state = {...state, 'searchQuery': query};
  }

  void setExcludeQuery(String query) {
    excludeQuery = query;
    state = {...state, 'excludeQuery': query};
  }

  void setSelectedCurrency(String currency) {
    selectedCurrency = currency;
    state = {...state, 'selectedCurrency': currency};
  }

  void addFilter(String key, dynamic value) {
    if (value != null && value.toString().isNotEmpty) {
      filters[key] = value;
      print(filters);
    } else {
      filters.remove(key);
    }
    state = {...state, 'filters': filters};
    print(state);
  }

  void removeFilter(String key) {
    filters.remove(key);
    state = {...state, 'filters': filters};
  }

  void clearFilters() {
    filters.clear();
    searchQuery = '';
    excludeQuery = '';
    sortOrder = '';
    selectedCurrency = 'PLN';
    state = {};
  }
}

final filterProvider = StateNotifierProvider<FiltersLogicNotifier,
    AsyncValue<List<AdsListViewModel>>>((ref) {
  return FiltersLogicNotifier(ref);
});

final filterCacheProvider =
    StateNotifierProvider<FilterCacheNotifier, Map<String, dynamic>>((ref) {
  return FilterCacheNotifier();
});
