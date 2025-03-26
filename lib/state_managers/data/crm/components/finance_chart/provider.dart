import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/crm/crm_expenses_download_model.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'dart:convert';


final revenueAndExpensesProvider = StateNotifierProvider<
    RevenueAndExpensesNotifier, AsyncValue<Map<String, List>>>((ref) {
  return RevenueAndExpensesNotifier(ref);
});

class RevenueAndExpensesNotifier
    extends StateNotifier<AsyncValue<Map<String, List>>> {
  RevenueAndExpensesNotifier(dynamic ref) : super(const AsyncValue.loading()) {
    fetchData(ref);
  }

  Future<void> fetchData(dynamic ref) async {
    try {
      // Równoczesne pobieranie danych przychodów i wydatków
      final responses = await Future.wait([
        ApiServices.get(ref: ref,URLs.financeAppExpenses, hasToken: true),
        ApiServices.get(ref: ref,URLs.financeAppRevenues, hasToken: true),
      ]);

      final expensesResponse = responses[0];
      final revenuesResponse = responses[1];

      if (expensesResponse == null ||
          expensesResponse.data == null ||
          revenuesResponse == null ||
          revenuesResponse.data == null) {
        state = AsyncValue.error(
          Exception('Invalid response for revenues or expenses'),
          StackTrace.current,
        );
        return;
      }

      // Dekodowanie wydatków
      final decodedExpensesBody = utf8.decode(expensesResponse.data);
      final decodeExpenses = json.decode(decodedExpensesBody) as List;
      final expenses = decodeExpenses
          .map((expense) => CrmExpensesDownloadModel.fromJson(expense))
          .toList();

      // Dekodowanie przychodów
      final decodedRevenuesBody = utf8.decode(revenuesResponse.data);
      final decodeRevenues = json.decode(decodedRevenuesBody) as List;
      final revenues = decodeRevenues
          .map((revenue) => AgentTransactionModel.fromJson(revenue))
          .toList();

      // Aktualizacja stanu z danymi
      state = AsyncValue.data({
        'expenses': expenses,
        'revenues': revenues,
      });
    } catch (error, stackTrace) {
      // Obsługa błędów
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
