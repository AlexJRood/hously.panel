import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/saved_search_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'dart:convert';



final apiServiceSavedSearchesProvider = Provider<ApiServiceSavedSearches>((ref) {
  return ApiServiceSavedSearches();
});

final savedSearchesProvider =FutureProvider<List<SavedSearchModel>>((ref) async {
  final apiService = ref.read(apiServiceSavedSearchesProvider);
  return apiService.getSavedSearches(ref);
});

class ApiServiceSavedSearches {
  Future<List<SavedSearchModel>> getSavedSearches(dynamic ref) async {
    try {
      final response =
          await ApiServices.get(ref:ref,URLs.savedSearches, hasToken: true);

      if (response != null && response.statusCode == 200) {
          final decodedBody = utf8.decode(response.data);
          final listingsJson = json.decode(decodedBody) as List<dynamic>;

        
          final statuses = listingsJson.map((item) => SavedSearchModel.fromJson(item as Map<String, dynamic>)).toList();
          return statuses;
        

      } else {
        throw Exception('Failed to load saved searches');
      }
    } catch (e) {
      throw Exception('Failed to load saved searches: $e');
    }
  }
}

