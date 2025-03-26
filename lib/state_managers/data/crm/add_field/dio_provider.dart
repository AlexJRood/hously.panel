import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/models/crm/crm_revenue_upload_model.dart';
import 'package:hously_flutter/state_managers/data/crm/add_field/sell_offer_provider.dart';
import 'package:hously_flutter/utils/api_services.dart';

final crmClientTransactionOfferProvider =
    StateNotifierProvider<CrmClientTransactionOfferNotifier, AsyncValue<void>>(
        (ref) {
  return CrmClientTransactionOfferNotifier();
});

class CrmClientTransactionOfferNotifier
    extends StateNotifier<AsyncValue<void>> {
  CrmClientTransactionOfferNotifier() : super(const AsyncValue.data(null));

  Future<void> addClientTransactionOffer({
    required UserContactModel client,
    required CrmRevenueUploadModel transaction,
    required CrmAddSellOfferState offer,
  }) async {
    try {
      final response = await ApiServices.post(
        URLs.estateAgentAddSellOffer,
        hasToken: true,
        data: {
          'client': client.toJson(),
          'transaction': transaction.toJson(),
          'offer': offer.toJson(),
        },
      );

      if (response != null && response.statusCode == 201) {
        state = const AsyncValue.data(null);
      } else {
        state = AsyncValue.error(
          Exception('Failed to create client, transaction, and offer'),
          StackTrace.current,
        );
      }
    } catch (error, stackTrace) {
      print('Error creating client, transaction, and offer: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
