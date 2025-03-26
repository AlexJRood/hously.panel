import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/flipper_custom_tap_bar.dart';

final financeTabIndexProvider = StateProvider<int>((ref) => 0);

class FinanceCustomTapBar extends ConsumerWidget {
  const FinanceCustomTapBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 280,
        height: 44,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(33, 32, 32, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectionNegotiationTapBar(
                ref: ref,
                index: 0,
                title: "Revenues",
                selectIndex: () =>
                    ref.read(financeTabIndexProvider.notifier).state = 0,
                tabIndex: ref.watch(financeTabIndexProvider)),
            SelectionNegotiationTapBar(
                ref: ref,
                index: 1,
                title: "Expenses",
                selectIndex: () =>
                    ref.read(financeTabIndexProvider.notifier).state = 1,
                tabIndex: ref.watch(financeTabIndexProvider)),
          ],
        ),
      ),
    );
  }
}
