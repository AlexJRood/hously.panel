import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/transaction/transaction_expenses_model.dart';
import 'package:hously_flutter/utils/pie_menu/expenses_crm.dart';
import 'package:hously_flutter/widgets/crm/finance/page/transaction_card.dart';
import 'package:pie_menu/pie_menu.dart';

// class DraggableColumn extends StatelessWidget {
//   final String status;
//   final List<TransactionExpenses> transactions;
//   final void Function(String) onAcceptColumn;
//   final void Function(TransactionExpenses transaction, int newIndex) onReorder;
//   final void Function(TransactionExpenses transaction, String newStatus, int? newIndex) onMove;
//   final WidgetRef ref;

//   const DraggableColumn({
//     super.key,
//     required this.status,
//     required this.transactions,
//     required this.onAcceptColumn,
//     required this.onReorder,
//     required this.onMove,
//     required this.ref,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DragTarget<String>(
//       onAccept: onAcceptColumn,
//       builder: (context, candidateData, rejectedData) {
//         return Draggable<String>(
//           data: status,
//           feedback: Material(
//             borderRadius: BorderRadius.circular(20),
//             child: Container(
//               width: 300,
//               decoration: BoxDecoration(
//                 color: AppColors.light25,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: AppColors.dark50,
//                     offset: Offset(0, 4),
//                     blurRadius: 25,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Container(
//                     height: 50,
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       gradient: CrmGradients.adGradient,
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         status,
//                         style: AppTextStyles.interMedium14.copyWith(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   ...transactions.map((transaction) {
//                     return SizedBox(
//                       width: 300,
//                       child: TransactionCardExpenses(transaction: transaction)
//                     );
//                   }).toList(),
//                 ],
//               ),
//             ),
//           ),
//           childWhenDragging: Container(
//             width: 300,
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppColors.light15,
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           child: DragTarget<TransactionExpenses>(
//             onWillAccept: (transaction) => true,
//             onAccept: (transaction) => onMove(transaction, status, null), // Null oznacza, że element trafi na koniec listy
//             builder: (context, candidateData, rejectedData) {
//               return Container(
//                 width: 300,
//                 padding: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   color: candidateData.isNotEmpty ? Colors.grey.shade200 : AppColors.light25,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 50,
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(8.0),
//                       decoration: BoxDecoration(
//                         gradient: candidateData.isNotEmpty ? CrmGradients.loginGradient : CrmGradients.adGradient,
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           status,
//                           style: AppTextStyles.interMedium14,
//                         ),
//                       ),
//                     ),
//                     ...transactions.asMap().entries.map((entry) {
//                       final index = entry.key;
//                       final transaction = entry.value;
//                       return PieMenu(
//                         onPressedWithDevice: (kind) {
//                           if (kind == PointerDeviceKind.mouse || kind == PointerDeviceKind.touch) {

//                           }
//                         },
//                         actions: pieMenuCrmExpenses(ref, transaction, transaction.id, context),
//                         child:  DragTarget<TransactionExpenses>(
//                           onWillAccept: (incoming) => true,
//                           onAccept: (incomingTransaction) {
//                             // Przenosimy transakcję na nową pozycję
//                             onMove(incomingTransaction, status, index);
//                           },
//                           builder: (context, candidateData, rejectedData) {
//                             return Column(
//                               children: [
//                                 if (candidateData.isNotEmpty)
//                                   // Separator przyciągania
//                                   Container(
//                                     height: 10,
//                                     color: Colors.grey.shade300,
//                                   ),
//                                 Draggable<TransactionExpenses>(
//                                   data: transaction,
//                                   feedback: Material(
//                                     child: Opacity(
//                                       opacity: 0.7,
//                                       child: SizedBox(
//                                         width: 300,
//                                         child: TransactionCardExpenses(transaction: transaction)
//                                       ),
//                                     ),
//                                   ),
//                                   childWhenDragging: Opacity(
//                                     opacity: 0.5,
//                                     child: SizedBox(
//                                       width: 300,
//                                       child: TransactionCardExpenses(transaction: transaction)
//                                     ),
//                                   ),
//                                   child: SizedBox(
//                                     width: 300,
//                                     child: TransactionCardExpenses(transaction: transaction)
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       );
//                     }).toList(),
//                     // Dodajemy DragTarget na końcu listy, aby umożliwić przenoszenie na koniec
//                     DragTarget<TransactionExpenses>(
//                       onWillAccept: (_) => true,
//                       onAccept: (incomingTransaction) {
//                         onMove(incomingTransaction, status, transactions.length);
//                       },
//                       builder: (context, candidateData, rejectedData) {
//                         return candidateData.isNotEmpty
//                             ? Container(
//                                 height: 10,
//                                 color: Colors.grey.shade300,
//                               )
//                             : const SizedBox.shrink();
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

class DraggableColumn extends StatelessWidget {
  final String status;
  final List<TransactionExpensesModel> transactions;
  final void Function(String) onAcceptColumn;
  final void Function(TransactionExpensesModel transaction, int newIndex)
      onReorder;
  final void Function(
          TransactionExpensesModel transaction, String newStatus, int? newIndex)
      onMove;
  final WidgetRef ref;

  const DraggableColumn({
    super.key,
    required this.status,
    required this.transactions,
    required this.onAcceptColumn,
    required this.onReorder,
    required this.onMove,
    required this.ref,
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
                  // Ograniczenie wysokości i umożliwienie przewijania
                  Expanded(
                    // height: double.infinity, // Możesz dostosować wysokość
                    child: SingleChildScrollView(
                      child: Column(
                        children: transactions.map((transaction) {
                          return SizedBox(
                            width: 300,
                            child: TransactionCardExpenses(
                                transaction: transaction),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
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
          child: DragTarget<TransactionExpensesModel>(
            onWillAccept: (transaction) => true,
            onAccept: (transaction) => onMove(transaction, status, null),
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
                    // Kolejne przewijanie dla transakcji
                    SizedBox(
                      height: quarterScreenHeight, // Dopasuj wysokość
                      child: SingleChildScrollView(
                        child: Column(
                          children: transactions.asMap().entries.map((entry) {
                            final index = entry.key;
                            final transaction = entry.value;
                            return PieMenu(
                              onPressedWithDevice: (kind) {
                                if (kind == PointerDeviceKind.mouse ||
                                    kind == PointerDeviceKind.touch) {
                                  // Twój kod
                                }
                              },
                              actions: pieMenuCrmExpenses(
                                  ref, transaction, transaction.id, context),
                              child: DragTarget<TransactionExpensesModel>(
                                onWillAccept: (incoming) => true,
                                onAccept: (incomingTransaction) {
                                  onMove(incomingTransaction, status, index);
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
                                      Draggable<TransactionExpensesModel>(
                                        data: transaction,
                                        feedback: Material(
                                          child: Opacity(
                                            opacity: 0.7,
                                            child: SizedBox(
                                              width: 300,
                                              child: TransactionCardExpenses(
                                                  transaction: transaction),
                                            ),
                                          ),
                                        ),
                                        childWhenDragging: Opacity(
                                          opacity: 0.5,
                                          child: SizedBox(
                                            width: 300,
                                            child: TransactionCardExpenses(
                                                transaction: transaction),
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: 300,
                                          child: TransactionCardExpenses(
                                              transaction: transaction),
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
                    DragTarget<TransactionExpensesModel>(
                      onWillAccept: (_) => true,
                      onAccept: (incomingTransaction) {
                        onMove(
                            incomingTransaction, status, transactions.length);
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
        );
      },
    );
  }
}
