import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

class CrmFinanceSideButtons extends StatelessWidget {
  final WidgetRef ref;

  const CrmFinanceSideButtons({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(navigationService).pushNamedScreen(
                      Routes.viewPopChanger,
                    );
              },
              child:  Text('Zmień widok'.tr),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.read(navigationService).pushNamedScreen(Routes.proPlans);
              },
              child:  Text('Plany finansowe'.tr),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.read(navigationService).pushNamedScreen(
                      Routes.statusPopRevenue,
                    );
              },
              // onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => StatusPopRevenue( //onSave: (newStatus) {
              //   //   ref.read(transactionProvider.notifier).createTransactionStatus(newStatus);
              //   // },
              //   ),
              //   ),
              // );
              // },
              child:  Text('Edytuj statusy'.tr),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.read(navigationService).pushNamedScreen(
                      Routes.statusPopExpenses,
                    );
              },
              // onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => StatusPopRevenue( //onSave: (newStatus) {
              //   //   ref.read(transactionProvider.notifier).createTransactionStatus(newStatus);
              //   // },
              //   ),
              //   ),
              // );
              // },
              child: const Text('statusy wydatków'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pro/finance/revenue/add');
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pro/finance/revenue/add');
              },
              child: const Text('Sorted by'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pro/finance/costs/add');
              },
              child:  Text('Dodaj Koszt'.tr),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pro/finance/revenue/add');
              },
              child:  Text('Dodaj przychód'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
