// ignore_for_file: empty_catches

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hously_flutter/network_monitoring/state_managers/saved_search/add_client.dart';



class NMFavFiltersLogicNotifier extends StateNotifier<AsyncValue<List<MonitoringAdsModel>>> {
  NMFavFiltersLogicNotifier(dynamic ref) : super(const AsyncValue.loading()) {
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
    NMapplyFilters(ref);
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
    NMapplyFilters(ref);
  }

  void setSearchQuery(String query,dynamic ref) {
    searchQuery = query;
    _saveFiltersNM();
    NMapplyFilters(ref);
  }

  void setExcludeQuery(String query,dynamic ref) {
    excludeQuery = query;
    _saveFiltersNM();
    NMapplyFilters(ref);
  }

  void addFilter(String key, dynamic value,dynamic ref) {
    if (value != null && value.toString().isNotEmpty) {
      filters[key] = value;
    } else {
      filters.remove(key);
    }
    _saveFiltersNM();
    NMapplyFilters(ref);
  }

  void removeFilter(String key,dynamic ref) {
    filters.remove(key);
    _saveFiltersNM();
    NMapplyFilters(ref);
  }

  void clearFilters(dynamic ref) {
    filters.clear();
    searchQuery = '';
    excludeQuery = '';
    _saveFiltersNM();
    NMapplyFilters(ref);
  }

  bool NMisFavoriteSync(int adId) {
    final favoritesList = state.maybeWhen(
      data: (ads) => ads.map((ad) => ad.id).toList(),
      orElse: () => [],
    );
    return favoritesList.contains(adId);
  }

  Future<bool> isFavoriteNM(int adId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesList = prefs.getStringList('favorites') ?? [];
    return favoritesList.contains(adId.toString());
  }


  Future<void> toggleFavorite(MonitoringAdsModel ad, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final browseListIds = prefs.getStringList('BrowseLists') ?? [];
    bool isInBrowseList = browseListIds.contains(ad.id.toString());
    
    // Pobieramy bieżącą listę modeli ze stanu
    final currentAds = state.maybeWhen(data: (ads) => ads, orElse: () => <MonitoringAdsModel>[]);

    if (isInBrowseList) {
      // Usuń z listy (w SharedPreferences i lokalnie)
      browseListIds.remove(ad.id.toString());
      await removeFromFavoritesNM(ad.id);
      context.showSnackBarLikeSection('Usunięto z listy przeglądania'.tr);
      
      final updatedAds = currentAds.where((item) => item.id != ad.id).toList();
      state = AsyncData(updatedAds);
    } else {
      // Dodaj do listy (w SharedPreferences i lokalnie)
      browseListIds.add(ad.id.toString());
      await addToFavoritesNM(ad.id);
      context.showSnackBarLikeSection('Dodano do listy przeglądania'.tr);
      
      final updatedAds = [...currentAds, ad];
      state = AsyncData(updatedAds);
    }
    await prefs.setStringList('BrowseLists', browseListIds);
  }




  Future<void> addToFavoritesNM(int adId) async {
    try {
      // Wykonanie żądania POST z użyciem Dio
      final response = await ApiServices.post(
        URLs.addFavoriteNetwork('$adId'),
        hasToken: true,
      );

      // Sprawdzenie statusu odpowiedzi
      if (response != null && response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final favoritesList = prefs.getStringList('favorites') ?? [];
        favoritesList.add(adId.toString());
        await prefs.setStringList('favorites', favoritesList);
      } else {}
    } catch (e) {}
  }

  Future<void> removeFromFavoritesNM(int adId) async {
    try {
      final response = await ApiServices.post(
        URLs.removeFavoriteNetwork('$adId'),
        hasToken: true,
      );

      // Sprawdzenie statusu odpowiedzi
      if (response != null && response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        final favoritesList = prefs.getStringList('favorites') ?? [];
        favoritesList.remove(adId.toString());
        await prefs.setStringList('favorites', favoritesList);
      } else {}
    } catch (e) {}
  }

  Future<void> NMapplyFilters(dynamic ref) async {
    state = const AsyncValue.loading();

    if (ApiServices.token == null) {
      state = AsyncValue.error('Token not found', StackTrace.current);
      return;
    }

    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.favoriteNetwork,
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
        state =
            AsyncValue.error('Failed to load favorite ads', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final nMFavAdsProvider = StateNotifierProvider<NMFavFiltersLogicNotifier,
    AsyncValue<List<MonitoringAdsModel>>>((ref) {
  return NMFavFiltersLogicNotifier(ref);
});
