import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/screens/add_client_form/components/sell/sell_data_components.dart';

final crmOfferHoveredPropertyProvider = StateProvider<AdsListViewModel?>((ref) => null);

final sellOfferFilterCacheProvider =
    StateNotifierProvider<SellOfferFilterCacheNotifier, Map<String, dynamic>>((ref) {
  return SellOfferFilterCacheNotifier();
});


class SellOfferFilterCacheNotifier extends StateNotifier<Map<String, dynamic>> {
  SellOfferFilterCacheNotifier() : super({});

  Map<String, dynamic> ad_draft = {};
  

  void addEventData(String key, dynamic value) {
    if (value != null && value.toString().isNotEmpty) {
      ad_draft[key] = value;
      print(ad_draft);
    } else {
      ad_draft.remove(key);
    }
    state = {...state, 'filters': ad_draft};
    print(state);
  }

  void removeEventData(String key) {
    ad_draft.remove(key);
    state = {...state, 'filters': ad_draft};
  }

  void clearEventData(WidgetRef ref) {
    ad_draft.clear();
    state = {};
    ref.read(sellOfferfilterButtonProvider.notifier).clearUiFilters();
  }
}