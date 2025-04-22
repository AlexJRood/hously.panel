import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/board/status_pop.dart';
import 'package:hously_flutter/modules/leads/utils/lead_model.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/theme/icons2.dart';
import 'custom_vertical_divider.dart';
import 'lead_pie_menu.dart';
import 'card.dart';
import 'package:pie_menu/pie_menu.dart';

class DraggableColumn extends StatelessWidget {
  final String status;
  final List<Lead> transactions;
  final void Function(String) onAcceptColumn;
  final void Function(Lead transaction, int newIndex) onReorder;
  final void Function(
      Lead transaction, String newStatus, int? newIndex) onMove;
  final WidgetRef ref;
  final void Function(Lead transaction)
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
    double quarterScreenHeight = screenHeight -130;    
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    

    return DragTarget<String>(
      onAccept: onAcceptColumn,
      builder: (context, candidateData, rejectedData) {
        
        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (candidateData.isNotEmpty)
            
              Container(
                color: AppColors.light50,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Material(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: AppColors.light25,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.light25,
                        offset: Offset(0, 4),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: LeadCardBoard(
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
                    ),
              ),

            LongPressDraggable<String>(
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
                        color: AppColors.light25,
                        offset: Offset(0, 4),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                         Text(
                            status,
                            style: AppTextStyles.interMedium14
                                .copyWith(color: Colors.white),
                          ),
                          ElevatedButton(
                            style: elevatedButtonStyleRounded10,
                            onPressed: (){
                              
                          },
                             child: AppIcons.moreVertical(),
                          )
                         ]
                        ),
                      ),
                      ...transactions.map((transaction) {
                        
                        return SizedBox(
                          width: 300,
                          // height: 50,
                          child: LeadCardBoard(
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
              child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DragTarget<Lead>(
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                         Text(
                            status,
                            style: AppTextStyles.interMedium14
                                .copyWith(color: Colors.white),
                          ),
                          ElevatedButton(
                            style: elevatedButtonStyleRounded10,
                            onPressed: (){
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (_, __, ___) => StatusPop(),
                            transitionsBuilder: (_, anim, __, child) {
                              return FadeTransition(
                                  opacity: anim, child: child);
                            },
                          ),
                        );
                             
                          },
                             child: AppIcons.moreVertical(),
                          )
                         ]
                        ),
                            ),
                            SizedBox(
                              height: quarterScreenHeight, // Dopasuj wysokość
                              child: SingleChildScrollView(
                                child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      transactions.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final transaction = entry.value;
                                    
                                                    final card = SizedBox(
                                                      width: 300,
                                                      child: LeadCardBoard(
                                                        transaction: transaction,
                                                        key: ValueKey(transaction.id),
                                                      ),
                                                    );
            
                                    return PieMenu(
                                      key: ValueKey(transaction.id),
                                      onPressedWithDevice: (kind) {
                                        if (kind == PointerDeviceKind.mouse ||
                                            kind == PointerDeviceKind.touch) {
                                              ref.read(navigationService).pushNamedReplacementScreen('${Routes.leadsBoard}/${transaction.id}');
                                        }
                                      },
                                      actions: pieMenuLead(ref, transaction,
                                          transaction.id, context),
                                      child: DragTarget<Lead>(
                                        onWillAcceptWithDetails: (incoming) => true,
                                        onAccept: (incomingTransaction) {
                                          // Przenosimy transakcję na nową pozycję
                                          onMove(
                                              incomingTransaction, status, index);
                                        },
                                        builder:
                                            (context, candidateData, rejectedData) {
                                          return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if (candidateData.isNotEmpty)
                                                // Separator przyciągania
                                                Container(
                                                  color: AppColors.light50,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(15.0),
                                                        child: card
                                                      ),
                                                ),
            
                                                    isMobile
                                                        ? LongPressDraggable<Lead>(
                                                            data: transaction,
                                                            feedback: Material(
                                                              color: Colors.transparent,
                                                              child: Opacity(opacity: 0.7, child: card),
                                                            ),
                                                            childWhenDragging: Opacity(opacity: 0.5, child: card),
                                                            child: card,
                                                          )
                                                        : Draggable<Lead>(
                                                            data: transaction,
                                                            feedback: Material(
                                                              color: Colors.transparent,
                                                              child: Opacity(opacity: 0.7, child: card),
                                                            ),
                                                            childWhenDragging: Opacity(opacity: 0.5, child: card),
                                                            child: card,
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
                            DragTarget<Lead>(
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
            ),
          ],
        );
      },
    );
  }
}
