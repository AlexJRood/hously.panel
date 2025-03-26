import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/widget/sale_custom_list_view_card.dart';

class SaleCustomListView extends StatelessWidget {
  final int itemCount;
  final String title;
  const SaleCustomListView(
      {super.key, required this.itemCount, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 254,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return const SaleCustomListViewCard(
                      name: "John Doe",
                      email: "john.doe@gmail.com",
                      title: "Negotiation meeting",
                      date: "December 17, 10:30 - 12:00",
                      description:
                      "He likes the location, but wants a negotiable price.");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

