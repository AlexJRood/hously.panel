import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/flipper_pop_up_bottom_navigation_bar.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/transaction_pop_up_mobile_screen.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/transaction_sidebar.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/nigotiation_header_widget.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';

class FlipperMainMobilePopUp extends ConsumerWidget {
  const FlipperMainMobilePopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    final List<Widget> screens = [
      const TransactionPopUpMobileScreen(),
      const TransactionPopUpMobileScreen(),
      const TransactionPopUpMobileScreen(),
      const TransactionPopUpMobileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(
          Icons.menu,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            spacing: 20,
            children: [
              const NegotiationHeaderWidget(isMobile: true),
              Expanded(child: screens[selectedIndex]),
              const BottomBarMobile(),
            ],
          ),
          const Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: FlipperPopUpBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}
