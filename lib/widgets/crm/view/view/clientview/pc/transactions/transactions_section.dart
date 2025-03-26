import 'dart:convert';
import 'dart:ui';
import 'package:hously_flutter/platforms/html_utils_stub.dart'
if (dart.library.html) 'package:hously_flutter/platforms/html_utils_web.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/pie_menu/revenue_crm.dart';
import 'package:hously_flutter/widgets/crm/finance/page/transaction_card.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/transactions/transaction_view.dart';
import 'package:pie_menu/pie_menu.dart';


import 'package:hously_flutter/models/crm/agent_transaction_model.dart';


class TransactionSectionPc extends ConsumerStatefulWidget {
  final int id;
  final String activeSection;
  final String?
      selectedTransactionId; // Dodatkowa opcja, aby przekazać wybraną transakcję
  final String? activeAd;

  const TransactionSectionPc({
    super.key,
    required this.id,
    required this.activeSection,
    this.selectedTransactionId, // Opcjonalnie dla przypadków null
    this.activeAd,
  });

  @override
  TransactionSectionPcState createState() => TransactionSectionPcState();
}

class TransactionSectionPcState extends ConsumerState<TransactionSectionPc> {
  List<dynamic> transactions = [];
  AgentTransactionModel? selectedTransaction;

  @override
  void initState() {
    super.initState();
    fetchTransactions(ref);
  }

  @override
  void didUpdateWidget(covariant TransactionSectionPc oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedTransactionId != widget.selectedTransactionId) {
      _selectTransactionById(transactionId: widget.selectedTransactionId);
    }
  }

  void _selectTransactionById({String? transactionId, String? activeAd}) {
    setState(() {
      if (transactionId != null) {
        selectedTransaction = transactions.firstWhere(
          (transaction) => transaction.id.toString() == transactionId,
        );
      } else if (activeAd != null && activeAd.isNotEmpty) {
        selectedTransaction = transactions.firstWhere(
          (transaction) => transaction.id.toString() == activeAd,
        );
      }
    });
  }

  void _changeTransaction(AgentTransactionModel transaction) {
    setState(() {
      selectedTransaction = transaction;
    });

    // Aktualizacja URL dla transakcji
updateUrl('/pro/clients/${widget.id}/Transakcje/${transaction.id}');
  }

  void setTransaction(AgentTransactionModel transaction) {
    setState(() {
      selectedTransaction = transaction;
    });

    // Aktualizacja URL dla transakcji
   updateUrl('/pro/clients/${widget.id}/Transakcje/${transaction.id}');
  }

  Future<void> fetchTransactions(WidgetRef ref) async {
    try {
      final response = await ApiServices.get(
        ref:ref,
        URLs.agentTransactionByUserContact('${widget.id}'),
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        setState(() {   
        final decodedBody = utf8.decode(response.data);
        final listingsJson = json.decode(decodedBody) as List<dynamic>;
          transactions = listingsJson.map((revenue) => AgentTransactionModel.fromJson(revenue)).toList();

          // Wybierz przekazaną transakcję, jeśli podano
          _selectTransactionById(
            transactionId: widget.selectedTransactionId,
            activeAd: widget.activeAd,
          );

          // Jeśli żadna transakcja nie jest wybrana, wybierz pierwszą
          if (selectedTransaction == null && transactions.isNotEmpty) {
            selectedTransaction = transactions.first;
            // Aktualizacja URL dla automatycznie wybranej transakcji
            updateUrl('/pro/clients/${widget.id}/Transakcje/${selectedTransaction!.id}');
          }
        });
      } else {
        final errorSnackBar = Customsnackbar().showSnackBar(
          "Error",
          'Błąd podczas pobierania transakcji.'.tr,
          "error",
          () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    } catch (e) {
      final errorSnackBar = Customsnackbar().showSnackBar(
        "Error",
        'Błąd podczas pobierania transakcji: $e'.tr,
        "error",
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...transactions.map(
                (transaction) => PieMenu(
                  onPressedWithDevice: (kind) {
                    if (kind == PointerDeviceKind.mouse ||
                        kind == PointerDeviceKind.touch) {
                      _changeTransaction(transaction);
                    }
                  },
                  actions: pieMenuCrmRevenues(
                    ref,
                    transaction,
                    transaction.id,
                    context,
                  ),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 7.0),
                          child: TransactionCardRevenue(
                            transaction: transaction,
                            activeSection: widget.activeSection,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Expanded(
            child: selectedTransaction != null
                ? TransactionView(
                    transaction: selectedTransaction!,
                    clientId: widget.id,
                  )
                : Text('Nie wybrano transakcji'.tr),
          ),
        ],
      ),
    );
  }
}
