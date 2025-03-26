import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/screens/feed/map/map_page.dart';

class TestFile extends ConsumerWidget {
  const TestFile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MapPage(onFilteredAdsListViewsChanged: updateFilteredAds),
    );
  }

  void updateFilteredAds(List<AdsListViewModel> ads) {}
}
