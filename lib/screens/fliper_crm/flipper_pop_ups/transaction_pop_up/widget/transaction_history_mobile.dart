import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/activity_time_line_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/add_note_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/custom_calender_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/task_creation_list_view_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/transaction_events_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/nigotiation_header_widget.dart';

class TransactionHistoryMobile extends StatelessWidget {
  const TransactionHistoryMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: Color.fromRGBO(255, 255, 255, 1),
            )),
        title: const Text(
          'History',
          style: TextStyle(
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            const NegotiationHeaderWidget(isMobile: true),
            Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color.fromRGBO(90, 90, 90, 1)),
                    borderRadius: BorderRadius.circular(6)),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const ActivityTimeLineWidget(
                  isMobile: true,
                )),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 440,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(33, 32, 32, 1),
                    borderRadius: BorderRadius.circular(6)),
                child: Column(
                  children: [
                    const Expanded(
                        child: TransActionEventsWidget(
                      isMobile: true,
                    )),
                    Expanded(
                      child: Container(
                        color: const Color.fromRGBO(33, 32, 32, 1),
                        child: CustomCalendarWidget(
                          onDateSelected: (p0) {},
                        ),
                      ),
                    )
                  ],
                )),
            Container(
                height: 400,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Task Creation',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.add,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        )
                      ],
                    ),
                    Expanded(child: TaskCreationListViewWidget()),
                  ],
                )),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const AddNoteWidget();
                  },
                ));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.edit_note_rounded,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                        Text(
                          'Add notes',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
