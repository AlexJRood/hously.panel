import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
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
    required this.onTransactionSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double quarterScreenHeight = screenHeight / 4 * 3;

    return DragTarget<String>(
      onAccept: onAcceptColumn,
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 300,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: candidateData.isNotEmpty ? AppColors.light50 : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Draggable<String>(
                data: status,
                feedback: Material(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 300,
                    height: 50,
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
                        style: AppTextStyles.interMedium14.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(
                  width: 300,
                  height: 50,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.light15,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: Container(
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
                      style: AppTextStyles.interMedium14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              /// ✅ DragTarget for when column is empty
              if (transactions.isEmpty)
                DragTarget<AgentTransactionModel>(
                  onWillAccept: (_) => true,
                  onAccept: (incomingTransaction) {
                    onMove(incomingTransaction, status, 0); // Place at index 0
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      height: 60,
                      width: 300,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: candidateData.isNotEmpty ? Colors.grey.shade300 : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.light50, width: 2),
                      ),
                      child: Text(
                        candidateData.isNotEmpty ? "Drop Here" : "No Transactions",
                        style: AppTextStyles.interMedium14.copyWith(color: AppColors.light50),
                      ),
                    );
                  },
                ),

              /// ✅ Transactions List
              if (transactions.isNotEmpty)
                SizedBox(
                  height: quarterScreenHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: transactions.asMap().entries.map((entry) {
                        final index = entry.key;
                        final transaction = entry.value;
                        return PieMenu(
                          key: ValueKey('${transaction.id}_$index'),
                          onPressedWithDevice: (kind) {
                            if (kind == PointerDeviceKind.mouse ||
                                kind == PointerDeviceKind.touch) {
                              onTransactionSelected(transaction);
                            }
                          },
                          actions: pieMenuCrmRevenues(ref, transaction, transaction.id, context),
                          child: DragTarget<AgentTransactionModel>(
                            onWillAccept: (incoming) => true,
                            onAccept: (incomingTransaction) {
                              onMove(incomingTransaction, status, index);
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Column(
                                children: [
                                  if (candidateData.isNotEmpty)
                                    Container(
                                      height: 10,
                                      color: Colors.transparent,
                                    ),
                                  Draggable<AgentTransactionModel>(
                                    data: transaction,
                                    feedback: Material(
                                      child: Opacity(
                                        opacity: 0.7,
                                        child: SizedBox(
                                          width: 300,
                                          child: TransactionCardRevenue(
                                            transaction: transaction,
                                            key: ValueKey('${transaction.id}_feedback_$index'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    childWhenDragging: Opacity(
                                      opacity: 0.5,
                                      child: SizedBox(
                                        width: 300,
                                        child: TransactionCardRevenue(
                                          transaction: transaction,
                                          key: ValueKey('${transaction.id}_dragging_$index'),
                                        ),
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: 300,
                                      child: TransactionCardRevenue(
                                        transaction: transaction,
                                        key: ValueKey('${transaction.id}_child_$index'),
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

              /// ✅ DragTarget for placing at the end of the column
              DragTarget<AgentTransactionModel>(
                onWillAccept: (_) => true,
                onAccept: (incomingTransaction) {
                  onMove(incomingTransaction, status, transactions.length);
                },
                builder: (context, candidateData, rejectedData) {
                  return candidateData.isNotEmpty
                      ? Container(
                    height: 10,
                    color: AppColors.light50,
                  )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
