import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/utils/api_services.dart';

final apiProvider = Provider<ApiServiceExpenses>((ref) => ApiServiceExpenses());

class ApiServiceExpenses {
  ApiServiceExpenses();

  Future<void> updateColumnIndexes(List<int> columnIds) async {
    final response = await ApiServices.patch(
      URLs.expensesUpdateColumn,
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
      URLs.expensesUpdateTransaction,
      data: {'statuses': statuses},
      hasToken: true,
    );

    if (response != null && response.statusCode != 200) {
      throw Exception('Failed to update transaction statuses');
    }
  }
}
