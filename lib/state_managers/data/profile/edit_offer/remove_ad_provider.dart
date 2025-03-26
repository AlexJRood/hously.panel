// ignore_for_file: unused_result

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/state_managers/data/profile/profile_page/profile_ad_provider.dart';
import 'package:hously_flutter/utils/api_services.dart';

final removeAdProvider = Provider((ref) => RemoveAdProvider(ref));

class RemoveAdProvider {
  final Ref ref;

  RemoveAdProvider(this.ref);

  Future<void> removeAd(int adId) async {
    var response = await ApiServices.delete(
      URLs.advertisementsArchive('$adId'),
      hasToken: true,
    );

    if (response != null && response.statusCode == 204) {
      // Ogłoszenie zostało pomyślnie zarchiwizowane, odśwież listę ogłoszeń
      ref.refresh(yourAdsFilterProvider);
    }
  }
}
