import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/models/gantt_task_model.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/finance2/widget/finance_2_property_card.dart';
import 'package:hously_flutter/screens/fliper_crm/refurbishment/widget/gantt_display_chart_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/gradiant_text_widget.dart';

class RefurbishPopUpScreen extends StatelessWidget {
  const RefurbishPopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color.fromRGBO(90, 90, 90, 1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(28.0),
              child: SizedBox(
                width: 300,
                child: Finance2PropertyCard(isMobile: true),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    children: [
                      SizedBox(
                        height: 93,
                        child: ListView.builder(
                          itemCount: refurbishmentListData.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final listData = refurbishmentListData[index];

                            return Row(
                              spacing: 30,
                              children: [
                                DottedBorder(
                                  color: const Color.fromRGBO(200, 200, 200, 1),
                                  dashPattern: const [4, 2],
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(6),
                                  padding: EdgeInsets.zero,
                                  child: Container(
                                    width: 285,
                                    height: 93,
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(33, 32, 32, 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            listData['title']!,
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  200, 200, 200, 1),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            listData['amount']!,
                                            style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                listData['subtext']!,
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      200, 200, 200, 1),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                listData['value']!,
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      200, 200, 200, 1),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox()
                              ],
                            );
                          },
                        ),
                      ),
                      const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Parker Rd. Allentown',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '~\$165.000',
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Warszawa, Mokotów, Poland',
                                style: TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                  fontSize: 12,
                                ),
                              ),
                              GradientText(
                                ' Profit Potential:  \$50.000 ',
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(87, 222, 210, 1),
                                  Color.fromRGBO(87, 148, 221, 1),
                                ]),
                                style: TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      GanttDisplayChartWidget(
                        tasks: [
                          GanttTask("Planning", 0, 1),
                          GanttTask("Demolition", 1, 3),
                          GanttTask("Electrical/Plumbing", 1.2, 4),
                          GanttTask("Framing/Drywall", 4.3, 8),
                          GanttTask("Paint", 5, 9),
                          GanttTask("Cabinets Fixtures", 4, 5),
                          GanttTask("Doors/Surrounds", 6, 8),
                          GanttTask("Cleaning", 4.5, 10),
                          GanttTask("Flooring", 3, 10),
                          GanttTask("Trim/Finish Work", 9, 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
