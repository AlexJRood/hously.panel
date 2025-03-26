// ignore_for_file: empty_catches

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class NMDisplayedFiltersLogicNotifier
    extends StateNotifier<AsyncValue<List<MonitoringAdsModel>>> {
  NMDisplayedFiltersLogicNotifier(dynamic ref) : super(const AsyncValue.loading()) {
    _loadFiltersAndApplyNM(ref);
  }
  Map<String, dynamic> filters = {};
  String searchQuery = '';
  String excludeQuery = '';
  String sortOrder = '';

  Future<void> _loadFiltersAndApplyNM(dynamic ref) async {
    final prefs = await SharedPreferences.getInstance();
    searchQuery = prefs.getString('searchQuery') ?? '';
    excludeQuery = prefs.getString('excludeQuery') ?? '';
    // Załaduj inne filtry, jeśli są potrzebne

    // Po załadowaniu filtrów zastosuj je
    applyFiltersNM(ref);
  }

  Future<void> _saveFiltersNM() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('searchQuery', searchQuery);
    await prefs.setString('excludeQuery', excludeQuery);
    // Zapisz inne filtry, jeśli są potrzebne
  }

  void setSortOrder(String order,dynamic ref) {
    sortOrder = order;
    _saveFiltersNM();
    applyFiltersNM(ref);
  }

  void setSearchQuery(String query,dynamic ref) {
    searchQuery = query;
    _saveFiltersNM();
    applyFiltersNM(ref);
  }

  void setExcludeQuery(String query,dynamic ref) {
    excludeQuery = query;
    _saveFiltersNM();
    applyFiltersNM(ref);
  }

  void addFilterNM(String key, dynamic value,dynamic ref) {
    if (value != null && value.toString().isNotEmpty) {
      filters[key] = value;
    } else {
      filters.remove(key);
    }
    _saveFiltersNM();
    applyFiltersNM(ref);
  }

  void removeFilterNM(String key,dynamic ref) {
    filters.remove(key);
    _saveFiltersNM();
    applyFiltersNM(ref);
  }

  void clearFiltersNM(dynamic ref) {
    filters.clear();
    searchQuery = '';
    excludeQuery = '';
    _saveFiltersNM();
    applyFiltersNM(ref);
  }

  Future<bool> isDisplayedNM(int adId) async {
    final prefs = await SharedPreferences.getInstance();
    final displayedList = prefs.getStringList('displayed') ?? [];
    return displayedList.contains(adId.toString());
  }

  // Upewnij się, że ścieżka do pliku jest poprawna

  Future<void> addToDisplayedNM(int adId) async {
    try {
      // Wykonanie żądania POST z użyciem Dio
      final response = await ApiServices.post(
        URLs.monitoringDisplay('$adId'),
        hasToken: true,
      );
    } catch (e) {}
  }

  Future<void> removeFromDisplayedNM(int adId) async {
    try {
      final response = await ApiServices.post(
        URLs.removeMonitoring('$adId'),
        hasToken: true,
      );
    } catch (e) {}
  }

  Future<void> applyFiltersNM(dynamic ref) async {
    state = const AsyncValue.loading();

    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.networkMonitoring,
        hasToken: true,
        queryParameters: {
          ...filters,
          if (searchQuery.isNotEmpty) 'search': searchQuery,
          if (excludeQuery.isNotEmpty) 'exclude': excludeQuery,
          if (sortOrder.isNotEmpty) 'sort': sortOrder,
        },
      );

      if (response != null && response.statusCode == 200) {        
          final decodedBody = utf8.decode(response.data);
          final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;
          final adsResults = listingsJson['results'] as List<dynamic>;

        
          final adsData = adsResults.map((item) => MonitoringAdsModel.fromJson(item as Map<String, dynamic>)).toList();

        state = AsyncValue.data(adsData);


      } else {
        state = AsyncValue.error(
            'Failed to load displayed ads', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final nMDisplayedAdsProvider = StateNotifierProvider<
    NMDisplayedFiltersLogicNotifier,
    AsyncValue<List<MonitoringAdsModel>>>((ref) {
  return NMDisplayedFiltersLogicNotifier(ref);
});
