import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/calendar/enums/event/period_enum.dart';
import 'package:hously_flutter/utils/extensions/context_extension.dart';
import 'package:hously_flutter/modules/calendar/event_option.dart';
import 'package:hously_flutter/modules/calendar/widgets/list_tile_option.dart';

class CustomRepeatWidget extends StatelessWidget {
  const CustomRepeatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return EventOption(
      title: 'Custom',
      pageWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTileOption(
            title: 'Frequency',
            details: 'day',
            onTapped: () {
              final renderBox = context.findRenderObject() as RenderBox;
              final position = renderBox.localToGlobal(Offset.zero);
              final relativeRect = RelativeRect.fromLTRB(
                renderBox.size.width,
                position.dy,
                position.dx + renderBox.size.width,
                position.dy + renderBox.size.height,
              );

              context.showPopupMenu(
                relativeRect: relativeRect,
                items: List.generate(
                  PeriodEnum.values.length,
                  (index) => PopupMenuItem(
                    value: index,
                    child: Text(PeriodEnum.values[index].type),
                  ),
                ),
              );
            },
          ),
          ListTileOption(
            title: 'Every',
            details: 'day',
            onTapped: () {
              final renderBox = context.findRenderObject() as RenderBox;
              final position = renderBox.localToGlobal(Offset.zero);
              final relativeRect = RelativeRect.fromLTRB(
                renderBox.size.width,
                position.dy,
                position.dx + renderBox.size.width,
                position.dy + renderBox.size.height,
              );

              context.showPopupMenu(
                relativeRect: relativeRect,
                items: List.generate(
                  99,
                  (index) => PopupMenuItem(
                    value: index + 1,
                    child: Text(index == 0 ? 'day' : '${index + 1} days'),
                  ),
                ),
              );
            },
          ),
          const Text(
            'Event will repeat every day',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
