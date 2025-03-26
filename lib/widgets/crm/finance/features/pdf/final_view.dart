import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/models/bill_model.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

class FinalView extends ConsumerWidget {
  FinalView({super.key});

  final bills = <BillModel>[
    // BillModel(transactionid: transactionid, client: client, amount: amount, date: date, paymentMethod: paymentMethod, note: note, status: status, transactionName: transactionName, invoiceNumber: invoiceNumber, address: address, name: name, items: items, invoiceData: invoiceData)
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bills'), centerTitle: true),
      body: ListView(
        children: [
          ...bills.map(
            (billModel) => ListTile(
              title: Text(billModel.name),
              subtitle: Text(billModel.client),
              trailing: Text('\$${billModel.totalCost().toStringAsFixed(2)}'),
              onTap: () => ref.read(navigationService).pushNamedScreen(
                Routes.detail,
                data: {'singleBillItem': billModel},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
