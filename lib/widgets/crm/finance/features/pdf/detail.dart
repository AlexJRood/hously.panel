import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/models/bill_model.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

class DetailPage extends ConsumerWidget {
  final BillModel singleBillItem;
  const DetailPage({
    super.key,
    required this.singleBillItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(navigationService).pushNamedScreen(
          Routes.pdfPreview,
          data: {'singleBillItem': singleBillItem},
        ),
        child: const Icon(Icons.picture_as_pdf),
      ),
      appBar: AppBar(title: Text(singleBillItem.name, maxLines: 2)),
      body: ListView(
        children: [
          Card(
            color: Colors.white,
            margin: const EdgeInsets.all(12.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Customer',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    singleBillItem.client,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  children: [
                    Text(
                      'Bill Details',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ...singleBillItem.items.map(
                      (e) => ListTile(
                        title: Text(e.description),
                        trailing: Text(
                          e.cost.toStringAsFixed(2),
                        ),
                      ),
                    ),
                    DefaultTextStyle.merge(
                      style: Theme.of(context).textTheme.headlineMedium,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Total"),
                          Text(
                            "\$${singleBillItem.totalCost().toStringAsFixed(2)}",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
