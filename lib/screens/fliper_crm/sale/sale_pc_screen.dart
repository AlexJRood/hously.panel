import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/widget/sale_custom_list_view.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/custom_vertical_divider.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/flipper_custom_list_view.dart';

class SalePcScreen extends StatelessWidget {
  const SalePcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 160.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children:[
              FlipperCustomListView(title: 'View All', itemCount: 10, id: 7),
              Row(
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
            ]
        ),
      ),
    );
  }
}
