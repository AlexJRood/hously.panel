import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/widget/sale_custom_list_view.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/custom_vertical_divider.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/flipper_custom_vertical_list_view.dart';

class SaleMobileScreen extends StatelessWidget {
  const SaleMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FlipperCustomVerticalListView(itemCount: 10,),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SaleCustomListView(itemCount: 5, title: 'SCHEDULE MEETING (3)',),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: CustomVerticalDivider(),
                ),
                SaleCustomListView(itemCount: 1, title: 'Follow Up (3)',),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: CustomVerticalDivider(),
                ),
                SaleCustomListView(itemCount: 4, title: 'Agreedment (3)',),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: CustomVerticalDivider(),
                ),
                SaleCustomListView(itemCount: 2, title: 'Papers (3)',),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: CustomVerticalDivider(),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
