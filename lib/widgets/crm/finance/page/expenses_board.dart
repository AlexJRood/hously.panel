import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/models/transaction/transaction_expenses_model.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/transaction_expenses.dart';
import 'package:hously_flutter/widgets/crm/finance/page/columns_expenses.dart';

class CrmExpensesBoard extends ConsumerStatefulWidget {
  final WidgetRef ref;

  const CrmExpensesBoard({super.key, required this.ref});

  @override
  _CrmExpensesBoardState createState() => _CrmExpensesBoardState();
}

class _CrmExpensesBoardState extends ConsumerState<CrmExpensesBoard> {
  void onReorder(TransactionExpensesModel transaction, int newIndex) {
    setState(() {
      final currentState = ref.read(expensesTransactionProvider);
      currentState.whenData((data) {
        final status = data.statuses.firstWhere(
            (status) => status.transactionIndex.contains(transaction.id));
        final oldIndex = status.transactionIndex.indexOf(transaction.id);

        // Usuwamy element ze starej pozycji
        final removedTransactionId = status.transactionIndex.removeAt(oldIndex);

        // Wstawiamy element na nową pozycję
        if (newIndex > oldIndex) {
          newIndex -=
              1; // Kompensujemy przesunięcie, gdy usuwamy element z listy
        }
        status.transactionIndex.insert(newIndex, removedTransactionId);

        // Aktualizujemy stan w providerze
        ref
            .read(expensesTransactionProvider.notifier)
            .reorderTransaction(oldIndex, newIndex, status.statusName);
      });

      // Logowanie po zaktualizowaniu stanu
      print(
          'Updated state in onReorder: ${ref.read(expensesTransactionProvider).whenData((data) => data.statuses.firstWhere((status) => status.transactionIndex.contains(transaction.id)).transactionIndex)}');
    });
  }

  void onMove(
      TransactionExpensesModel transaction, String newStatus, int? newIndex) {
    ref
        .read(expensesTransactionProvider.notifier)
        .moveTransaction(transaction, newStatus, newIndex);
  }

  void onAcceptColumn(String movedStatus, String targetStatus) {
    setState(() {
      final currentState = ref.read(expensesTransactionProvider);
      currentState.whenData((data) {
        final oldIndex =
            data.statuses.indexWhere((s) => s.statusName == movedStatus);
        final newIndex =
            data.statuses.indexWhere((s) => s.statusName == targetStatus);

        if (oldIndex != -1 && newIndex != -1) {
          final movedItem = data.statuses.removeAt(oldIndex);
          data.statuses.insert(newIndex, movedItem);

          // Aktualizuj stan w providerze
          ref
              .read(expensesTransactionProvider.notifier)
              .reorderStatuses(data.statuses);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionStateAsync = widget.ref.watch(expensesTransactionProvider);

    return transactionStateAsync.when(
      data: (data) {
        final transactionsMap = {for (var tx in data.transactions) tx.id: tx};

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.statuses.map((status) {
              final filteredTransactions = status.transactionIndex
                  .map((id) => transactionsMap[id])
                  .where((tx) => tx != null)
                  .cast<TransactionExpensesModel>()
                  .toList();

              return DraggableColumn(
                key: ValueKey(status.statusName),
                status: status.statusName,
                transactions: filteredTransactions,
                onAcceptColumn: (movedStatus) =>
                    onAcceptColumn(movedStatus, status.statusName),
                onReorder: (oldIndex, newIndex) => onReorder(
                  oldIndex,
                  newIndex,
                ),
                onMove: (transaction, newStatus, newIndex) =>
                    onMove(transaction, newStatus, newIndex),
                ref: widget.ref,
              );
            }).toList(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
          child: Text('Failed to load transactions and statuses: $error')),
    );
  }
}
