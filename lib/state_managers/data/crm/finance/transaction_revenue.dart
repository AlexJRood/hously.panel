import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
import 'package:hously_flutter/models/transaction/transaction_status_model.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/revenue_services_api.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'dart:convert';




class TransactionState {
  final List<AgentTransactionModel> transactions;
  final List<TransactionStatus> statuses;

  TransactionState({required this.transactions, required this.statuses});
}

final transactionProvider = StateNotifierProvider<TransactionNotifier, AsyncValue<TransactionState>>((ref) {
  final apiService = ref.watch(apiProviderRevenue);
  return TransactionNotifier(apiService,ref);
});

class TransactionNotifier extends StateNotifier<AsyncValue<TransactionState>> {
  final ApiServiceRevenue apiService;

  TransactionNotifier(this.apiService,dynamic ref) : super(const AsyncValue.loading()) {
    fetchTransactionsAndStatuses(ref);
  }

  Future<void> fetchTransactionsAndStatuses(dynamic ref) async {
    try {
      // Pobieranie transakcji
      final transactionsResponse = await ApiServices.get(
        ref: ref,
        URLs.agentTransactionsCrm,
        hasToken: true,
      );
      if (transactionsResponse == null) return;
      final decodedDatabody = utf8.decode(transactionsResponse.data);
      final decodedJson = json.decode(decodedDatabody);

// Ensure the API response is a list
      final decodeData = (decodedJson is List) ? decodedJson : (decodedJson['results'] as List);

      final transactions = decodeData
          .map((revenue) => AgentTransactionModel.fromJson(revenue)).toList();

      // Pobieranie statusów
      final statusesResponse = await ApiServices.get(
        ref: ref,
        URLs.getAgentTransactionStatus,
        hasToken: true,
      );
      if (statusesResponse == null) return;

            final decodedStatusesBody = utf8.decode(statusesResponse.data);

            // Parsowanie JSON na Mapę
            final listingsJson = json.decode(decodedStatusesBody) as Map<String, dynamic>;

            // Pobranie listy "results"
      final decodeStatuses = (listingsJson['results'] is List)
          ? listingsJson['results'] as List<dynamic>
          : [];

            if (decodeStatuses == null || decodeStatuses.isEmpty) {
              print("No results found in the response");
              return;
            }

            final statuses = decodeStatuses
                .map((status) => TransactionStatus.fromJson(status as Map<String, dynamic>))
                .toList();


      state = AsyncValue.data(
          TransactionState(transactions: transactions, statuses: statuses));
    } catch (error) {
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
      final updatedState = TransactionState(
        transactions: data.transactions,
        statuses: [
          for (final s in data.statuses)
            if (s.statusName == status.statusName)
              TransactionStatus(
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

  void moveTransaction(
      AgentTransactionModel transaction, String newStatusName, int? newIndex) {
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

      final updatedState = TransactionState(
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

  void reorderStatuses(List<TransactionStatus> updatedStatuses) async {
    state = state.whenData((data) {
      // Aktualizujemy stan lokalnie
      final newState = TransactionState(
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

  void addTransaction(AgentTransactionModel transaction) {
    state = state.whenData((data) => TransactionState(
          transactions: [...data.transactions, transaction],
          statuses: data.statuses,
        ));
  }

  Future<void> addStatus(TransactionStatus status,dynamic ref) async {
    try {
      await ApiServices.post(
        URLs.getAgentTransactionStatus,
        data: {
          'name': status.statusName,
          'index': status.statusIndex,
        },
        hasToken: true,
      );
      fetchTransactionsAndStatuses(ref); // Odśwież listę statusów i transakcji
    } catch (e) {
      // Handle error
    }
  }

  // Utwórz nowy status
  Future<TransactionStatus> createTransactionStatus(
      TransactionStatus status,dynamic ref) async {
    final response = await ApiServices.post(
      URLs.getAgentTransactionStatus,
      data: status.toJson(),
      hasToken: true,
    );
    fetchTransactionsAndStatuses(ref); // Odśwież listę statusów i transakcji
    return TransactionStatus.fromJson(response!.data);
  }

  // Aktualizuj istniejący status
  Future<TransactionStatus> updateTransactionStatus(
      TransactionStatus status,dynamic ref) async {
    final response = await ApiServices.put(
      '${URLs.getAgentTransactionStatus}/${status.id}/',
      data: status.toJson(),
      hasToken: true,
    );
    fetchTransactionsAndStatuses(ref); // Odśwież listę statusów i transakcji
    return TransactionStatus.fromJson(response!.data);
  }

  // Usuń status
  Future<void> deleteTransactionStatus(int id,dynamic ref) async {
    await ApiServices.delete(
      '${URLs.getAgentTransactionStatus}/$id/',
      hasToken: true,
    );
    fetchTransactionsAndStatuses(ref); // Odśwież listę statusów i transakcji
  }
}
