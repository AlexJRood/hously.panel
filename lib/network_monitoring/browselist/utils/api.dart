// ignore_for_file: empty_catches

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';
import 'package:hously_flutter/network_monitoring/state_managers/saved_search/add_client.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

class BrowseListLogicNotifier
    extends StateNotifier<AsyncValue<List<MonitoringAdsModel>>> {
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

  bool isBrowseListSNMync(int adId) {
    final browseListsNMList = state.maybeWhen(
      data: (ads) => ads.map((ad) => ad.id).toList(),
      orElse: () => [],
    );
    return browseListsNMList.contains(adId);
  }

  Future<bool> isBrowseList(int adId) async {
    final prefs = await SharedPreferences.getInstance();
    final browseListsNMList = prefs.getStringList('BrowseListsNM_networkMonitoring') ?? [];
    return browseListsNMList.contains(adId.toString());
  }


// Zmieniamy sygnaturę removeFromBrowseListsNM, aby przyjmowała int adId:
Future<void> removeFromBrowseListsNM(int adId) async {
  try {
    final response = await ApiServices.delete(
      URLs.networkMonitoringBrowseListRemove ('$adId'),
      hasToken: true,
    );

    if (response != null && response.statusCode == 200) {
      print('removed');
      final prefs = await SharedPreferences.getInstance();
      final browseListsNMList = prefs.getStringList('BrowseListsNM_networkMonitoring') ?? [];
      browseListsNMList.remove(adId.toString());
      await prefs.setStringList('BrowseListsNM_networkMonitoring', browseListsNMList);
    }
  } catch (e) {
    // Obsługa błędu
  }
}

// Funkcja addToBrowseListsNM pozostaje bez zmian, bo przyjmuje int adId
Future<void> addToBrowseListsNMNM(int adId) async {
  try {
    final response = await ApiServices.post(
      URLs.networkMonitoringBrowseListAdd('$adId'),
      hasToken: true,
    );

    if (response != null &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      print('added');
      final prefs = await SharedPreferences.getInstance();
      final browseListsNMList = prefs.getStringList('BrowseListsNM_networkMonitoring') ?? [];
      // Zapobiegamy duplikatom – dodajemy tylko, jeśli nie ma
      if (!browseListsNMList.contains(adId.toString())) {
        browseListsNMList.add(adId.toString());
        await prefs.setStringList('BrowseListsNM_networkMonitoring', browseListsNMList);
      }
    } else {
      print(response?.statusCode);
    }
  } catch (e) {
    // Obsługa błędu
  }
}


Future<void> toggleBrowseListNM(MonitoringAdsModel ad, BuildContext context) async {
  // Sprawdź, czy ogłoszenie znajduje się już w liście pobranej z API (stan providera)
  final isInNmBrowseList = state.maybeWhen(
    data: (ads) => ads.any((item) => item.id == ad.id),
    orElse: () => false,
  );

  // Pobieramy listę z SharedPreferences – będziemy ją aktualizować
  final prefs = await SharedPreferences.getInstance();
  final prefsList = prefs.getStringList('BrowseListsNM_networkMonitoring') ?? [];

  if (isInNmBrowseList) {
    // Jeśli ogłoszenie jest już w liście, usuwamy je:
    await removeFromBrowseListsNM(ad.id);
    context.showSnackBarLikeSection('Usunięto z listy przeglądania'.tr);

    // Aktualizujemy stan providera: usuwamy model o danym id
    final currentAds = state.maybeWhen(data: (ads) => ads, orElse: () => <MonitoringAdsModel>[]);
    final updatedAds = currentAds.where((item) => item.id != ad.id).toList();
    state = AsyncData(updatedAds);

    // Usuwamy też z SharedPreferences
    prefsList.remove(ad.id.toString());
  } else {
    // Jeśli ogłoszenia nie ma – dodajemy je:
    await addToBrowseListsNMNM(ad.id);
    context.showSnackBarLikeSection('Dodano do listy przeglądania'.tr);

    // Aktualizujemy stan: dodajemy cały model ogłoszenia
    final currentAds = state.maybeWhen(data: (ads) => ads, orElse: () => <MonitoringAdsModel>[]);
    final updatedAdsNM = [ad, ...currentAds];
    state = AsyncData(updatedAdsNM);

    // Dodajemy id do SharedPreferences (upewnijmy się, że nie powtarzamy)
    if (!prefsList.contains(ad.id.toString())) {
      prefsList.add(ad.id.toString());
    }
  }

  await prefs.setStringList('BrowseListsNM_networkMonitoring', prefsList);
}




  Future<void> clearBrowseListsNM() async {
    try {
      final response = await ApiServices.delete(
        URLs.networkMonitoringBrowseListClear,
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        print('removed');
        
        final prefs = await SharedPreferences.getInstance();
        // Przypisanie pustej listy:
        await prefs.setStringList('BrowseListsNM_networkMonitoring', []);
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
        URLs.networkMonitoringBrowseList,
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
                MonitoringAdsModel.fromJson(item as Map<String, dynamic>))
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

final networkMonitoringBrowseListProvider = StateNotifierProvider<BrowseListLogicNotifier,
    AsyncValue<List<MonitoringAdsModel>>>((ref) {
  return BrowseListLogicNotifier(ref);
});
