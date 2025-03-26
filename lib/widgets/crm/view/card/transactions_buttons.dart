import 'dart:ui';
import 'package:hously_flutter/platforms/html_utils_stub.dart'
if (dart.library.html) 'package:hously_flutter/platforms/html_utils_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/pie_menu/revenue_crm.dart';
import 'package:hously_flutter/widgets/crm/finance/page/transaction_card.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/transactions/transactions_section.dart';
import 'package:pie_menu/pie_menu.dart';

class TransactionButtons extends ConsumerStatefulWidget {
  final int id;
  final String activeSection;

  const TransactionButtons({
    super.key,
    required this.id,
    required this.activeSection,
  });

  @override
  TransactionButtonsPcState createState() => TransactionButtonsPcState();
}

class TransactionButtonsPcState extends ConsumerState<TransactionButtons> {
  List<dynamic> transactions = [];
  AgentTransactionModel?
      selectedTransaction; // Dodaj zmienną do przechowywania wybranej transakcji

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> setTransaction(AgentTransactionModel transaction) async {
    // Call the parent function (if using a callback) to open the section and pass the transaction
    TransactionSectionPcState? parentState =
        context.findAncestorStateOfType<TransactionSectionPcState>();
    if (parentState != null) {
      parentState.setTransaction(transaction);
    }

    // Optionally, update the URL as you're currently doing
updateUrl('/pro/clients/${widget.id}/Transakcje/${transaction.id.toString()}');
  }

  Future<void> fetchTransactions() async {
    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.agentTransactionByUserContact('${widget.id}'),
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        setState(() {
          transactions = (response.data as List)
              .map((revenue) => AgentTransactionModel.fromJson(revenue)).toList();
        });
      } else {
        final errorSnackBar = Customsnackbar().showSnackBar(
          "Error",
          'Błąd podczas pobierania komentarzy.'.tr,
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
        'Błąd podczas pobierania komentarzy: $e'.tr,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...transactions.map(
          (transaction) => PieMenu(
            onPressedWithDevice: (kind) async {
              if (kind == PointerDeviceKind.mouse ||
                  kind == PointerDeviceKind.touch) {
                // _changeTransaction(transaction);
                // await setTransaction(transaction);
                Navigator.pushNamed(
                  context,
                  '/pro/clients/${widget.id}/Transakcje/${transaction.id}',
                );
              }
            },
            actions:
                pieMenuCrmRevenues(ref, transaction, transaction.id, context),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TransactionCardRevenue(
                    transaction: transaction,
                    activeSection: widget.activeSection),
              ),
            ),
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }
}
