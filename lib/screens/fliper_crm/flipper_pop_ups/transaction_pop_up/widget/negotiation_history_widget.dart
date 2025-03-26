import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/negotiation_history_list_view_widget.dart';

class NegotiationHistoryWidget extends StatelessWidget {
  const NegotiationHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 521,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Color.fromRGBO(50, 50, 50, 1),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 57,
            width: MediaQuery.of(context).size.width,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(50, 50, 50, 1)),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Negotiation history',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Expanded(
            child: NegotiationHistoryListViewWidget(),
          )
        ],
      ),
    );
  }
}
