import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/api_services/url.dart';

final apiProviderRevenue = Provider<ApiServiceBoard>((ref) => ApiServiceBoard());

class ApiServiceBoard {
  ApiServiceBoard();

  Future<void> updateColumnIndexes(List<int> columnIds) async {
    final response = await ApiServices.patch(
      URLs.leadUpdateColumnIndexes,
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
      URLs.updateLeadStatus,
      data: {'statuses': statuses},
      hasToken: true,
    );

    if (response != null && response.statusCode != 200) {
      throw Exception('Failed to update transaction statuses');
    }
  }
}
