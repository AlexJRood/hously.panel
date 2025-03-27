import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/modules/ads_managment/models/ad_list_view_model.dart';
import 'package:hously_flutter/api_services/api_services.dart';

final listingsProvider = FutureProvider<List<AdsListViewModel>>((ref) async {
  final response = await ApiServices.get(ref: ref,URLs.apiAdvertisements);

  if (response != null && response.statusCode == 200) {
    final decodedBody = utf8.decode(response.data);
    final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;
    final newList = listingsJson['results'] as List<dynamic>;

    return newList.map((json) => AdsListViewModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load listings');
  }
});
