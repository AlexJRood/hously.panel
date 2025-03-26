import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/utils/api_services.dart';

final stripeProvider = ChangeNotifierProvider((ref) => StripeProvider());

class StripeProvider extends ChangeNotifier {
  Future<void> stripeCheckout(int adId) async {
    final response = await ApiServices.post(
      URLs.stripeCheckout,
      hasToken: true,
      data: {'advertisement_id': adId},
    );
  }

  Future<void> getPayments(WidgetRef ref) async {
    final response = await ApiServices.get(ref:ref,URLs.userPayments, hasToken: true);
  }

  Future<void> handleWebhook() async {
    final response = await ApiServices.post(
      URLs.handleWebhook,
      hasToken: true,
      data: {"Stripe-Signature": "", "Stripe-Secret-key": ""},
    );
  }
}
