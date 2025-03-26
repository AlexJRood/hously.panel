import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class TransactionSidebar extends ConsumerWidget {
  const TransactionSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.home_outlined, 'label': 'Transaction'},
      {'icon': Icons.trending_up, 'label': 'Calculator'},
      {'icon': Icons.note_outlined, 'label': 'Refurbish '},
      {'icon': Icons.house_outlined, 'label': 'Sale'},
    ];

    return Container(
      height: MediaQuery.of(context).size.height,
      width: 68,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(50, 50, 50, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(menuItems.length, (index) {
          final item = menuItems[index];
          return GestureDetector(
            onTap: () => ref.read(selectedIndexProvider.notifier).state = index,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Icon(
                    item['icon'],
                    size: 24,
                    color:
                        selectedIndex == index ? Colors.white : Colors.white38,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['label'],
                    style: TextStyle(
                      color: selectedIndex == index
                          ? Colors.white
                          : Colors.white38,
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

