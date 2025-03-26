import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/crm/clients_model.dart';
import 'package:hously_flutter/models/crm/user_contact_status_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'dart:convert';
import 'statuses_user_contacts_api.dart';



class UserContactState {
  final List<UserContactModel> userContacts;
  final List<UserContactStatusModel> contactStatuses;

  UserContactState({required this.userContacts, required this.contactStatuses});
}

final userContactsProvider = StateNotifierProvider<UserContactsNotifier, AsyncValue<UserContactState>>((ref) {
  final apiService = ref.watch(apiProviderUserContactsStatuses);
  return UserContactsNotifier(apiService,ref);
});

class UserContactsNotifier extends StateNotifier<AsyncValue<UserContactState>> {
  final ApiServiceUserContactsStatuses apiService;

  UserContactsNotifier(this.apiService, dynamic ref) : super(const AsyncValue.loading()) {
    fetchUserContactsAndStatuses(ref);
  }

  

  int? statusUserContact;
  String? sortUserContact;
  String? searchQueryUserContact;
  


  Future<void> fetchUserContactsAndStatuses(dynamic ref) async {
    try {

      final queryParams = {
        if (statusUserContact != null) 'status': statusUserContact,
        if (sortUserContact != null) 'sort': sortUserContact,
        if (searchQueryUserContact != null) 'search': searchQueryUserContact,
      };

      final contactsResponse = await ApiServices.get(
        ref: ref,
        URLs.userContacts,
        queryParameters: queryParams,
        hasToken: true,
      );
      if (contactsResponse == null) return;
          final decodedBody = utf8.decode(contactsResponse.data);
          final listingsJson = json.decode(decodedBody) as Map<dynamic, dynamic>;
          final newList = listingsJson['results'] as List<dynamic>;
          

          final contactsList = newList.map((item) => UserContactModel.fromJson(item)).toList();

      
      // Pobieranie statusów
      final statusesResponse = await ApiServices.get(
        ref: ref,
        URLs.userContactsStatuses,
        hasToken: true,
      );
      if (statusesResponse == null) return;
            final decodedStatusesBody = utf8.decode(statusesResponse.data);
            final statusesJson = json.decode(decodedStatusesBody) as Map<String, dynamic>;
            final decodeStatuses = statusesJson['results'] as List<dynamic>?;

            if (decodeStatuses == null || decodeStatuses.isEmpty) {
              print("No results found in the response");
              return;
            }
            final statuses = decodeStatuses
                .map((status) => UserContactStatusModel.fromJson(status as Map<String, dynamic>))
                .toList();


      state = AsyncValue.data(UserContactState(userContacts: contactsList, contactStatuses: statuses));
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  // Funkcja do odświeżania danych z ostatnio użytymi parametrami
  Future<void> refreshClients() async {
    return fetchUserContactsAndStatuses(Ref); // Wywołujemy bez parametrów, więc używane będą ostatnie
  }


  void reorderUserContact(int oldIndex, int newIndex, String statusName) {
    print('Reordering userContact for status: $statusName');
    print('Old Index: $oldIndex, New Index: $newIndex');

    state = state.whenData((data) {
      final status = data.contactStatuses.firstWhere((status) => status.statusName == statusName);

      // Logowanie przed przestawieniem elementów
      print('Before Reordering: ${status.contactIndex}');

      // Tworzymy nową listę bez modyfikacji oryginalnej
      final newcontactIndex = List<int>.from(status.contactIndex);

      // Logowanie po przesunięciu
      print('After Reordering: $newcontactIndex');

      // Tworzymy nową instancję userContactState, aby zaktualizować stan
      final updatedState = UserContactState(
        userContacts: data.userContacts,
        contactStatuses: [
          for (final s in data.contactStatuses)
            if (s.statusName == status.statusName)
              UserContactStatusModel(
                statusId: s.statusId,
                statusName: s.statusName,
                statusIndex: s.statusIndex,
                contactIndex: newcontactIndex, // Upewniamy się, że kopia jest aktualizowana
              )
            else
              s,
        ],
      );

      print(
          'State after reordering: ${updatedState.contactStatuses.firstWhere((s) => s.statusName == statusName).contactIndex}');
      return updatedState;
    });
  }

  void moveUserContact(UserContactModel userContact, String newStatusName, int? newIndex) {
    state = state.whenData((data) {
      final oldStatus = data.contactStatuses.firstWhere(
          (status) => status.contactIndex.contains(userContact.id));
      final newStatus = data.contactStatuses
          .firstWhere((status) => status.statusName == newStatusName);

      oldStatus.contactIndex.remove(userContact.id);

      if (newIndex != null && newIndex <= newStatus.contactIndex.length) {
        newStatus.contactIndex.insert(newIndex, userContact.id);
      } else {
        newStatus.contactIndex.add(userContact.id);
      }

      final updatedState = UserContactState(userContacts: data.userContacts, contactStatuses: data.contactStatuses);

      // Wyślij zaktualizowane listy transakcji dla obu statusów na serwer
      try {
        final statusesToUpdate = [
          {
            'id': oldStatus.statusId,
            'userContact_index': oldStatus.contactIndex,
          },
          {
            'id': newStatus.statusId,
            'userContact_index': newStatus.contactIndex,
          },
        ];

        apiService.updateUserContactStatuses(statusesToUpdate);
      } catch (e) {
        print("Failed to update userContact statuses: $e");
      }

      return updatedState;
    });
  }

  void reorderStatuses(List<UserContactStatusModel> updatedStatuses) async {
    state = state.whenData((data) {
      // Aktualizujemy stan lokalnie
      final newState =  UserContactState(userContacts: data.userContacts, contactStatuses: data.contactStatuses);

      // Wyślij zmiany do API
      try {
        final columnIds = updatedStatuses.map((status) => status.statusId).toList();

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

  void adduserContact(UserContactModel userContactModel) {
    state = state.whenData((data) => UserContactState(
          userContacts: [...data.userContacts, userContactModel],
          contactStatuses: data.contactStatuses,
        ));
  }

  Future<void> addStatus(UserContactStatusModel status,dynamic ref) async {
    try {
      await ApiServices.post(
        URLs.addUserContactsStatuses,
        data: {
          'name': status.statusName,
          'index': status.statusIndex,
        },
        hasToken: true,
      );
      fetchUserContactsAndStatuses(ref); // Odśwież listę statusów i transakcji
    } catch (e) {
      // Handle error
    }
  }

  // Utwórz nowy status
  Future<UserContactStatusModel> createUserContactStatus(UserContactStatusModel status,dynamic ref) async {
    final response = await ApiServices.post(
      URLs.addUserContactsStatuses,
      data: status.toJson(),
      hasToken: true,
    );
    fetchUserContactsAndStatuses(ref); // Odśwież listę statusów i transakcji
    return UserContactStatusModel.fromJson(response!.data);
  }

  // Aktualizuj istniejący status
  Future<UserContactStatusModel> updateUserContactStatus(
      UserContactStatusModel status,dynamic ref) async {
    final response = await ApiServices.patch(
      '${URLs.userContactsStatuses}${status.statusId}/',
      data: status.toJson(),
      hasToken: true,
    );
    fetchUserContactsAndStatuses(ref); // Odśwież listę statusów i transakcji
    return UserContactStatusModel.fromJson(response!.data);
  }

    // Aktualizuj istniejący status
  Future<void> updateUserContactStatusById(UserContactModel contact, UserContactStatusModel status, dynamic ref) async {
    await ApiServices.post(
      URLs.userContactStatusUpdate(contact.id),
      data: status.toJson(),
      hasToken: true,
    );
    fetchUserContactsAndStatuses(ref);
  }


  // Usuń status
  Future<void> deleteuserContactStatus(int id,dynamic ref) async {
    await ApiServices.delete(
      '${URLs.userContactsStatuses}/$id/',
      hasToken: true,
    );
    fetchUserContactsAndStatuses(ref); // Odśwież listę statusów i transakcji
  }
}

