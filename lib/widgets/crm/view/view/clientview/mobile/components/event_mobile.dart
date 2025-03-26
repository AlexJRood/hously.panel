import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/client_calendar.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/const.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/no_event_widget.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_event.dart';

class NewClientEventMobile extends StatelessWidget {
  const NewClientEventMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        events.isNotEmpty
            ? SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return EventCard(event: events[index]);
                  },
                ),
              )
            : const NoEventWidget(
                isPc: false,
              ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 400,
          child: CustomTableCalendarMobile(
              primaryColor: Theme.of(context).primaryColor,
              fillColor: Colors.white,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
              events: events),
        ),
      ],
    );
  }
}
