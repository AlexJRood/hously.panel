import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/models/revenue_model.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/models/revenue_response_model.dart';
import 'package:hously_flutter/utils/api_services.dart';

class RevenueNotifier extends StateNotifier<List<Revenue>> {
  RevenueNotifier() : super([]);

  Future<void> fetchRevenue(dynamic ref) async {
    try {
      final response = await ApiServices.get(
        URLs.fetchRevenues,
        ref: ref,
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        final responseString = utf8.decode(response.data);
        final jsonResponse = jsonDecode(responseString);
        final revenueResponse = RevenueResponse.fromJson(jsonResponse);
        state = revenueResponse.results;
        print('Revenues fetched successfully. Count: ${state.length}');
        for (var revenue in state) {
          print(
              'Revenue ID: ${revenue.id}, Title: ${revenue.title}, Amount: ${revenue.amount}');
        }
      } else {
        print('Revenue fetch failed. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error fetching revenues: $e');
    }
  }

  Future<void> createRevenue(dynamic ref) async {
    try {
      final data = {
        "title": "Property Sale Revenue",
        "transaction": 1,
        "amount": 250000.00,
        "date": "2025-02-09"
      };
      final response = await ApiServices.post(URLs.createRevenue,
          hasToken: true, data: data);
      if (response != null && response.statusCode == 201) {
        print('Revenue created successfully');
        await fetchRevenue(ref);
      } else {
        print('Revenue creation failed. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error creating revenue: $e');
    }
  }
}

final revenueProvider = StateNotifierProvider<RevenueNotifier, List<Revenue>>(
  (ref) => RevenueNotifier(),
);
