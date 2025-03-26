import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/selection_and_negotiation_pc_screen.dart';

class FlipperCustomTapBar extends ConsumerWidget {
  const FlipperCustomTapBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 418,
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
              title: "Negotiations",
              selectIndex: () => ref.read(tabIndexProvider.notifier).state = 0,
              tabIndex: ref.watch(tabIndexProvider),
            ),
            SelectionNegotiationTapBar(
                ref: ref,
                index: 1,
                title: "Refurbishment",
                selectIndex: () =>
                    ref.read(tabIndexProvider.notifier).state = 1,
                tabIndex: ref.watch(tabIndexProvider)),
            SelectionNegotiationTapBar(
                ref: ref,
                index: 2,
                title: "Sale",
                selectIndex: () =>
                    ref.read(tabIndexProvider.notifier).state = 2,
                tabIndex: ref.watch(tabIndexProvider)),
          ],
        ),
      ),
    );
  }
}

class SelectionNegotiationTapBar extends StatelessWidget {
  final WidgetRef ref;
  final int index;
  final String title;
  final void Function()? selectIndex;
  final int tabIndex;
  const SelectionNegotiationTapBar(
      {super.key,
      required this.title,
      required this.ref,
      required this.index,
      required this.selectIndex,
      required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    final isSelected = tabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: selectIndex,
        child: Container(
          width: 130,
          height: 32,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromRGBO(87, 148, 221, 0.2)
                : const Color.fromRGBO(87, 148, 221, 1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? const Color.fromRGBO(161, 236, 230, 1)
                    : const Color.fromRGBO(161, 236, 230, 0.3),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
