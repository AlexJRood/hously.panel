import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/fliper_list_view__custom_card.dart';
import 'package:hously_flutter/screens/fliper_crm/selection_and_negotiations/widgets/flipper_custom_vertical_list_view.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/gradiant_text_widget.dart';

final expandedProvider = StateProvider<Map<int, bool>>((ref) => {});

class RefurbishmentMobileScreen extends ConsumerWidget {
  const RefurbishmentMobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedState = ref.watch(expandedProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const FlipperCustomVerticalListView(itemCount: 10,),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Parker Rd. Allentown",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Warszawa, Mokotów, Poland",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(200, 200, 200, 1),
                  ),
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        textAlign: TextAlign.end,
                        '~\$250,000',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GradientText('Profit Potential:',
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(87, 148, 221, 1),
                              Color.fromRGBO(87, 222, 210, 1),
                            ]),
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 10,
                                fontWeight: FontWeight.w700)),
                        GradientText(' \$50,000',
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(87, 148, 221, 1),
                              Color.fromRGBO(87, 222, 210, 1),
                            ]),
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontSize: 10,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: refurbishmentItems.length,
              itemBuilder: (context, index) {
                final isExpanded = expandedState[index] ?? false;

                return Column(
                  children: [
                    ListTile(
                      tileColor: isExpanded
                          ? const Color.fromRGBO(87, 148, 221, 0.1)
                          : Colors.black,
                      textColor: Colors.white,
                      iconColor: Colors.white,
                      title: Text(
                        refurbishmentItems[index],
                        style: TextStyle(
                            color: isExpanded
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : Colors.grey),
                      ),
                      trailing: Text("3 days",
                          style: TextStyle(
                              color: isExpanded
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : Colors.grey)),
                      leading: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        ref.read(expandedProvider.notifier).state = {
                          ...expandedState,
                          index: !isExpanded,
                        };
                      },
                    ),
                    if (isExpanded)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(87, 148, 221, 0.1),
                          border: Border(
                            left: BorderSide(
                                color: Colors.blue.shade300, width: 1),
                          ),
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "01/01/2025  –  01/01/2025",
                              style: TextStyle(
                                  color: Color.fromRGBO(161, 236, 230, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    const Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        height: 0), // Divider after each item
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
