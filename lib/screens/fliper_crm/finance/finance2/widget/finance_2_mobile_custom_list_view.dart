import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/finance2/widget/finance_2_property_card.dart';
import 'finance_2_tap_bar.dart';

class Finance2MobileCustomListView extends StatelessWidget {
  const Finance2MobileCustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Finance2TabBar(),
        const SizedBox(height: 10), // Added spacing instead of `spacing` property
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.sort,
              color: Color.fromRGBO(145, 145, 145, 1),
            ),
            SizedBox(width: 10), // Added spacing instead of `spacing` property
            Text(
              'Sort',
              style: TextStyle(
                color: Color.fromRGBO(145, 145, 145, 1),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const Finance2PropertyCard(isMobile: true,);
            },
          ),
        ),
      ],
    );
  }
}
