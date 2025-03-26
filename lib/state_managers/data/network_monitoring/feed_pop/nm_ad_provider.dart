// lib/providers/ad_provider.dart

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';
import 'package:hously_flutter/screens/network_monitoring/feed_pop/nm_feed_pop.dart';
import 'package:hously_flutter/utils/api_services.dart';

final adNetworkMonitoringProvider =
FutureProvider.family<MonitoringAdsModel, int>((ref, adId) async {
  final response = await ApiServices.get(ref: ref, URLs.advertiseMonitoring('$adId'));

  if (response != null && response.statusCode == 200) {
    if (response.data is Uint8List) {
      String jsonString = utf8.decode(response.data);
      final decodedJson = jsonDecode(jsonString) as Map<String, dynamic>;
      return MonitoringAdsModel.fromJson(decodedJson);

    } else if (response.data is Map<String, dynamic>) {
      return MonitoringAdsModel.fromJson(response.data);

    } else {
      throw Exception('Unexpected response format');

    }
  } else {
    throw Exception('Failed to load advertisement');
    
  }
});

class NMAdFetcher extends ConsumerWidget {
  final int adNetworkPop;
  final String tagNetworkPop;

  const NMAdFetcher({
    required this.adNetworkPop,
    required this.tagNetworkPop,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adAsyncValue = ref.watch(adNetworkMonitoringProvider(adNetworkPop));

    return adAsyncValue.when(
      data: (adNetwork) {
        return NMFeedPop(adNetworkPop: adNetwork, tagNetworkPop: tagNetworkPop);
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.light,
            strokeWidth: 2,
          ),
        ),
      ),
      error: (error, stack){
       return Scaffold(
        body: Center(child: Text('Error: $error')),
      );}
    );
  }
}
