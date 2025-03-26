import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/client_calendar.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/no_event_widget.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/const.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:get/get_utils/get_utils.dart';

class NewClientEvent extends ConsumerWidget {
  const NewClientEvent({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final clientTilecolor = theme.clientTilecolor;
    final isdark = ref.watch(isDefaultDarkSystemProvider);
    return Container(
      height: 348,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: clientTilecolor,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: SizedBox(
                child: CustomTableCalendarPc(
                    primaryColor: Theme.of(context).primaryColor,
                    fillColor: Colors.white,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    events: events)),
          ),
          const Expanded(flex: 10, child: ClientEvettile())
        ],
      ),
    );
  }
}

class ClientEvettile extends ConsumerWidget {
  const ClientEvettile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Text(
                      "Planowane wydarzenia".tr,
                      style: TextStyle(
                          color: theme.whitewhiteblack,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
                const Expanded(flex: 1, child: SizedBox()),
                if (events.isNotEmpty) ...[
                  Expanded(
                      flex: 3,
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
                          "Dodaj wydarzenie".tr,
                          style: TextStyle(
                            fontSize: 10,
                            color: theme.fillColor,
                          ),
                        ),
                        onPressed: () {},
                      ))
                ],
              ],
            ),
          ),
          if (events.isNotEmpty) ...[
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventCard(event: events[index]);
                },
              ),
            ),
          ],
          if (events.isEmpty) ...[
            const Spacer(),
            const NoEventWidget(
              isPc: true,
            ),
            const Spacer()
          ]
        ],
      ),
    );
  }
}

class EventCard extends ConsumerWidget {
  final Map<String, dynamic> event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context, ref) {
    // Formatting the DateTime to a readable string
    String formattedDate = DateFormat('MMMM dd, HH:mm').format(event['date']);
    final theme = ref.watch(themeColorsProvider);
    final isdark = ref.watch(isDefaultDarkSystemProvider);
    return Card(
      color: theme.popupcontainercolor,
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: IntrinsicHeight(
          child: Row(
            children: [
              VerticalDivider(
                thickness: 2,
                color: theme.whitewhiteblack,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title']!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isdark
                            ? clienttileTextcolor
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formattedDate, // Using formatted date here
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.whitewhiteblack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Location: ${event['location']!}',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.whitewhiteblack,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: Icon(
                        color: theme.whitewhiteblack,
                        Icons.more_vert_rounded,
                        size: 14,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
