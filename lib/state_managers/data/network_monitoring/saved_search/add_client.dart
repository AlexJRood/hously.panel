import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_saved_search.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';

final addClientToSavedSearch = Provider<AddSavedSearchToClientService>((ref) {
  return AddSavedSearchToClientService(ref);
});

Future<void> addClientsToSavedSearch(
    BuildContext context, dynamic savedSearchId, WidgetRef ref) async {
  final clientListAsyncValue = ref.watch(clientProvider);

  final selectedClients = await showDialog<Set<int>>(
    context: context,
    builder: (context) {
      final selected = <int>{};
      return AlertDialog(
        title: const Text('Dodaj klientów do zapisanego wyszukiwania'),
        content: clientListAsyncValue.when(
          data: (clients) => Column(
            mainAxisSize: MainAxisSize.min,
            children: clients.map((client) {
              return CheckboxListTile(
                title: Text('${client.name} ${client.lastName}'),
                value: selected.contains(client.id),
                onChanged: (isSelected) {
                  if (isSelected == true) {
                    selected.add(client.id);
                  } else {
                    selected.remove(client.id);
                  }
                },
              );
            }).toList(),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Failed to load clients: $error'),
        ),
        actions: [
          TextButton(
            onPressed: () => ref.read(navigationService).beamPop(),
            child:  Text('Anuluj'.tr),
          ),
          TextButton(
            onPressed: () => ref.read(navigationService).beamPop(selected),
            child: const Text('Dodaj'),
          ),
        ],
      );
    },
  );

  if (selectedClients != null && selectedClients.isNotEmpty) {
    for (var clientId in selectedClients) {
      await ref
          .read(addClientToSavedSearch)
          .addClientToSavedSearch(clientId, savedSearchId);
    }
    context.showSnackBarLikeSection(
        'Klienci zostali dodani do zapisanego wyszukiwania.');
  }
}

class AddSavedSearchToClientService {
  final Ref ref;
  const AddSavedSearchToClientService(this.ref);

  Future<void> addClientToSavedSearch(int clientId, int savedSearchId) async {
    try {
      final response = await ApiServices.post(
        URLs.clientSavedSearch('$clientId', '$savedSearchId'),
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        ref.invalidate(clientSavedSearchesProvider);
      }

      if (response == null || response.statusCode != 200) {
        throw Exception('Failed to add client to saved search');
      }
    } catch (e) {
      print('Error adding client to saved search: $e');
      rethrow;
    }
  }
}

extension ContextExtension on BuildContext {
  void showSnackBarLikeSection(String message) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
