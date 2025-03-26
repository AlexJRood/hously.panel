import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

void showSortPopup(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    barrierDismissible:
        true, // Ustawienie, czy można zamknąć dialog poprzez kliknięcie w tło
    builder: (BuildContext context) {
      String? selectedSort;

      final sortOptions = {
        'Amount Ascending': 'amount_asc',
        'Amount Descending': 'amount_desc',
        'Date Created Ascending': 'date_create_asc',
        'Date Created Descending': 'date_create_desc',
        'Date Updated Ascending': 'date_update_asc',
        'Date Updated Descending': 'date_update_desc',
      };

      return AlertDialog(
        title: const Text('Sort Clients'),
        content: DropdownButtonFormField<String>(
          value: selectedSort,
          decoration: const InputDecoration(labelText: 'Sort by'),
          items: sortOptions.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.value,
              child: Text(entry.key),
            );
          }).toList(),
          onChanged: (newValue) {
            selectedSort = newValue;
          },
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              ref.read(navigationService).beamPop();
            },
          ),
          ElevatedButton(
            child: const Text('Apply'),
            onPressed: () {
              ref
                  .read(clientProvider.notifier)
                  .fetchClients(sort: selectedSort);
              ref.read(navigationService).beamPop();
            },
          ),
        ],
      );
    },
  );
}
