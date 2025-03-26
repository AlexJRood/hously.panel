import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/task_creation_list_view_widget.dart';

class TransactionTaskCreationWidget extends StatelessWidget {
  const TransactionTaskCreationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color.fromRGBO(33, 32, 32, 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Task Creation',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 32,
                width: 96,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(79, 79, 79, 1),
                    borderRadius: BorderRadius.circular(6)),
                child: const Center(
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Color.fromRGBO(233, 233, 233, 1),
                        size: 20,
                      ),
                      Text(
                        'Add task',
                        style: TextStyle(
                            color: Color.fromRGBO(233, 233, 233, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const Expanded(
            child: TaskCreationListViewWidget(),
          )
        ],
      ),
    );
  }
}
