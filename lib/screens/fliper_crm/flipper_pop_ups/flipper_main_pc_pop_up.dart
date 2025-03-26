import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/calculation_pop_up/calculation_pop_up_screen.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/refurbish_pop_up/refurbish_pop_up_screen.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/sale_pop_up/sale_pop_up_screen.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/transaction_pop_up_pc_screen.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/transaction_sidebar.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/nigotiation_header_widget.dart';

class FlipperMainPcPopUp extends ConsumerWidget {
  const FlipperMainPcPopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    final List<Widget> screens = [
      const TransactionPopUpPcScreen(),
      const CalculationPopUpScreen(),
      const RefurbishPopUpScreen(),
      const SalePopUpScreen(),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            const NegotiationHeaderWidget(),
            Expanded(
              child: Row(
                spacing: 20,
                children: [
                  const TransactionSidebar(),
                  Expanded(child: screens[selectedIndex]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
