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

class BrowseListLogicNotifier
    extends StateNotifier<AsyncValue<List<AdsListViewModel>>> {
  BrowseListLogicNotifier(dynamic ref) : super(const AsyncValue.loading()) {
    _loadFiltersAndApply(ref);
  }

  Map<String, dynamic> filters = {};
  String searchQuery = '';
  String excludeQuery = '';
  String sortOrder = 'date_desc';

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

  bool isBrowseListSync(int adId) {
    final browseListsList = state.maybeWhen(
      data: (ads) => ads.map((ad) => ad.id).toList(),
      orElse: () => [],
    );
    return browseListsList.contains(adId);
  }

  Future<bool> isBrowseList(int adId) async {
    final prefs = await SharedPreferences.getInstance();
    final browseListsList = prefs.getStringList('BrowseLists') ?? [];
    return browseListsList.contains(adId.toString());
  }


// Zmieniamy sygnaturę removeFromBrowseLists, aby przyjmowała int adId:
Future<void> removeFromBrowseLists(int adId) async {
  try {
    final response = await ApiServices.delete(
      URLs.portalBrowseListRemove('$adId'),
      hasToken: true,
    );

    if (response != null && response.statusCode == 200) {
      print('removed');
      final prefs = await SharedPreferences.getInstance();
      final browseListsList = prefs.getStringList('BrowseLists') ?? [];
      browseListsList.remove(adId.toString());
      await prefs.setStringList('BrowseLists', browseListsList);
    }
  } catch (e) {
    // Obsługa błędu
  }
}

// Funkcja addToBrowseLists pozostaje bez zmian, bo przyjmuje int adId
Future<void> addToBrowseLists(int adId) async {
  try {
    final response = await ApiServices.post(
      URLs.portalBrowseListAdd('$adId'),
      hasToken: true,
    );

    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      print('added');
      final prefs = await SharedPreferences.getInstance();
      final browseListsList = prefs.getStringList('BrowseLists') ?? [];
      // Zapobiegamy duplikatom – dodajemy tylko, jeśli nie ma
      if (!browseListsList.contains(adId.toString())) {
        browseListsList.add(adId.toString());
        await prefs.setStringList('BrowseLists', browseListsList);
      }
    } else {
      print(response?.statusCode);
    }
  } catch (e) {
    // Obsługa błędu
  }
}


Future<void> toggleBrowseList(AdsListViewModel ad, BuildContext context) async {
  // Sprawdź, czy ogłoszenie znajduje się już w liście pobranej z API (stan providera)
  final isInBrowseList = state.maybeWhen(
    data: (ads) => ads.any((item) => item.id == ad.id),
    orElse: () => false,
  );

  // Pobieramy listę z SharedPreferences – będziemy ją aktualizować
  final prefs = await SharedPreferences.getInstance();
  final prefsList = prefs.getStringList('BrowseLists') ?? [];

  if (isInBrowseList) {
    // Jeśli ogłoszenie jest już w liście, usuwamy je:
    await removeFromBrowseLists(ad.id);
    context.showSnackBarLikeSection('Usunięto z listy przeglądania'.tr);

    // Aktualizujemy stan providera: usuwamy model o danym id
    final currentAds = state.maybeWhen(data: (ads) => ads, orElse: () => <AdsListViewModel>[]);
    final updatedAds = currentAds.where((item) => item.id != ad.id).toList();
    state = AsyncData(updatedAds);

    // Usuwamy też z SharedPreferences
    prefsList.remove(ad.id.toString());
  } else {
    // Jeśli ogłoszenia nie ma – dodajemy je:
    await addToBrowseLists(ad.id);
    context.showSnackBarLikeSection('Dodano do listy przeglądania'.tr);

    // Aktualizujemy stan: dodajemy cały model ogłoszenia
    final currentAds = state.maybeWhen(data: (ads) => ads, orElse: () => <AdsListViewModel>[]);
    final updatedAds = [ad, ...currentAds];
    state = AsyncData(updatedAds);

    // Dodajemy id do SharedPreferences (upewnijmy się, że nie powtarzamy)
    if (!prefsList.contains(ad.id.toString())) {
      prefsList.add(ad.id.toString());
    }
  }

  await prefs.setStringList('BrowseLists', prefsList);
}




  Future<void> clearBrowseLists() async {
    try {
      final response = await ApiServices.delete(
        URLs.portalBrowseListClear,
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        print('removed');
        
        final prefs = await SharedPreferences.getInstance();
        // Przypisanie pustej listy:
        await prefs.setStringList('BrowseLists', []);
      } else {
        // Obsługa błędu
      }
    } catch (e) {
      // Obsługa wyjątku
      print(e);
    }
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
        URLs.portalBrowseList,
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
            AsyncValue.error('Failed to load BrowseList ads', StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final browseListProvider = StateNotifierProvider<BrowseListLogicNotifier,
    AsyncValue<List<AdsListViewModel>>>((ref) {
  return BrowseListLogicNotifier(ref);
});
