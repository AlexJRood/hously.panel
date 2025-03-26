import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/custom_vertical_divider.dart';
import 'package:hously_flutter/utils/pie_menu/revenue_crm.dart';
import 'package:hously_flutter/widgets/crm/finance/page/transaction_card.dart';
import 'package:pie_menu/pie_menu.dart';

class DraggableColumn extends StatelessWidget {
  final String status;
  final List<AgentTransactionModel> transactions;
  final void Function(String) onAcceptColumn;
  final void Function(AgentTransactionModel transaction, int newIndex) onReorder;
  final void Function(
      AgentTransactionModel transaction, String newStatus, int? newIndex) onMove;
  final WidgetRef ref;
  final void Function(AgentTransactionModel transaction)
      onTransactionSelected; // Dodajemy ten parametr

  const DraggableColumn({
    super.key,
    required this.status,
    required this.transactions,
    required this.onAcceptColumn,
    required this.onReorder,
    required this.onMove,
    required this.ref,
    required this.onTransactionSelected, // Dodajemy ten parametr
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double quarterScreenHeight = screenHeight / 4 * 3;

    return DragTarget<String>(
      onAccept: onAcceptColumn,
      builder: (context, candidateData, rejectedData) {
        return Draggable<String>(
          data: status,
          feedback: Material(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: AppColors.light25,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.dark50,
                    offset: Offset(0, 4),
                    blurRadius: 25,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      gradient: candidateData.isNotEmpty
                          ? CrmGradients.loginGradient
                          : CrmGradients.adGradient,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        status,
                        style: AppTextStyles.interMedium14
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  ...transactions.map((transaction) {
                    return SizedBox(
                      width: 300,
                      // height: 50,
                      child: TransactionCardRevenue(
                        transaction: transaction,
                        key: ValueKey(
                            transaction.id), // Unique key for each transaction
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          childWhenDragging: Container(
            width: 300,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.light15,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            children: [
              DragTarget<AgentTransactionModel>(
                onWillAccept: (transaction) => true,
                onAccept: (transaction) => onMove(transaction, status,
                    null), // Null oznacza, że element trafi na koniec listy
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: 300,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: candidateData.isNotEmpty
                          ? AppColors.light50
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            status,
                            style: AppTextStyles.interMedium14,
                          ),
                        ),
                        SizedBox(
                          height: quarterScreenHeight, // Dopasuj wysokość
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  transactions.asMap().entries.map((entry) {
                                final index = entry.key;
                                final transaction = entry.value;
                                return PieMenu(
                                  key: ValueKey(transaction.id),
                                  onPressedWithDevice: (kind) {
                                    if (kind == PointerDeviceKind.mouse ||
                                        kind == PointerDeviceKind.touch) {
                                      onTransactionSelected(
                                          transaction); // Wywołujemy callback
                                    }
                                  },
                                  actions: pieMenuCrmRevenues(ref, transaction,
                                      transaction.id, context),
                                  child: DragTarget<AgentTransactionModel>(
                                    onWillAcceptWithDetails: (incoming) => true,
                                    onAccept: (incomingTransaction) {
                                      // Przenosimy transakcję na nową pozycję
                                      onMove(
                                          incomingTransaction, status, index);
                                    },
                                    builder:
                                        (context, candidateData, rejectedData) {
                                      return Column(
                                        children: [
                                          if (candidateData.isNotEmpty)
                                            // Separator przyciągania
                                            Container(
                                              height: 10,
                                              color: Colors.grey.shade300,
                                            ),
                                          Draggable<AgentTransactionModel>(
                                            data: transaction,
                                            feedback: Material(
                                              child: Opacity(
                                                opacity: 0.7,
                                                child: SizedBox(
                                                  width: 300,
                                                  // height: 50,
                                                  child: TransactionCardRevenue(
                                                    transaction: transaction,
                                                    key: ValueKey(transaction
                                                        .id), // Unique key for each transaction
                                                  ),
                                                ),
                                              ),
                                            ),
                                            childWhenDragging: Opacity(
                                              opacity: 0.5,
                                              child: SizedBox(
                                                width: 300,
                                                // height: 50,
                                                child: TransactionCardRevenue(
                                                  transaction: transaction,
                                                  key: ValueKey(transaction
                                                      .id), // Unique key for each transaction
                                                ),
                                              ),
                                            ),
                                            child: SizedBox(
                                              width: 300,
                                              child: TransactionCardRevenue(
                                                transaction: transaction,
                                                key: ValueKey(transaction
                                                    .id), // Unique key for each transaction
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        DragTarget<AgentTransactionModel>(
                          onWillAccept: (_) => true,
                          onAccept: (incomingTransaction) {
                            onMove(incomingTransaction, status,
                                transactions.length);
                          },
                          builder: (context, candidateData, rejectedData) {
                            return candidateData.isNotEmpty
                                ? Container(
                                    height: 10,
                                    color: candidateData.isNotEmpty
                                        ? AppColors.light50
                                        : Colors.white,
                                  )
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              const CustomVerticalDivider(),
            ],
          ),
        );
      },
    );
  }
}
