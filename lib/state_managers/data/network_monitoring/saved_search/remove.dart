// ignore_for_file: unused_result

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_saved_search.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/saved_search/api.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';

final removeSavedSearchProvider =
    Provider((ref) => RemoveSavedSearchProvider(ref));

class RemoveSavedSearchProvider {
  final Ref ref;
  final SecureStorage secureStorage = SecureStorage();

  RemoveSavedSearchProvider(this.ref);

  Future<void> removeSavedSearch(int savedSearchId) async {
    if (ApiServices.token == null) return;

    final response = await ApiServices.delete(
      URLs.deleteSavedSearch('$savedSearchId'),
      hasToken: true,
    );

    if (response != null && response.statusCode == 204) {
      //tutaj dodaj odświeżenie listy zapisanych wyszukiwań
      ref.invalidate(savedSearchesProvider);
      ref.invalidate(clientSavedSearchesProvider);
    }
  }
}
