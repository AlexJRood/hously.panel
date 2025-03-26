import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/provider/expenses_provider.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/provider/revenue_provider.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/activity_time_line_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/custom_calender_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/negotiation_history_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/transaction_details.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/transaction_events_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/flipper_pop_ups/transaction_pop_up/widget/transaction_task_creation_widget.dart';
import 'package:hously_flutter/screens/fliper_crm/refurbishment/provider/refurbishment_provider.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/provider/sale_client_provider.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/provider/sales_document_provider.dart';
import 'package:hously_flutter/screens/fliper_crm/sale/provider/sales_provider.dart';


class TransactionPopUpPcScreen extends ConsumerWidget {
  const TransactionPopUpPcScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color.fromRGBO(90, 90, 90, 1))),
        child: Row(
          spacing: 10,
          children: [
            const TransActionDetails(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color.fromRGBO(33, 32, 32, 1)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15),
                                child: Row(
                                  spacing: 5,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.share,
                                      color: Color.fromRGBO(233, 233, 233, 1),
                                    ),
                                    Text(
                                      'Share',
                                      style: TextStyle(
                                          color: Color.fromRGBO(233, 233, 233, 1),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ref.read(refurbishmentTaskProvider.notifier).refurbishmentFetchTask(ref)
                                .whenComplete(() {
                                  print(ref.watch(refurbishmentTaskProvider).map((e) => e.taskName,));

                                },);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color.fromRGBO(33, 32, 32, 1)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15),
                                  child: Row(
                                    spacing: 5,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.file_download_outlined,
                                        color: Color.fromRGBO(233, 233, 233, 1),
                                      ),
                                      Text(
                                        'Download',
                                        style: TextStyle(
                                            color: Color.fromRGBO(233, 233, 233, 1),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              spacing: 20,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: const Color.fromRGBO(33, 32, 32, 1)),
                                  child: const Row(
                                    children: [
                                      ActivityTimeLineWidget(),
                                      Expanded(
                                        child: NegotiationHistoryWidget(),
                                      )
                                    ],
                                  ),
                                ),
                                const TransactionTaskCreationWidget()
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              spacing: 20,
                              children: [
                                Container(
                                  height: 144,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: const Color.fromRGBO(33, 32, 32, 1)),
                                  child: CustomCalendarWidget(
                                    onDateSelected: (p0) {
                                      print(p0);
                                    },
                                  ),
                                ),
                                const TransActionEventsWidget(),
                                Container(
                                  height: 420,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(50, 50, 50, 1),
                                    borderRadius: BorderRadius.all(Radius.circular(6)),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 5,
                                    children: [
                                      SvgPicture.asset(AppIcons.newChat,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                        height: 15,
                                        width: 15,
                                      ),
                                      const Text('Notes...',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400
                                      ),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}











