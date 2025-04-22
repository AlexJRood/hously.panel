
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/modules/board/board_state.dart';
import 'package:hously_flutter/modules/board/columns.dart';
import 'package:hously_flutter/modules/leads/utils/lead_api.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/utils/custom_error_handler.dart';
import 'package:hously_flutter/utils/platforms/html_utils_stub.dart'
    if (dart.library.html) 'package:hously_flutter/utils/platforms/html_utils_web.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';


class LeadBoard extends ConsumerStatefulWidget {
  final WidgetRef ref;

  const LeadBoard({super.key, required this.ref});

  @override
  _LeadBoardState createState() => _LeadBoardState();
}

class _LeadBoardState extends ConsumerState<LeadBoard> {


  void _openTransaction(Lead transaction) {
    int? clientId = transaction.id;

    if (clientId != null) {
      // Pobierz obiekt klienta na podstawie clientId
      fetchById(clientId).then((client) {
        ref.read(navigationService).pushNamedScreen(Routes.clientsViewFull);

        // Aktualizacja URL
      updateUrl('/pro/clients/$clientId/Transakcje/${transaction.id}');
      
      }).catchError((error) {
        final snackBar = Customsnackbar().showSnackBar(
            "Error", 'Błąd podczas pobierania klienta: $error'.tr, "error", () {
          fetchById(clientId);
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    } else {
      // Obsłuż sytuację, gdy clientId jest null
      final snackBar = Customsnackbar().showSnackBar(
          "Warning",
          'Nie można otworzyć transakcji: brak powiązanego klienta.'.tr,
          "warning", () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  
  Future<Lead> fetchById(int clientId) async {
    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.singleLead('$clientId'),
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        return Lead.fromJson(response.data);
      } else {
        throw Exception('Failed to load client');
      }
    } catch (e) {
      throw Exception('Failed to load client: $e');
    }
  }

  void onReorder(Lead transaction, int newIndex) {
    setState(() {
      final currentState = ref.read(leadProvider);
      currentState.whenData((data) {
        final status = data.statuses.firstWhereOrNull(
            (status) => status.leadIndex.contains(transaction.id));

        if (status == null) {
            print("Nie znaleziono statusu dla transakcji ID: ${transaction.id}");
            return;
        }


        final oldIndex = status.leadIndex.indexOf(transaction.id);

        // Usuwamy element ze starej pozycji
        final removedTransactionId = status.leadIndex.removeAt(oldIndex);

        // Wstawiamy element na nową pozycję
        if (newIndex > oldIndex) {
          newIndex -=
              1; // Kompensujemy przesunięcie, gdy usuwamy element z listy
        }
        status.leadIndex.insert(newIndex, removedTransactionId);

        // Aktualizujemy stan w providerze
        ref
            .read(leadProvider.notifier)
            .reorderTransaction(oldIndex, newIndex, status.statusName);
      });

      // Logowanie po zaktualizowaniu stanu
      print('Updated state in onReorder: ${ref.read(leadProvider).whenData((data) => data.statuses.firstWhere((status) => status.leadIndex.contains(transaction.id)).leadIndex)}');
    });
  }

  void onMove(Lead transaction, String newStatus, int? newIndex) {
    ref
        .read(leadProvider.notifier)
        .moveTransaction(transaction, newStatus, newIndex);
  }

  void onAcceptColumn(String movedStatus, String targetStatus) {
    setState(() {
      final currentState = ref.read(leadProvider);
      currentState.whenData((data) {
        final oldIndex =
            data.statuses.indexWhere((s) => s.statusName == movedStatus);
        final newIndex =
            data.statuses.indexWhere((s) => s.statusName == targetStatus);

        if (oldIndex != -1 && newIndex != -1) {
          final movedItem = data.statuses.removeAt(oldIndex);
          data.statuses.insert(newIndex, movedItem);

          // Aktualizuj stan w providerze
          ref.read(leadProvider.notifier).reorderStatuses(data.statuses);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionStateAsync = ref.watch(leadProvider);

    return transactionStateAsync.when(
      data: (data) {
        final transactionsMap = {for (var tx in data.transactions) tx.id: tx};

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.statuses.map((status) {
              final filteredTransactions = status.leadIndex
                  .map((id) => transactionsMap[id])
                  .where((tx) => tx != null)
                  .cast<Lead>()
                  .toList();

              return DraggableColumn(
                key: ValueKey(status.statusName),
                status: status.statusName,
                transactions: filteredTransactions,
                onAcceptColumn: (movedStatus) =>
                    onAcceptColumn(movedStatus, status.statusName),
                onReorder: (transaction, newIndex) =>
                    onReorder(transaction, newIndex), // Poprawka argumentów
                onMove: (transaction, newStatus, newIndex) =>
                    onMove(transaction, newStatus, newIndex),
                ref: widget.ref,
                onTransactionSelected: _openTransaction, // Dodajemy ten parametr
              );
            }).toList(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _){
        print(error);
        return Center(
            child: Text('Failed to load transactions and statuses: $error'));
      },
    );
  }

}

class EditStatusDialog extends ConsumerStatefulWidget {
  final LeadStatus? status;
  final Function(LeadStatus) onSave;

  const EditStatusDialog({Key? key, this.status, required this.onSave})
      : super(key: key);

  @override
  _EditStatusDialogState createState() => _EditStatusDialogState();
}

class _EditStatusDialogState extends ConsumerState<EditStatusDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _statusName;
  late int _statusIndex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
          Text(widget.status != null ? 'Edytuj Status'.tr : 'Nowy Status'.tr),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _statusName,
              decoration: InputDecoration(labelText: 'Nazwa Statusu'.tr),
              validator: (value) => value == null || value.isEmpty
                  ? 'Wprowadź nazwę statusu'.tr
                  : null,
              onSaved: (value) => _statusName = value!,
            ),
            TextFormField(
              initialValue: _statusIndex.toString(),
              decoration: InputDecoration(labelText: 'Indeks Statusu'.tr),
              keyboardType: TextInputType.number,
              validator: (value) => value == null || int.tryParse(value) == null
                  ? 'Wprowadź poprawny indeks'.tr
                  : null,
              onSaved: (value) => _statusIndex = int.parse(value!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Anuluj'.tr),
          onPressed: () => ref.read(navigationService).beamPop(),
        ),
        ElevatedButton(
          child: Text('Zapisz'.tr),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newStatus = LeadStatus(
                id: widget.status?.id ?? 0,
                statusName: _statusName,
                statusIndex: _statusIndex,
                leadIndex: widget.status?.leadIndex ?? [],
              );
              widget.onSave(newStatus);
              ref.read(navigationService).beamPop();
            }
          },
        ),
      ],
    );
  }
}
