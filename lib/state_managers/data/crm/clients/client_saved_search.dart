import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/saved_search_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'dart:convert';

final clientSavedSearchesProvider =
    FutureProvider.family<List<SavedSearchModel>, int>((ref, clientId) async {
  final response = await ApiServices.get(
    ref: ref,
    URLs.clientSearches('$clientId'),
    hasToken: true,
  );

  if (response != null && response.statusCode == 200) {
    final decodedBody = utf8.decode(response.data);
    final listingsJson = json.decode(decodedBody) as List<dynamic>;
    
    final savedSearches = listingsJson.map((item) => SavedSearchModel.fromJson(item as Map<String, dynamic>)).toList();
    return savedSearches;
  } else {
    throw Exception('Failed to load saved searches');
  }
});
