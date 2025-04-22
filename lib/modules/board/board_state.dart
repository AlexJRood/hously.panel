import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/modules/board/services_api.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'dart:convert';




class BoardState {
  final List<Lead> transactions;
  final List<LeadStatus> statuses;

  BoardState({required this.transactions, required this.statuses});
}

final leadProvider = StateNotifierProvider<TransactionNotifier, AsyncValue<BoardState>>((ref) {
  final apiService = ref.watch(apiProviderRevenue);
  return TransactionNotifier(apiService,ref);
});

class TransactionNotifier extends StateNotifier<AsyncValue<BoardState>> {
  final ApiServiceBoard apiService;

  TransactionNotifier(this.apiService,dynamic ref) : super(const AsyncValue.loading()) {
    fetchTransactionsAndStatuses(ref);
  }

  Future<void> fetchTransactionsAndStatuses(dynamic ref) async {
    try {
      // Pobieranie transakcji
      final transactionsResponse = await ApiServices.get(
        ref: ref,
        URLs.leads,
        hasToken: true,
      );
      if (transactionsResponse == null) return;
      final decodedDatabody = utf8.decode(transactionsResponse.data);
      final decodedJson = json.decode(decodedDatabody);

// Ensure the API response is a list
      final decodeData = (decodedJson is List) ? decodedJson : (decodedJson['results'] as List);

      final transactions = decodeData
          .map((revenue) => Lead.fromJson(revenue)).toList();

      // Pobieranie statusów
      final statusesResponse = await ApiServices.get(
        ref: ref,
        URLs.getLeadStatus,
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
                .map((status) => LeadStatus.fromJson(status as Map<String, dynamic>))
                .toList();


      state = AsyncValue.data(
          BoardState(transactions: transactions, statuses: statuses));
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
      print('Before Reordering: ${status.leadIndex}');

      // Tworzymy nową listę bez modyfikacji oryginalnej
      final newleadIndex = List<int>.from(status.leadIndex);

      // Logowanie po przesunięciu
      print('After Reordering: $newleadIndex');

      // Tworzymy nową instancję TransactionState, aby zaktualizować stan
      final updatedState = BoardState(
        transactions: data.transactions,
        statuses: [
          for (final s in data.statuses)
            if (s.statusName == status.statusName)
              LeadStatus(
                id: s.id,
                statusName: s.statusName,
                statusIndex: s.statusIndex,
                leadIndex:
                    newleadIndex, // Upewniamy się, że kopia jest aktualizowana
              )
            else
              s,
        ],
      );

      print(
          'State after reordering: ${updatedState.statuses.firstWhere((s) => s.statusName == statusName).leadIndex}');
      return updatedState;
    });
  }

  void moveTransaction(
      Lead transaction, String newStatusName, int? newIndex) {
    state = state.whenData((data) {
      final oldStatus = data.statuses.firstWhere(
          (status) => status.leadIndex.contains(transaction.id));
      final newStatus = data.statuses
          .firstWhere((status) => status.statusName == newStatusName);

      oldStatus.leadIndex.remove(transaction.id);

      if (newIndex != null && newIndex <= newStatus.leadIndex.length) {
        newStatus.leadIndex.insert(newIndex, transaction.id);
      } else {
        newStatus.leadIndex.add(transaction.id);
      }

      final updatedState = BoardState(
          transactions: data.transactions, statuses: data.statuses);

      // Wyślij zaktualizowane listy transakcji dla obu statusów na serwer
      try {
        final statusesToUpdate = [
          {
            'id': oldStatus.id,
            'lead_index': oldStatus.leadIndex,
          },
          {
            'id': newStatus.id,
            'lead_index': newStatus.leadIndex,
          },
        ];

        apiService.updateTransactionStatuses(statusesToUpdate);
      } catch (e) {
        print("Failed to update transaction statuses: $e");
      }

      return updatedState;
    });
  }

  void reorderStatuses(List<LeadStatus> updatedStatuses) async {
    state = state.whenData((data) {
      // Aktualizujemy stan lokalnie
      final newState = BoardState(
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

  void addTransaction(Lead transaction) {
    state = state.whenData((data) => BoardState(
          transactions: [...data.transactions, transaction],
          statuses: data.statuses,
        ));
  }

  Future<void> addStatus(LeadStatus status,dynamic ref) async {
    try {
      await ApiServices.post(
        URLs.getLeadStatus,
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
  Future<LeadStatus> createTransactionStatus(
      LeadStatus status,dynamic ref) async {
    final response = await ApiServices.post(
      URLs.getLeadStatus,
      data: status.toJson(),
      hasToken: true,
    );
    fetchTransactionsAndStatuses(ref); // Odśwież listę statusów i transakcji
    return LeadStatus.fromJson(response!.data);
  }

  // Aktualizuj istniejący status
  Future<LeadStatus> updateTransactionStatus(
      LeadStatus status,dynamic ref) async {
    final response = await ApiServices.patch(
      '${URLs.getLeadStatus}${status.id}/',
      data: status.toJson(),
      hasToken: true,
    );
    fetchTransactionsAndStatuses(ref); // Odśwież listę statusów i transakcji
    return LeadStatus.fromJson(response!.data);
  }

  // Usuń status
  Future<void> deleteTransactionStatus(int id,dynamic ref) async {
    await ApiServices.delete(
      '${URLs.getLeadStatus}$id/',
      hasToken: true,
    );
    fetchTransactionsAndStatuses(ref); // Odśwież listę statusów i transakcji
  }
}
