import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_saved_search.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/saved_search/api.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';

final editSavedSearchProvider = Provider<EditSavedSearchService>((ref) {
  return EditSavedSearchService(ref);
});

class EditSavedSearchService {
  final Ref ref;

  const EditSavedSearchService(this.ref);

  Future<void> editClient(int savedSearchId, Map<String, String> data) async {
    try {
      final response = await ApiServices.put(
        URLs.editSavedSearch('$savedSearchId'),
        data: data,
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        //tutaj dodaj odświeżenie listy zapisanych wyszukiwań
        ref.invalidate(savedSearchesProvider);
      }

      if (response != null && response.statusCode == 200) {
        ref.invalidate(clientSavedSearchesProvider);
      }

      if (response != null && response.statusCode != 200) {
        throw Exception('Failed to edit saved search');
      }
    } catch (e) {
      print('Error editing saved search: $e');
      rethrow;
    }
  }
}

Future<void> showEditSavedSearchDialog(BuildContext context, dynamic action,
    dynamic actionId, WidgetRef ref) async {
  // Wyodrębnij odpowiednie dane z instancji `SavedSearch`
  final title = action.title ?? '';
  final description = action.description ?? '';

  final titleController = TextEditingController(text: title);
  final descriptionController = TextEditingController(text: description);

  final editedSearch = await showDialog<Map<String, String>>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edytuj zapisane wyszukiwanie'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Tytuł'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Opis'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => ref.read(navigationService).beamPop(),
            child:  Text('Anuluj'.tr),
          ),
          TextButton(
            onPressed: () {
              ref.read(navigationService).beamPop({
                'title': titleController.text,
                'description': descriptionController.text,
              });
            },
            child:  Text('Zapisz'.tr),
          ),
        ],
      );
    },
  );

  if (editedSearch != null) {
    print("Edited search: $editedSearch");
    await ref.read(editSavedSearchProvider).editClient(actionId, editedSearch);
  }
}
