import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/widget/sale_custom_list_view.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/custom_vertical_divider.dart';

class SalePopUpScreen extends StatelessWidget {
  const SalePopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color.fromRGBO(90, 90, 90, 1)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SaleCustomListView(
              itemCount: 5,
              title: 'SCHEDULE MEETING (3)',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: CustomVerticalDivider(),
            ),
            SaleCustomListView(
              itemCount: 1,
              title: 'Follow Up (3)',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: CustomVerticalDivider(),
            ),
            SaleCustomListView(
              itemCount: 4,
              title: 'Agreedment (3)',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: CustomVerticalDivider(),
            ),
            SaleCustomListView(
              itemCount: 2,
              title: 'Papers (3)',
            ),
          ],
        ),
      ),
    );
  }
}
