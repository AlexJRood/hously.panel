// edit_status_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/expenses_status_model.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/transaction_expenses.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

class ExpensesStatusDialog extends ConsumerWidget {
  const ExpensesStatusDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusState = ref.watch(expensesTransactionProvider);

    return Expanded(
      child: statusState.when(
        data: (transactionState) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) {
                    _onReorder(ref, transactionState, oldIndex, newIndex);
                  },
                  itemCount: transactionState.statuses.length,
                  itemBuilder: (context, index) {
                    final status = transactionState.statuses[index];
                    return ListTile(
                      key: ValueKey(
                          status.id), // Unikalny klucz dla każdego elementu
                      title: Text(status.statusName,
                          style: AppTextStyles.interMedium14),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon:
                                const Icon(Icons.edit, color: AppColors.light),
                            onPressed: () =>
                                _showEditDialog(context, ref, status),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: AppColors.light),
                            onPressed: () => _deleteStatus(ref, status.id),
                          ),
                          const SizedBox(width: 10),
                          // ReorderableDragStartListener(
                          //   index: index,
                          //   child: const Icon(
                          //     Icons.drag_indicator,
                          //     color: AppColors.light
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showCreateDialog(context, ref);
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _onReorder(WidgetRef ref, ExpensesState transactionState, int oldIndex,
      int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1; // Kompensujemy przesunięcie przy usuwaniu
    }
    final movedStatus = transactionState.statuses.removeAt(oldIndex);
    transactionState.statuses.insert(newIndex, movedStatus);

    // Tworzymy nowe instancje statusów z zaktualizowanymi indeksami
    final updatedStatuses =
        transactionState.statuses.asMap().entries.map((entry) {
      final index = entry.key;
      final status = entry.value;
      return ExpensesStatusModel(
        id: status.id,
        statusName: status.statusName,
        statusIndex: index, // Zaktualizowany indeks
        transactionIndex: status.transactionIndex,
      );
    }).toList();

    // Wywołaj metodę z providera, która aktualizuje stan
    ref
        .read(expensesTransactionProvider.notifier)
        .reorderStatuses(updatedStatuses);
  }

  void _showEditDialog(
      BuildContext context, WidgetRef ref, ExpensesStatusModel status) {
    showDialog(
      context: context,
      builder: (context) => EditExpensesStatusDialog(
        status: status,
        onSave: (updatedStatus) {
          ref
              .read(expensesTransactionProvider.notifier)
              .updateTransactionStatus(updatedStatus,ref);
        },
      ),
    );
  }

  void _showCreateDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => EditExpensesStatusDialog(
        onSave: (newStatus) {
          ref
              .read(expensesTransactionProvider.notifier)
              .createTransactionStatus(newStatus,ref);
        },
      ),
    );
  }

  void _deleteStatus(WidgetRef ref, int id) {
    ref.read(expensesTransactionProvider.notifier).deleteTransactionStatus(id,ref);
  }
}

class EditExpensesStatusDialog extends ConsumerStatefulWidget {
  final ExpensesStatusModel? status;
  final Function(ExpensesStatusModel) onSave;

  const EditExpensesStatusDialog(
      {super.key, this.status, required this.onSave});

  @override
  _EditExpensesStatusDialogState createState() =>
      _EditExpensesStatusDialogState();
}

class _EditExpensesStatusDialogState
    extends ConsumerState<EditExpensesStatusDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _statusName;
  late int _statusIndex;

  @override
  void initState() {
    super.initState();
    _statusName = widget.status?.statusName ?? '';
    _statusIndex = widget.status?.statusIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.status != null ? 'Edytuj Status'.tr : 'Nowy Status'.tr),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _statusName,
              decoration:  InputDecoration(labelText: 'Nazwa Statusu'.tr),
              validator: (value) => value == null || value.isEmpty
                  ? 'Wprowadź nazwę statusu'.tr
                  : null,
              onSaved: (value) => _statusName = value!,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child:  Text('Anuluj'.tr),
          onPressed: () => ref.read(navigationService).beamPop(),
        ),
        ElevatedButton(
          child:  Text('Zapisz'.tr),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newStatus = ExpensesStatusModel(
                id: widget.status?.id ?? 0,
                statusName: _statusName,
                statusIndex: _statusIndex,
                transactionIndex: widget.status?.transactionIndex ?? [],
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
