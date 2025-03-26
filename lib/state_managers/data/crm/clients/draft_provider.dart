// lib/providers/ad_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/ad/draft_ads_listview_model.dart';
import 'package:hously_flutter/utils/api_services.dart';

final draftAdProvider =
    FutureProvider.family<DraftAdsListViewModel, int>((ref, adId) async {
  final response = await ApiServices.get(ref:ref,URLs.advertisement('$adId'));

  if (response != null && response.statusCode == 200) {
    return DraftAdsListViewModel.fromJson(
        response.data as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load advertisement');
  }
});
