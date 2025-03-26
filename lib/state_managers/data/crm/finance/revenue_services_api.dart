import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/utils/api_services.dart';

final apiProviderRevenue = Provider<ApiServiceRevenue>((ref) => ApiServiceRevenue());

class ApiServiceRevenue {
  ApiServiceRevenue();

  Future<void> updateColumnIndexes(List<int> columnIds) async {
    final response = await ApiServices.patch(
      URLs.agentTransactionUpdateColumnIndexes,
      data: {'columns': columnIds},
      hasToken: true,
    );

    if (response != null && response.statusCode != 200) {
      throw Exception('Failed to update column indexes');
    }
  }

  Future<void> updateTransactionStatuses(
      List<Map<String, dynamic>> statuses) async {
    final response = await ApiServices.patch(
      URLs.updateAgentTransactionStatus,
      data: {'statuses': statuses},
      hasToken: true,
    );

    if (response != null && response.statusCode != 200) {
      throw Exception('Failed to update transaction statuses');
    }
  }
}
