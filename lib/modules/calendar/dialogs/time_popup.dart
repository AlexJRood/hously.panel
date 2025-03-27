import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/utils/extensions/context_extension.dart';
import 'package:hously_flutter/modules/calendar/state/popup_timer_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/modules/calendar/widgets/elevated_button.dart';

void showTimePopup({
  required TapDownDetails event,
  required BuildContext context,
  required WidgetRef ref,
  required ValueChanged<Duration> onDone,
}) {
  final position = event.globalPosition;
  const calendarWidth = 200.0;

  context.showPopupMenu(
    relativeRect: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx,
      position.dy,
    ),
    boxConstraints: const BoxConstraints.expand(width: calendarWidth),
    items: [
      PopupMenuItem(
        enabled: false,
        padding: EdgeInsets.zero,
        child: SizedBox(
          width: calendarWidth,
          child: Column(
            children: [
              CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                onTimerDurationChanged: (newDuration) =>
                    ref.read(popupTimerProvider).changedDuration = newDuration,
              ),
              Row(
                children: [
                  ElevatedButtonWidget(
                    elevation: 0,
                    bgColor: Colors.transparent,
                    onTapped: () => ref.read(navigationService).beamPop(),
                    child: const Text('Close'),
                  ),
                  ElevatedButtonWidget(
                    elevation: 0,
                    bgColor: Colors.transparent,
                    onTapped: () {
                      onDone(ref.watch(popupTimerProvider).changedDuration);
                      ref.read(navigationService).beamPop();
                    },
                    child: const Text('Done'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
