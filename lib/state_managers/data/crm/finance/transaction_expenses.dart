import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/crm/crm_expenses_download_model.dart';
import 'package:hously_flutter/models/expenses_status_model.dart';
import 'package:hously_flutter/models/transaction/transaction_expenses_model.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/expenses_services_api.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'dart:convert';


const configUrl = URLs.baseUrl;
const defaultAvatarUrl = '$configUrl/media/avatars/avatar.jpg';


class ExpensesState {
  final List<TransactionExpensesModel> transactions;
  final List<ExpensesStatusModel> statuses;

  ExpensesState({required this.transactions, required this.statuses});
}

final expensesTransactionProvider =
    StateNotifierProvider<ExpensesNotifier, AsyncValue<ExpensesState>>((ref) {
  final apiService = ref.watch(apiProvider);
  return ExpensesNotifier(apiService,ref);
});

class ExpensesNotifier extends StateNotifier<AsyncValue<ExpensesState>> {
  final ApiServiceExpenses apiService;

  ExpensesNotifier(this.apiService,dynamic ref) : super(const AsyncValue.loading()) {
    fetchExpensesAndStatuses(ref);
  }

  Future<void> fetchExpensesAndStatuses(dynamic ref) async {
    try {
      // Pobieranie transakcji
      final transactionsResponse = await ApiServices.get(
        ref: ref,
        URLs.financeAppExpenses,
        hasToken: true,
      );
      if (transactionsResponse == null) return;

      final decodedDatabody = utf8.decode(transactionsResponse.data);
      final decodeData = json.decode(decodedDatabody) as List;

      final transactions = decodeData
          .map((expenses) => CrmExpensesDownloadModel.fromJson(expenses))
          .map((expenses) => TransactionExpensesModel.fromCrmExpensesDownload(expenses))
          .toList();

      // Pobieranie statusów
      final statusesResponse = await ApiServices.get(
        ref:ref,
        URLs.financeAppExpensesStatus,
        hasToken: true,
      );
      if (statusesResponse == null) return;
        final decodedStatusesBody = utf8.decode(statusesResponse.data);

        // Konwersja JSON na Mapę
        final listingsJsonStatuses = json.decode(decodedStatusesBody) as Map<String, dynamic>;

        // Pobranie listy "results"
        final newListStatuses = listingsJsonStatuses['results'] as List<dynamic>?;

        if (newListStatuses == null) {
          print("No results found");
          return;
        }

        // Mapowanie listy na model
        final statuses = newListStatuses.map((status) => ExpensesStatusModel.fromJson(status as Map<String, dynamic>))
            .toList();

      // Ustawianie stanu na pobrane transakcje i statusy
      state = AsyncValue.data(
        ExpensesState(transactions: transactions, statuses: statuses),
      );
    } catch (error) {
      // Obsłuż błąd w pobieraniu danych
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  void reorderTransaction(int oldIndex, int newIndex, String statusName) {
    print('Reordering transaction for status: $statusName');
    print('Old Index: $oldIndex, New Index: $newIndex');

    state = state.whenData((data) {
      final status =
          data.statuses.firstWhere((status) => status.statusName == statusName);

      // Logowanie przed przestawieniem elementów
      print('Before Reordering: ${status.transactionIndex}');

      // Tworzymy nową listę bez modyfikacji oryginalnej
      final newTransactionIndex = List<int>.from(status.transactionIndex);

      // Logowanie po przesunięciu
      print('After Reordering: $newTransactionIndex');

      // Tworzymy nową instancję TransactionState, aby zaktualizować stan
      final updatedState = ExpensesState(
        transactions: data.transactions,
        statuses: [
          for (final s in data.statuses)
            if (s.statusName == status.statusName)
              ExpensesStatusModel(
                id: s.id,
                statusName: s.statusName,
                statusIndex: s.statusIndex,
                transactionIndex:
                    newTransactionIndex, // Upewniamy się, że kopia jest aktualizowana
              )
            else
              s,
        ],
      );

      print(
          'State after reordering: ${updatedState.statuses.firstWhere((s) => s.statusName == statusName).transactionIndex}');
      return updatedState;
    });
  }

  void moveTransaction(TransactionExpensesModel transaction,
      String newStatusName, int? newIndex) {
    state = state.whenData((data) {
      final oldStatus = data.statuses.firstWhere(
          (status) => status.transactionIndex.contains(transaction.id));
      final newStatus = data.statuses
          .firstWhere((status) => status.statusName == newStatusName);

      oldStatus.transactionIndex.remove(transaction.id);

      if (newIndex != null && newIndex <= newStatus.transactionIndex.length) {
        newStatus.transactionIndex.insert(newIndex, transaction.id);
      } else {
        newStatus.transactionIndex.add(transaction.id);
      }

      final updatedState = ExpensesState(
          transactions: data.transactions, statuses: data.statuses);

      // Wyślij zaktualizowane listy transakcji dla obu statusów na serwer
      try {
        final statusesToUpdate = [
          {
            'id': oldStatus.id,
            'transaction_index': oldStatus.transactionIndex,
          },
          {
            'id': newStatus.id,
            'transaction_index': newStatus.transactionIndex,
          },
        ];

        apiService.updateTransactionStatuses(statusesToUpdate);
      } catch (e) {
        print("Failed to update transaction statuses: $e");
      }

      return updatedState;
    });
  }

  void reorderStatuses(List<ExpensesStatusModel> updatedStatuses) async {
    state = state.whenData((data) {
      // Aktualizujemy stan lokalnie
      final newState = ExpensesState(
          transactions: data.transactions, statuses: updatedStatuses);

      // Wyślij zmiany do API
      try {
        final columnIds = updatedStatuses.map((status) => status.id).toList();

        // Wywołaj API, aby zaktualizować kolejność kolumn
        apiService.updateColumnIndexes(columnIds);
      } catch (e) {
        // Obsługa błędów
        print("Failed to update column indexes: $e");
      }

      return newState;
    });
  }

  void updateColumnIndexes(List<int> columnIds) async {
    try {
      await apiService.updateColumnIndexes(columnIds);
    } catch (e) {
      // Obsługa błędów
      print("Failed to update column indexes: $e");
    }
  }

  void addTransaction(TransactionExpensesModel transaction) {
    state = state.whenData((data) => ExpensesState(
          transactions: [...data.transactions, transaction],
          statuses: data.statuses,
        ));
  }

  Future<void> addStatus(ExpensesStatusModel status,dynamic ref) async {
    try {
      await ApiServices.post(
        URLs.financeAppExpensesStatus,
        hasToken: true,
        data: {
          'name': status.statusName,
          'index': status.statusIndex,
        },
      );
      fetchExpensesAndStatuses(ref); // Odśwież listę statusów i transakcji
    } catch (e) {
      // Handle error
    }
  }

  // Utwórz nowy status
  Future<ExpensesStatusModel> createTransactionStatus(
      ExpensesStatusModel status,dynamic ref) async {
    final response = await ApiServices.post(
      URLs.financeAppExpensesStatus,
      data: status.toJson(),
      hasToken: true,
    );

    fetchExpensesAndStatuses(ref); // Odśwież listę statusów i transakcji
    return ExpensesStatusModel.fromJson(response!.data);
  }

  // Aktualizuj istniejący status
  Future<ExpensesStatusModel> updateTransactionStatus(
      ExpensesStatusModel status,dynamic ref) async {
    final response = await ApiServices.put(
      '${URLs.financeAppExpensesStatus}${status.id}/',
      data: status.toJson(),
      hasToken: true,
    );
    fetchExpensesAndStatuses(ref); // Odśwież listę statusów i transakcji
    return ExpensesStatusModel.fromJson(response!.data);
  }

  // Usuń status
  Future<void> deleteTransactionStatus(int id,dynamic ref) async {
    await ApiServices.delete(
      '${URLs.financeAppExpensesStatus}$id/',
      hasToken: true,
    );
    fetchExpensesAndStatuses(ref); // Odśwież listę statusów i transakcji
  }
}
