import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/custom_containers.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_todo.dart';
import 'package:intl/intl.dart';

class TodoListMobile extends ConsumerWidget {
  final List<Map<String, dynamic>> todo;

  const TodoListMobile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return ListView.builder(
      itemCount: todo.length,
      itemBuilder: (context, index) {
        final item = todo[index];
        String formattedDate = DateFormat('MMM d, y').format(item['date']);

        return Card(
          color: theme.popupcontainercolor,
          margin: const EdgeInsets.all(4), // Slightly reduced margin
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 4, vertical: 8), // Smaller padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 6), // Reduced spacing
                Row(
                  children: [
                    Prioritycontainer(
                      priority: item['priority'],
                      isPC: false,
                    ),
                    const SizedBox(width: 7), // Reduced spacing
                    DateContainer(
                      date: formattedDate,
                      isPc: false,
                    ),
                    const Expanded(flex: 10, child: SizedBox()),
                    IconButton(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert_rounded,
                        size: 12, // Smaller icon size
                        color: theme.whitewhiteblack,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4), // Reduced spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      side: BorderSide(color: theme.whitewhiteblack),
                      value: false,
                      onChanged: (val) {},
                    ),
                    const SizedBox(width: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: TextStyle(
                            color: theme.whitewhiteblack,
                            fontSize: 14, // Smaller text
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          "Focus on good negotiation",
                          style: TextStyle(
                            color: theme.whitewhiteblack,
                            fontSize: 12, // Smaller text
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
