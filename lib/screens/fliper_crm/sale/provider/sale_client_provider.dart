import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/models/sale_client_model.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/models/sale_client_response_model.dart';
import 'package:hously_flutter/utils/api_services.dart';

class SaleClientNotifier extends StateNotifier<List<SaleClient>> {
  SaleClientNotifier() : super([]);

  Future<void> fetchSaleClient(dynamic ref) async {
    try {
      final response = await ApiServices.get(
        URLs.fetchSaleClient,
        ref: ref,
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        final responseString = utf8.decode(response.data);
        final jsonResponse = jsonDecode(responseString);
        final saleClientResponse = SaleClientResponse.fromJson(jsonResponse);
        state = saleClientResponse.results;
        print('Sale clients fetched successfully. Count: ${state.length}');
        for (var client in state) {
          print(
              'Client ID: ${client.id}, Full Name: ${client.fullName}, Email: ${client.email}');
        }
      } else {
        print(
            'Sale clients fetch failed. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error fetching sale clients: $e');
    }
  }

  Future<void> createSaleClient(dynamic ref) async {
    try {
      final body = {
        "user": 1,
        "full_name": "John Doe",
        "email": "younis@example.com",
        "phone_number": "+1234567890"
      };
      final response = await ApiServices.post(URLs.createSaleClient,
          hasToken: true, data: body);
      if (response != null && response.statusCode == 201) {
        print('Sale client created successfully');
        await fetchSaleClient(ref);
      } else {
        print(
            'Sale client creation failed. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error creating sale client: $e');
    }
  }
}

final saleClientProvider =
    StateNotifierProvider<SaleClientNotifier, List<SaleClient>>(
  (ref) => SaleClientNotifier(),
);
