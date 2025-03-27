import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/style.dart';
import 'package:hously_flutter/modules/calendar/enums/event/business_type_enum.dart';
import 'package:hously_flutter/modules/calendar/enums/event/visibility_type_enum.dart';
import 'package:hously_flutter/modules/calendar/state/popup_calendar_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/modules/calendar/widgets/dropdown_field_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/events/add_notification_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/events/event_web_option.dart';

class EventExtraWidget extends ConsumerStatefulWidget {
  final InputDecoration inputDecoration;

  const EventExtraWidget({
    super.key,
    required this.inputDecoration,
  });

  @override
  _EventExtraWidgetState createState() => _EventExtraWidgetState();
}

class _EventExtraWidgetState extends ConsumerState<EventExtraWidget> {
  bool isFirstWidget = true;

  void switchWidget() {
    setState(() {
      isFirstWidget = !isFirstWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventDetails = ref.watch(popupCalendarProvider).event;
    final theme = ref.watch(themeColorsProvider);

    return AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: isFirstWidget
          ? EventWebOption(
              iconData: Icons.calendar_today,
              secondWidget: InkWell(
                onTap: switchWidget,
                child: const SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'abbas jafary',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                      Text(
                        'Free . Default visibility . Do not notify',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  child: EventWebOption(
                    iconData: Icons.business_center_outlined,
                    secondWidget: DropDownWidget(
                      texts: BusinessTypeEnum.values
                          .map((value) => value.type)
                          .toList(),
                      values: BusinessTypeEnum.values,
                      isExpanded: false,
                      hasUnderLine: true,
                      decoration: dropdownStyle.copyWith(),
                      currentValue: eventDetails.busy
                          ? BusinessTypeEnum.free
                          : BusinessTypeEnum.busy,
                      onChanged: (repeatType) {},
                    ),
                  ),
                ),
                EventWebOption(
                  iconData: Icons.lock_outline,
                  secondWidget: SizedBox(
                    height: 40,
                    child: DropDownWidget(
                      texts: VisibilityTypeEnum.values
                          .map((value) => value.type)
                          .toList(),
                      values: VisibilityTypeEnum.values,
                      isExpanded: false,
                      hasUnderLine: true,
                      decoration: dropdownStyle,
                      currentValue: eventDetails.visibility,
                      onChanged: (repeatType) {},
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const AddNotificationWidget(),
              ],
            ),
    );
  }
}
