import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterNetworkMonitoringLogicNotifier extends StateNotifier<AsyncValue<List<MonitoringAdsModel>>> {
  FilterNetworkMonitoringLogicNotifier(dynamic ref) : super(const AsyncValue.loading()) {
    _loadFiltersAndApplyNM(ref);
  }

  Map<String, dynamic> filters = {};
  String searchQuery = '';
  String excludeQuery = '';
  String sortOrder = '';
  String selectedCurrency = 'PLN';

  Future<void> _loadFiltersAndApplyNM(dynamic ref) async {
    final prefs = await SharedPreferences.getInstance();
    searchQuery = prefs.getString('searchQuery') ?? '';
    excludeQuery = prefs.getString('excludeQuery') ?? '';
    applyFiltersNM(ref);
  }

  Future<void> saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('searchQuery', searchQuery);
    await prefs.setString('excludeQuery', excludeQuery);
  }

  void applyFiltersFromCacheNM(FilterCacheNotifier cache,dynamic ref) {
    filters = cache.filters;
    searchQuery = cache.searchQuery;
    excludeQuery = cache.excludeQuery;
    sortOrder = cache.sortOrder;
    selectedCurrency = cache.selectedCurrency;
    applyFiltersNM(ref);
  }

  Future<void> applyFiltersNM(dynamic ref) async {
    state = const AsyncValue.loading();
    final token = ApiServices.token;

    Map<String, dynamic> authFilters = {};
    if (token != null && token.isNotEmpty) {
      authFilters = {
        if (filters.containsKey('exclude_favorites'))
          'exclude_favorites': filters['exclude_favorites'],
        if (filters.containsKey('exclude_hide'))
          'exclude_hide': filters['exclude_hide'],
        if (filters.containsKey('exclude_displayed'))
          'exclude_displayed': filters['exclude_displayed'],
      };
    }

    Map<String, dynamic> headers = {};
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Token $token';
    }

    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.singleAdMonitoring,
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

        final ads = newList.map((item) => MonitoringAdsModel.fromJson(item as Map<String, dynamic>)).toList();
        state = AsyncValue.data(ads);
      } else {
        state = AsyncValue.error(
            'Failed to load advertisements', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  Future<List<MonitoringAdsModel>> fetchAdvertisementsNM(int pageKey, int pageSize,dynamic ref) async {
    try {
      final response = await ApiServices.get(
        ref:ref,
        '${URLs.singleAdMonitoring}?page=$pageKey&pageSize=$pageSize',
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
          return MonitoringAdsModel.fromJson(item as Map<String, dynamic>);
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

  void setSortOrderNM(String order) {
    sortOrder = order;
    state = {...state, 'sortOrder': order};
  }

  void setSearchQueryNM(String query) {
    searchQuery = query;
    state = {...state, 'searchQuery': query};
  }

  void setExcludeQueryNM(String query) {
    excludeQuery = query;
    state = {...state, 'excludeQuery': query};
  }

  void setSelectedCurrencyNM(String currency) {
    selectedCurrency = currency;
    state = {...state, 'selectedCurrency': currency};
  }

  void addFilterNM(String key, dynamic value) {
    if (value != null && value.toString().isNotEmpty) {
      filters[key] = value;
    } else {
      filters.remove(key);
    }
    state = {...state, 'filters': filters};
  }

  void removeFilterNM(String key) {
    filters.remove(key);
    state = {...state, 'filters': filters};
  }

  void clearFiltersNM() {
    filters.clear();
    searchQuery = '';
    excludeQuery = '';
    sortOrder = '';
    selectedCurrency = 'PLN';
    state = {};
  }

  void setFiltersFromJson(Map<String, dynamic> json) {
    filters = json['filters'] ?? {};
    searchQuery = json['search_query'] ?? '';
    excludeQuery = json['exclude_query'] ?? '';
    sortOrder = json['sort_order'] ?? '';
    selectedCurrency = json['currency'] ?? 'PLN';
    state = {
      'filters': filters,
      'searchQuery': searchQuery,
      'excludeQuery': excludeQuery,
      'sortOrder': sortOrder,
      'selectedCurrency': selectedCurrency,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'filters': filters,
      'search_query': searchQuery,
      'exclude_query': excludeQuery,
      'sort_order': sortOrder,
      'currency': selectedCurrency,
    };
  }
}

final networkMonitoringFilterProvider = StateNotifierProvider<FilterNetworkMonitoringLogicNotifier,
    AsyncValue<List<MonitoringAdsModel>>>((ref) {
  return FilterNetworkMonitoringLogicNotifier(ref);
});

final networkMonitoringFilterCacheProvider = StateNotifierProvider<FilterCacheNotifier, Map<String, dynamic>>((ref) {
  return FilterCacheNotifier();
});
