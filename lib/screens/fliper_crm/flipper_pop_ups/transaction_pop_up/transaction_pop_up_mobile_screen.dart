import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/transaction_details.dart';

class TransactionPopUpMobileScreen extends StatelessWidget {
  const TransactionPopUpMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            TransActionDetails(
              isMobile: true,
            ),
          ],
        ),
      ),
    );
  }
}
