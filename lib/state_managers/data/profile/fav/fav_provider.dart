// ignore_for_file: empty_catches

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/network_monitoring/state_managers/saved_search/add_client.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class FavFiltersLogicNotifier extends StateNotifier<AsyncValue<List<AdsListViewModel>>> {
  FavFiltersLogicNotifier(dynamic ref) : super(const AsyncValue.loading()) {
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

  void setSortOrder(String order, dynamic ref) {
    sortOrder = order;
    _saveFilters();
    applyFilters(ref);
  }

  void setSearchQuery(String query, dynamic ref) {
    searchQuery = query;
    _saveFilters();
    applyFilters(ref);
  }

  void setExcludeQuery(String query, dynamic ref) {
    excludeQuery = query;
    _saveFilters();
    applyFilters(ref);
  }

  void addFilter(String key, dynamic value, dynamic ref) {
    if (value != null && value.toString().isNotEmpty) {
      filters[key] = value;
    } else {
      filters.remove(key);
    }
    _saveFilters();
    applyFilters(ref);
  }

  void removeFilter(String key, dynamic ref) {
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

  bool isFavoriteSync(int adId) {
    final favoritesList = state.maybeWhen(
      data: (ads) => ads.map((ad) => ad.id).toList(),
      orElse: () => [],
    );
    return favoritesList.contains(adId);
  }

  Future<bool> isFavorite(int adId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesList = prefs.getStringList('favorites') ?? [];
    return favoritesList.contains(adId.toString());
  }


  
  Future<void> toggleFavorite(AdsListViewModel ad, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final browseListIds = prefs.getStringList('BrowseLists') ?? [];
    bool isInBrowseList = browseListIds.contains(ad.id.toString());
    
    // Pobieramy bieżącą listę modeli ze stanu
    final currentAds = state.maybeWhen(data: (ads) => ads, orElse: () => <AdsListViewModel>[]);

    if (isInBrowseList) {
      // Usuń z listy (w SharedPreferences i lokalnie)
      browseListIds.remove(ad.id.toString());
      await removeFromFavorites(ad.id);
      context.showSnackBarLikeSection('Usunięto z listy przeglądania'.tr);
      
      final updatedAds = currentAds.where((item) => item.id != ad.id).toList();
      state = AsyncData(updatedAds);
    } else {
      // Dodaj do listy (w SharedPreferences i lokalnie)
      browseListIds.add(ad.id.toString());
      await addToFavorites(ad.id);
      context.showSnackBarLikeSection('Dodano do listy przeglądania'.tr);
      
      final updatedAds = [...currentAds, ad];
      state = AsyncData(updatedAds);
    }
    await prefs.setStringList('BrowseLists', browseListIds);
  }



  Future<void> addToFavorites(int adId) async {
    try {
      final response = await ApiServices.post(
        URLs.apiFavoriteAdd('$adId'),
        hasToken: true,
      );

      if (response != null && response.statusCode == 200 ||
          response?.statusCode == 201) {
        print('added');
        final prefs = await SharedPreferences.getInstance();
        final favoritesList = prefs.getStringList('favorites') ?? [];
        favoritesList.add(adId.toString());
        await prefs.setStringList('favorites', favoritesList);
      } else {
        print(response?.statusCode);
      }
    } catch (e) {}
  }

  Future<void> removeFromFavorites(int adId) async {
    try {
      final response = await ApiServices.delete(
        URLs.apiFavoriteRemove('$adId'),
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        print('removed');
        final prefs = await SharedPreferences.getInstance();
        final favoritesList = prefs.getStringList('favorites') ?? [];
        favoritesList.remove(adId.toString());
        await prefs.setStringList('favorites', favoritesList);
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
        URLs.apiFavorite,
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
        final listingsJson = json.decode(decodedBody) as List<dynamic>;
        final ads = listingsJson
            .map((item) =>
                AdsListViewModel.fromJson(item as Map<String, dynamic>))
            .toList();
        state = AsyncValue.data(ads);
      } else {
        state =
            AsyncValue.error('Failed to load favorite ads', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final favAdsProvider = StateNotifierProvider<FavFiltersLogicNotifier,
    AsyncValue<List<AdsListViewModel>>>((ref) {
  return FavFiltersLogicNotifier(ref);
});
