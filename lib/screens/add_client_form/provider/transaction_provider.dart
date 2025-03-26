import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/screens/add_client_form/components/buy/buy_from_filter_components.dart';

final crmOfferHoveredPropertyProvider = StateProvider<AdsListViewModel?>((ref) => null);

final agentTransactionCacheProvider =
    StateNotifierProvider<AgentTransactionCacheNotifier, Map<String, dynamic>>((ref) {
  return AgentTransactionCacheNotifier();
});


class AgentTransactionCacheNotifier extends StateNotifier<Map<String, dynamic>> {
  AgentTransactionCacheNotifier() : super({});

  Map<String, dynamic> filters = {};
  

  void addTransactionData(String key, dynamic value) {
    if (value != null && value.toString().isNotEmpty) {
      filters[key] = value;
      print(filters);
    } else {
      filters.remove(key);
    }
    state = {...state, 'transaction': filters};
    print(state);
  }

  void removeTransactionData(String key) {
    filters.remove(key);
    state = {...state, 'transaction': filters};
  }

  void clearTransactionData(WidgetRef ref) {
    filters.clear();
    state = {};
    ref.read(buyOfferfilterButtonProvider.notifier).clearUiFilters();
  }
}