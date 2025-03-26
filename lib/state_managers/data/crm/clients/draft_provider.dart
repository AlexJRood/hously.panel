// lib/providers/ad_provider.dart

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/ad/draft_ads_listview_model.dart';
import 'package:hously_flutter/utils/api_services.dart';

final draftAdProvider =
    FutureProvider.family<DraftAdsListViewModel, int>((ref, adId) async {
  final response = await ApiServices.get(ref:ref,URLs.draftAdvertisement('$adId'));



  if (response != null && response.statusCode == 200) {
    final decodedBody = utf8.decode(response.data);
    final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;

    return DraftAdsListViewModel.fromJson(
        listingsJson as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load advertisement');
  }
});



//   // bool _isLoad = false; // Initialize the boolean flag to false
//   // bool get isLoad =>_isLoad;
//   Future<List<AdsListViewModel>> fetchAdvertisements(int pageKey, int pageSize,dynamic ref) async {
//     try {
//       final response = await ApiServices.get(
//         ref:ref,
//         '${URLs.apiAdvertisements}?page=$pageKey&pageSize=$pageSize',
//         hasToken: true,
//         queryParameters: {
//           ...filters,
//           if (searchQuery.isNotEmpty) 'search': searchQuery,
//           if (excludeQuery.isNotEmpty) 'exclude': excludeQuery,
//           if (sortOrder.isNotEmpty) 'sort': sortOrder,
//           'currency': selectedCurrency,
//         },
//       );

//       if (response != null && response.statusCode == 200) {
//         final decodedBody = utf8.decode(response.data);
//         final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;
//         final newList = listingsJson['results'] as List<dynamic>;

//         return newList.map((item) {
//           return AdsListViewModel.fromJson(item as Map<String, dynamic>);
//         }).toList();
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch advertisements');
//     }
//     return [];
//   }
// }