import 'package:flutter/material.dart';

class NegotiationHistoryListViewWidget extends StatelessWidget {
  const NegotiationHistoryListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            spacing: 10,
            children: [
              const SizedBox(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monday, Feb 01, 2025',
                    style: TextStyle(
                        color: Color.fromRGBO(145, 145, 145, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Divider(),
                  ))
                ],
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(41, 41, 41, 1)),
                child: Row(
                  children: [
                    const VerticalDivider(),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 30,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Initial Price:',
                                  style: TextStyle(
                                      color: Color.fromRGBO(200, 200, 200, 1),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '\$120,000',
                                  style: TextStyle(
                                      color: Color.fromRGBO(200, 200, 200, 1),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Seller Offer:',
                                  style: TextStyle(
                                      color: Color.fromRGBO(233, 233, 233, 1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '\$118,000',
                                  style: TextStyle(
                                      color: Color.fromRGBO(233, 233, 233, 1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
