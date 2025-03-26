import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/transaction_history_mobile.dart';

class TransActionDetails extends StatelessWidget {
  final bool isMobile;
  const TransActionDetails({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? MediaQuery.of(context).size.width : 340,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(33, 32, 32, 1),
          border: isMobile
              ? null
              : Border.all(color: const Color.fromRGBO(90, 90, 90, 1))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              const Text(
                'Transaction Details',
                style: TextStyle(
                    color: Color.fromRGBO(200, 200, 200, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const Text(
                '\$100,000',
                style: TextStyle(
                    color: Color.fromRGBO(233, 233, 233, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 427,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color.fromRGBO(90, 90, 90, 1)),
                    borderRadius: BorderRadius.circular(6)),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  spacing: 29,
                  children: [
                    const Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.folder_open,
                          color: Color.fromRGBO(145, 145, 145, 1),
                        ),
                        Text(
                          'Parker Rd. Allentown',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Column(
                      spacing: 12,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                color: Color.fromRGBO(145, 145, 145, 1),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color:
                                      const Color.fromRGBO(166, 227, 184, 0.1)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 15),
                                child: Text(
                                  'Finalized',
                                  style: TextStyle(
                                      color: Color.fromRGBO(166, 227, 184, 1),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            Text(
                              'Transactions Type ',
                              style: TextStyle(
                                color: Color.fromRGBO(145, 145, 145, 1),
                              ),
                            ),
                            Text(
                              'SALE',
                              style: TextStyle(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            Text(
                              'Transactions ID',
                              style: TextStyle(
                                color: Color.fromRGBO(145, 145, 145, 1),
                              ),
                            ),
                            Text(
                              '347789',
                              style: TextStyle(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            Text(
                              'Buyer',
                              style: TextStyle(
                                color: Color.fromRGBO(145, 145, 145, 1),
                              ),
                            ),
                            Text(
                              'Rodica Fizz',
                              style: TextStyle(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            Text(
                              'Transactions Date',
                              style: TextStyle(
                                color: Color.fromRGBO(145, 145, 145, 1),
                              ),
                            ),
                            Text(
                              '01-02-2025, 2:40 PM',
                              style: TextStyle(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            Text(
                              'Amount',
                              style: TextStyle(
                                color: Color.fromRGBO(145, 145, 145, 1),
                              ),
                            ),
                            Text(
                              '\$100,000',
                              style: TextStyle(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            Text(
                              'Curency',
                              style: TextStyle(
                                color: Color.fromRGBO(145, 145, 145, 1),
                              ),
                            ),
                            Text(
                              'USD',
                              style: TextStyle(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            Text(
                              'Commission',
                              style: TextStyle(
                                color: Color.fromRGBO(145, 145, 145, 1),
                              ),
                            ),
                            Text(
                              '\$20,000',
                              style: TextStyle(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 10,
                          children: [
                            Text(
                              'Payment Method',
                              style: TextStyle(
                                color: Color.fromRGBO(145, 145, 145, 1),
                              ),
                            ),
                            Text(
                              '**** 3560',
                              style: TextStyle(
                                  color: Color.fromRGBO(233, 233, 233, 1),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      'View advertisement',
                      style: TextStyle(
                          color: Color.fromRGBO(166, 227, 184, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color.fromRGBO(90, 90, 90, 1)),
                    borderRadius: BorderRadius.circular(6)),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    const Text(
                      'Notes',
                      style: TextStyle(
                        color: Color.fromRGBO(145, 145, 145, 1),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Divider()),
                    const Text(
                      'Transaction succes',
                      style: TextStyle(
                        color: Color.fromRGBO(145, 145, 145, 1),
                      ),
                    ),
                  ],
                ),
              ),
              if (isMobile) ...[
                const Divider(
                  color: Color.fromRGBO(90, 90, 90, 1),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const TransactionHistoryMobile();
                      },
                    ));
                  },
                  leading: const Icon(
                    Icons.folder_open,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  title: const Text(
                    'View History',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
