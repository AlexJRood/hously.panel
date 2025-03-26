import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/transaction_sidebar.dart';

class FlipperPopUpBottomNavigationBar extends ConsumerWidget {
  const FlipperPopUpBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Container(
      height: 60,
      width: 340,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(64, 112, 169, 1),
          Color.fromRGBO(29, 62, 102, 1),
        ]),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ], // Optional shadow for depth
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
        },
        backgroundColor:
            Colors.transparent,
        selectedItemColor: const Color.fromRGBO(161, 236, 230, 1),
        unselectedItemColor: const Color.fromRGBO(255, 255, 255, 1),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.home),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.arrowTrendUp),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppIcons.duplicate),
            label: 'Refurbish',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Sale',
          ),
        ],
      ),
    );
  }
}
