import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/models/crm/user_contact_status_model.dart';
import 'package:hously_flutter/utils/api_services.dart';

final clientProvider = StateNotifierProvider<ClientNotifier, AsyncValue<List<UserContactModel>>>((ref) {
  return ClientNotifier();
});

class ClientNotifier extends StateNotifier<AsyncValue<List<UserContactModel>>> {
  ClientNotifier() : super(const AsyncValue.loading()) {
     fetchStatuses(Ref);
    fetchClients();
  }



Future<List<UserContactStatusModel>> fetchStatuses(dynamic ref) async {
  try {
    final response = await ApiServices.get(
      ref: ref,
      URLs.addUserContactsStatuses,
      hasToken: true,
    );

      if (response == null || response.data == null) {
        throw Exception('No response or data is null');
      }

      if (response.statusCode == 200) {
          final decodedBody = utf8.decode(response.data);
          final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;
          final statusesResults = listingsJson['results'] as List<dynamic>;

        
          final statuses = statusesResults.map((item) => UserContactStatusModel.fromJson(item as Map<String, dynamic>)).toList();
          return statuses;

      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load statuses: $error');
    }
  }

  

  int? _lastStatus;
  String? _lastSort;
  String? _lastSearchQuery;

  // Zaktualizowana funkcja fetchClients z obsługą wyszukiwania
  Future<void> fetchClients({
    int? status,
    String? sort,
    String? searchQuery,
    dynamic ref,
  }) async {
    try {
      // Update stored values
      _lastStatus = status;
      _lastSort = sort ?? _lastSort;
      _lastSearchQuery = searchQuery ?? _lastSearchQuery;

      final queryParams = {
        if (_lastSort != null) 'sort': _lastSort,
        if (_lastSearchQuery != null) 'search': _lastSearchQuery,
        if (_lastStatus != null) 'status': _lastStatus, // Only include if not null
      };

      final response = await ApiServices.get(
        ref: ref,
        URLs.userContacts,
        queryParameters: queryParams,
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        final decodedBody = utf8.decode(response.data);
        final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;
        final newList = listingsJson['results'] as List<dynamic>;

        final clients = newList.map(
              (item) => UserContactModel.fromJson(item as Map<String, dynamic>),
        ).toList();

        state = AsyncValue.data(clients);
      } else {
        state = AsyncValue.error('Failed to load contacts', StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Funkcja do odświeżania danych z ostatnio użytymi parametrami
  Future<void> refreshClients() async {
    return  fetchClients();
     fetchStatuses(Ref);
  }



// New method to fetch the list of clients and return it
Future<List<UserContactModel>> fetchClientsList({
  int? status,
  String? sort,
  String? searchQuery,
  dynamic ref,
}) async {
  try {
    // Jeśli nie podano statusu, sortowania lub zapytania, używamy ostatnich wartości
    _lastStatus = status ?? _lastStatus;
    _lastSort = sort ?? _lastSort;
    _lastSearchQuery = searchQuery ?? _lastSearchQuery;

    final queryParams = {
      if (_lastStatus != null) 'status': _lastStatus,
      if (_lastSort != null) 'sort': _lastSort,
      if (_lastSearchQuery != null) 'search': _lastSearchQuery,
    };

    debugPrint('Mahdi: fetchClients: $queryParams : ${URLs.userContacts}');

    final response = await ApiServices.get(
      ref: ref,
      URLs.userContacts,
      queryParameters: queryParams,
      hasToken: true,
    );

    if (response != null && response.statusCode == 200) {
      final decodedBody = json.decode(utf8.decode(response.data));
      final listingsJson = decodedBody as Map<String, dynamic>;
      final newList = listingsJson['results'] as List<dynamic>;

      final clients = newList.map((item) => UserContactModel.fromJson(item as Map<String, dynamic>)).toList();

      state = AsyncValue.data(clients);
      return clients;
    } else {
      throw Exception("Błąd API: ${response?.statusCode}");
    }
  } catch (error, stackTrace) {
    state = AsyncValue.error(error, stackTrace);
    debugPrint("Błąd w fetchClientsList: $error");
    return [];
  }
}


  Future<void> addClient(UserContactModel client) async {
    try {
      final response = await ApiServices.post(
        URLs.clientsCreate,
        data: client.toJson(),
        hasToken: true,
      );

      if (response != null && response.statusCode == 201) {
        fetchClients();
      } else {
        print('Failed to create client: ');
      }
    } catch (error, stackTrace) {
      print('Error adding client: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateClient(int id, UserContactModel client) async {
    try {
      final response = await ApiServices.put(
        URLs.clientsUpdate('$id'),
        data: client.toJson(),
        hasToken: true,
      );
      if (response == null) {
        state =
            AsyncValue.error(Exception('Invalid request.'), StackTrace.current);
        return;
      }
      fetchClients();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteClient(int id) async {
    try {
      final response = await ApiServices.delete(
        URLs.clientsDelete('$id'),
        hasToken: true,
      );

      if (response == null) {
        state =
            AsyncValue.error(Exception('Invalid request.'), StackTrace.current);
        return;
      }
      fetchClients();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateClientStatus(int id, int newStatus) async {
    try {
      final response = await ApiServices.post(
        URLs.userContactStatusUpdate(id),
        hasToken: true,
        data: {'status': newStatus},
      );

      if (response != null && response.statusCode == 200) {
        // Jeśli zmiana statusu zakończyła się sukcesem, odśwież listę klientów
        fetchClients();
      } else {
        throw Exception('Failed to update status:');
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      throw error; // Ponownie rzucamy wyjątek, aby widget mógł obsłużyć błąd
    }
  }
}
