// ignore_for_file: unused_result

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/dio_provider.dart';
import 'package:hously_flutter/utils/api_services.dart';

final removeCrmRevenueProvider =
    Provider((ref) => RemoveCrmRevenueProvider(ref));

class RemoveCrmRevenueProvider {
  final Ref ref;

  RemoveCrmRevenueProvider(this.ref);

  Future<void> removeCrmRevenue(int crmRevenueId) async {
    var response = await ApiServices.delete(
      URLs.deleteRevenuesCrm('$crmRevenueId'),
      hasToken: true,
    );

    if (response != null && response.statusCode == 204) {
      //tutaj dodaj odświeżenie listy zapisanych wyszukiwań
      ref.invalidate(crmRevenueProvider);
    }
  }
}
