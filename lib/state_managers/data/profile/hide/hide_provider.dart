// ignore_for_file: empty_catches

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/ad/hide_ads_view_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HideFiltersLogicNotifier
    extends StateNotifier<AsyncValue<List<HideAdsViewModel>>> {
  HideFiltersLogicNotifier(dynamic ref) : super(const AsyncValue.loading()) {
    _loadFiltersAndApply(ref);
  }

  Map<String, dynamic> filters = {};
  String searchQuery = '';
  String excludeQuery = '';
  String sortOrder = '';

  Future<void> _loadFiltersAndApply(dynamic ref) async {
    final prefs = await SharedPreferences.getInstance();
    searchQuery = prefs.getString('searchQuery') ?? '';
    excludeQuery = prefs.getString('excludeQuery') ?? '';
    // Załaduj inne filtry, jeśli są potrzebne

    // Po załadowaniu filtrów zastosuj je
    applyFilters(ref);
  }

  Future<void> _saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('searchQuery', searchQuery);
    await prefs.setString('excludeQuery', excludeQuery);
    // Zapisz inne filtry, jeśli są potrzebne
  }

  void setSortOrder(String order,dynamic ref) {
    sortOrder = order;
    _saveFilters();
    applyFilters(ref);
  }

  void setSearchQuery(String query,dynamic ref) {
    searchQuery = query;
    _saveFilters();
    applyFilters(ref);
  }

  void setExcludeQuery(String query,dynamic ref) {
    excludeQuery = query;
    _saveFilters();
    applyFilters(ref);
  }

  void addFilter(String key, dynamic value,dynamic ref) {
    if (value != null && value.toString().isNotEmpty) {
      filters[key] = value;
    } else {
      filters.remove(key);
    }
    _saveFilters();
    applyFilters(ref);
  }

  void removeFilter(String key,dynamic ref) {
    filters.remove(key);
    _saveFilters();
    applyFilters(ref);
  }

  void clearFilters(dynamic ref) {
    filters.clear();
    searchQuery = '';
    excludeQuery = '';
    _saveFilters();
    applyFilters(ref);
  }

  Future<bool> isHide(int adId) async {
    final prefs = await SharedPreferences.getInstance();
    final hideList = prefs.getStringList('hide') ?? [];
    return hideList.contains(adId.toString());
  }

  Future<void> addToHide(int adId) async {
    try {
      // Wykonanie żądania POST z użyciem Dio
      final response = await ApiServices.post(
        URLs.apiHideAdd('$adId'),
        hasToken: true,
      );

      // Sprawdzenie statusu odpowiedzi
      if (response != null && response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final hideList = prefs.getStringList('hide') ?? [];
        hideList.add(adId.toString());
        await prefs.setStringList('hide', hideList);
      } else {}
    } catch (e) {}
  }

  Future<void> removeFromHide(int adId) async {
    try {
      // Wykonanie żądania POST z użyciem Dio
      final response = await ApiServices.post(
        URLs.apiHideRemove('$adId'),
        hasToken: true,
      );

      // Sprawdzenie statusu odpowiedzi
      if (response != null && response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final hideList = prefs.getStringList('hide') ?? [];
        hideList.remove(adId.toString());
        await prefs.setStringList('hide', hideList);
      } else {}
    } catch (e) {}
  }

  Future<void> applyFilters(dynamic ref) async {
    state = const AsyncValue.loading();

    if (ApiServices.token == null) {
      state = AsyncValue.error('Token not found', StackTrace.current);
      return;
    }

    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.apiHide,
        hasToken: true,
        queryParameters: {
          ...filters,
          if (searchQuery.isNotEmpty) 'search': searchQuery,
          if (excludeQuery.isNotEmpty) 'exclude': excludeQuery,
          if (sortOrder.isNotEmpty) 'sort': sortOrder,
        },
      );

      if (response != null && response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final ads = data
            .map((item) =>
                HideAdsViewModel.fromJson(item as Map<String, dynamic>))
            .toList();
        state = AsyncValue.data(ads);
      } else {
        state = AsyncValue.error('Failed to load hide ads', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final hideAdsProvider = StateNotifierProvider<HideFiltersLogicNotifier,
    AsyncValue<List<HideAdsViewModel>>>((ref) {
  return HideFiltersLogicNotifier(ref);
});
