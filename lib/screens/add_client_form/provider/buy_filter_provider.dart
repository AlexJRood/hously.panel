import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_from_filter_components.dart';

final crmOfferHoveredPropertyProvider = StateProvider<AdsListViewModel?>((ref) => null);

final buyOfferFilterCacheProvider =
    StateNotifierProvider<BuyOfferFilterCacheNotifier, Map<String, dynamic>>((ref) {
  return BuyOfferFilterCacheNotifier();
});


class BuyOfferFilterCacheNotifier extends StateNotifier<Map<String, dynamic>> {
  BuyOfferFilterCacheNotifier() : super({});

  Map<String, dynamic> filters = {};
  

  void addFilter(String key, dynamic value) {
    if (value != null && value.toString().isNotEmpty) {
      filters[key] = value;
      print(filters);
    } else {
      filters.remove(key);
    }
    state = {...state, 'filters': filters};
    print(state);
  }

  void removeFilter(String key) {
    filters.remove(key);
    state = {...state, 'filters': filters};
  }

  void clearFilters(WidgetRef ref) {
    filters.clear();
    state = {};
    ref.read(buyOfferfilterButtonProvider.notifier).clearUiFilters();
  }
}

