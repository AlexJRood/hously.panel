import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
// import 'package:hously_flutter/Filters/FiltersComponets/ad_list_view_model.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class FiltersLogicNotifier
    extends StateNotifier<AsyncValue<List<MonitoringAdsModel>>> {
  FiltersLogicNotifier(dynamic ref) : super(const AsyncValue.loading()) {
    _loadFiltersAndApply(ref);
  }

  String selectedSavedSearchId = ''; // Nowe pole dla zapisanych wyszukiwań
  String clientId = ''; // Nowe pole dla klienta
  String transactionId = ''; // Nowe pole dla transakcji klienta
  String searchQuery = '';
  String excludeQuery = '';
  String sortOrder = '';
  String selectedCurrency = 'PLN';

  Map<String, dynamic> filters = {};

  Future<void> _loadFiltersAndApply(dynamic ref) async {
    final prefs = await SharedPreferences.getInstance();
    searchQuery = prefs.getString('searchQuery') ?? '';
    excludeQuery = prefs.getString('excludeQuery') ?? '';
    selectedSavedSearchId =
        prefs.getString('selectedSavedSearchId') ?? ''; // Nowe pole
    clientId = prefs.getString('clientId') ?? ''; // Nowe pole
    transactionId = prefs.getString('transactionId') ?? ''; // Nowe pole
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

    // Budowanie parametrów zapytania
    Map<String, dynamic> queryParameters = {
      ...filters,
      if (searchQuery.isNotEmpty) 'search': searchQuery,
      if (excludeQuery.isNotEmpty) 'exclude': excludeQuery,
      if (sortOrder.isNotEmpty) 'sort': sortOrder,
      'currency': selectedCurrency,
      ...authFilters,
      if (selectedSavedSearchId.isNotEmpty)
        'saved_search_id':
            selectedSavedSearchId, // Filtr na podstawie zapisanego wyszukiwania
      if (clientId.isNotEmpty)
        'saved_search_client_id':
            clientId, // Wyszukiwanie zapisanych filtrów klienta
      if (transactionId.isNotEmpty)
        'saved_search_transaction_id':
            transactionId, // Wyszukiwanie zapisanych filtrów transakcji klienta
    };

    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.singleAdMonitoring,
        hasToken: true,
        queryParameters: queryParameters,
      );

      if (response != null && response.statusCode == 200) {      
        
        final decodedBody = utf8.decode(response.data);
        final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;
        final newList = listingsJson['results'] as List<dynamic>;

        final ads = newList.map((item) =>
                MonitoringAdsModel.fromJson(item as Map<String, dynamic>)).toList();
        state = AsyncValue.data(ads);
      } else {
        state = AsyncValue.error(
            'Failed to load advertisements', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // Metoda do ustawiania zapisanego wyszukiwania
  void setSavedSearch(String searchId,dynamic ref) {
    selectedSavedSearchId = searchId;
    _saveFilters();
    applyFilters(ref);
  }

  // Metoda do ustawiania klienta
  void setClientId(String newClientId,dynamic ref) {
    clientId = newClientId;
    _saveFilters();
    applyFilters(ref);
  }

  // Metoda do ustawiania transakcji
  void setTransactionId(String newTransactionId,dynamic ref) {
    transactionId = newTransactionId;
    _saveFilters();
    applyFilters(ref);
  }

  Future<void> _saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedSavedSearchId', selectedSavedSearchId);
    await prefs.setString('clientId', clientId);
    await prefs.setString('transactionId', transactionId);
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

  void setSearchQuery(dynamic query) {
    searchQuery = query;
    print('query:$query');
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
    } else {
      filters.remove(key);
    }
    state = {...state, 'filters': filters};
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
    AsyncValue<List<MonitoringAdsModel>>>((ref) {
  return FiltersLogicNotifier(ref);
});

final filterCacheProvider =
    StateNotifierProvider<FilterCacheNotifier, Map<String, dynamic>>((ref) {
  return FilterCacheNotifier();
});
