import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/models/sale_model.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/models/sale_response_model.dart';
import 'package:hously_flutter/utils/api_services.dart';

class SalesNotifier extends StateNotifier<List<Sale>> {
  SalesNotifier() : super([]);

  Future<void> fetchSales(dynamic ref) async {
    try {
      final response = await ApiServices.get(
        URLs.fetchFlipperSales,
        ref: ref,
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        final responseString = utf8.decode(response.data);
        final jsonResponse = jsonDecode(responseString);
        final salesResponse = SalesResponse.fromJson(jsonResponse);
        state = salesResponse.results;
        print('Sales fetched successfully. Count: ${state.length}');
        for (var sale in state) {
          print(
              'Sale ID: ${sale.id}, Sale Price: ${sale.salePrice}, Status: ${sale.status}');
        }
      } else {
        print('Sales fetch failed. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error fetching sales: $e');
    }
  }

  Future<void> createSales(dynamic ref) async {
    try {
      final data = {
        "transaction": 1,
        "agent": 2,
        "client": 1,
        "sale_price": 300000.00,
        "profit_potential": 50000.00,
        "status": "follow_up",
        "sale_date": "2025-02-09",
        "created_at": "2025-02-09T12:00:00Z"
      };
      final response = await ApiServices.post(
        URLs.createFlipperSale,
        hasToken: true,
        data: data,
      );
      if (response != null && response.statusCode == 201) {
        print('Sale created successfully');
        await fetchSales(ref);
      } else {
        print('Sale creation failed. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error creating sale: $e');
    }
  }
}

final salesProvider = StateNotifierProvider<SalesNotifier, List<Sale>>(
  (ref) => SalesNotifier(),
);
