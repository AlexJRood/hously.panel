// lib/providers/ad_provider.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/ads_managment/models/ad_list_view_model.dart';
import 'package:hously_flutter/modules/ads_managment/feed/feed_pop/feed_pop.dart';
import 'package:hously_flutter/api_services/api_services.dart';

final adProvider =
    FutureProvider.family<AdsListViewModel, int>((ref, adId) async {
  final response = await ApiServices.get(
    ref: ref,
    '${URLs.apiAdvertisements}$adId',
  );

  if (response != null && response.statusCode == 200) {
    final decodedBody = utf8.decode(response.data);
    final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;

    return AdsListViewModel.fromJson(listingsJson as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load advertisement');
  }
});

class AdFetcher extends ConsumerWidget {
  final int feedAdId;
  final String tag;

  const AdFetcher({required this.feedAdId, required this.tag, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adAsyncValue = ref.watch(adProvider(feedAdId));

    return adAsyncValue.when(
      data: (ad) => FeedPopPage(adFeedPop: ad, tagFeedPop: tag),
      loading: () => const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.transparent,
            strokeWidth: 2,
          ),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }
}
