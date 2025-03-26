import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/add_client_form/widgets/event.dart';

class ViewWidget extends ConsumerWidget {
  final bool isMobile;
  const ViewWidget(
      {super.key,
      this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            if (!ref.watch(showScheduleEventProvider))
              InkWell(
                onTap: () {
                  ref.read(showScheduleEventProvider.notifier).state = true;
                },
                child: Container(
                  height: 32,
                  width: 152,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: const Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Color.fromRGBO(35, 35, 35, 1),
                        size: 16,
                      ),
                      Text(
                        'Schedule an Event ',
                        style: TextStyle(
                            color: Color.fromRGBO(35, 35, 35, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
            if (ref.watch(showScheduleEventProvider))
              AddEventCardWidget(
                isMobile: isMobile,
              )
          ],
        ));
  }
}
