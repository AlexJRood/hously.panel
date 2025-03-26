import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/custom_containers.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/no_todo_widget.dart';

import 'package:hously_flutter/widgets/crm/view/view/clientview/components/const.dart';
import 'package:intl/intl.dart';

class NewClientTodo extends ConsumerWidget {
  const NewClientTodo({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final clientTilecolor = theme.clientTilecolor;
    final screenidth = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: clientTilecolor,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          todo.isNotEmpty
              ? Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Lista-zadań'.tr,
                      style: TextStyle(
                          color: theme.whitewhiteblack,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Spacer(),
                    SizedBox(
                        child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(theme.clientbuttoncolor),
                        shape: WidgetStatePropertyAll((RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ))),
                      ),
                      icon: Icon(
                        Icons.add,
                        color: theme.fillColor,
                        size: 14,
                      ),
                      label: Text(
                        "Dodaj zadanie".tr,
                        style: TextStyle(fontSize: 10, color: theme.fillColor),
                      ),
                      onPressed: () {},
                    ))
                  ],
                )
              : SizedBox(),
          const SizedBox(
            height: 15,
          ),
          todo.isEmpty
              ? const TodoNoclient(
                  isPc: true,
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: todo.length,
                    itemBuilder: (context, index) {
                      final item = todo[index];
                      String formattedDate =
                          DateFormat('MMM d, y').format(item['date']);
                      return Card(
                        color: theme.popupcontainercolor,
                        margin: const EdgeInsets.all(5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    child: Prioritycontainer(
                                        isPC: true, priority: item['priority']),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  DateContainer(
                                    date: formattedDate,
                                    isPc: true,
                                  ),
                                  Spacer(),
                                  IconButton(
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert_rounded,
                                      size: 14,
                                      color: theme.whitewhiteblack,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      side: BorderSide(
                                        color: theme.whitewhiteblack,
                                      ),
                                      value: false,
                                      onChanged: (val) {}),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'],
                                        style: TextStyle(
                                            color: theme.whitewhiteblack,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 1,
                                      ),
                                      Text(
                                        "Focus on good negotiation",
                                        style: TextStyle(
                                            color: theme.whitewhiteblack,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                  const Spacer()
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ]));
  }
}
