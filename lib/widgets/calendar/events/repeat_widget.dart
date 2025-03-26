import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/enums/event/repeat_enum.dart';
import 'package:hously_flutter/screens/calendar/event_option.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

class RepeatWidget extends ConsumerWidget {
  const RepeatWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EventOption(
      title: 'Repeat',
      pageWidget: ListView.builder(
        shrinkWrap: true,
        itemCount: RepeatEnum.values.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      RepeatEnum.values[index].name,
                      style: TextStyle(
                        fontSize: 16,
                        color: index == 0 ? Colors.blue : null,
                      ),
                    ),
                    if (index == 0)  SvgPicture.asset(AppIcons.check, color: Colors.blue),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
            onTap: () {
              if (RepeatEnum.values[index] == RepeatEnum.custom) {
                ref
                    .read(navigationService)
                    .pushNamedScreen(Routes.customRepeat);
              }
            },
          );
        },
      ),
    );
  }
}
