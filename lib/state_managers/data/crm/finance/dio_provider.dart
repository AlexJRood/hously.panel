import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
import 'package:hously_flutter/models/crm/crm_revenue_upload_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'dart:convert';

final crmRevenueProvider = StateNotifierProvider<CrmRevenueNotifier,
    AsyncValue<List<AgentTransactionModel>>>((ref) {
  return CrmRevenueNotifier();
});

class CrmRevenueNotifier
    extends StateNotifier<AsyncValue<List<AgentTransactionModel>>> {
  CrmRevenueNotifier() : super(const AsyncValue.loading()) {
    fetchRevenue();
  }

  Future<void> fetchRevenue(
      {List<int>? years, List<int>? months, String? ordering,dynamic ref}) async {
    try {
      final now = DateTime.now();
      // Use current year and month if no filter is provided
      final effectiveYears =
          (years == null || years.isEmpty) ? [now.year] : years;
      final effectiveMonths =
          (months == null || months.isEmpty) ? [now.month] : months;
      final queryParams = {
        'year': effectiveYears.join(','),
        'month': effectiveMonths.join(','),
        'sort': ordering ?? 'amount',
      };
      final response = await ApiServices.get(
        ref: ref,
        URLs.agentTransactionsCrm,
        queryParameters: queryParams,
        hasToken: true,
      );

      if (response == null) {
        state = const AsyncValue.data([]);

        return;
      }
      final decodedDatabody = utf8.decode(response.data);
      final decodeData = json.decode(decodedDatabody) as List;
      final revenues = decodeData.map((revenue) => AgentTransactionModel.fromJson(revenue)).toList();
      
      state = AsyncValue.data(revenues);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addRevenue(CrmRevenueUploadModel revenue) async {
    try {
      final response = await ApiServices.post(
        URLs.createCrm,
        data: revenue.toJson(),
        hasToken: true,
      );
      if (response != null && response.statusCode == 201) {
        fetchRevenue();
      } else {
        print('Failed to create revenue: ');
      }
    } catch (error, stackTrace) {
      print('Error adding revenue: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateRevenue(int id, AgentTransactionModel revenue) async {
    try {
      final response = await ApiServices.put(
        URLs.updateRevenuesCrm('$id'),
        data: revenue.toJson(),
        hasToken: true,
      );

      if (response == null) return;

      fetchRevenue();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteRevenue(int id) async {
    try {
      final response = await ApiServices.delete(
        URLs.deleteRevenuesCrm('$id'),
        hasToken: true,
      );

      if (response == null) return;

      fetchRevenue();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
