import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/modules/calendar/enums/event/guest_permission_enum.dart';
import 'package:hously_flutter/utils/extensions/string_extension.dart';
import 'package:hously_flutter/modules/calendar/event_option.dart';
import 'package:hously_flutter/modules/calendar/state/popup_calendar_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/modules/calendar/widgets/check_box_text.dart';
import 'package:hously_flutter/modules/calendar/widgets/event_input_decoration.dart';
import 'package:hously_flutter/modules/calendar/widgets/text_form_field_widget.dart';

class GuestWidget extends StatelessWidget {
  const GuestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return EventOption(title: 'Event', pageWidget: GuestSettingWidget());
  }
}

class GuestSettingWidget extends ConsumerWidget {
  GuestSettingWidget({super.key});

  VoidCallback? clearTextFieldCallback;

  void clearTextField() {
    if (clearTextFieldCallback != null) {
      clearTextFieldCallback!();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popupCalendarWatch = ref.watch(popupCalendarProvider);
    final eventDetails = popupCalendarWatch.event;
    final theme = ref.watch(themeColorsProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWidget(
            style: TextStyle(color: theme.textFieldColor),
            text: '',
            autoValidationMode: AutovalidateMode.onUserInteraction,
            inputDecoration: eventInputDecoration('Add guests', theme),
            validator: (email) {
              if (email == null || email.isEmpty) {
                return null;
              }
              if (!email.emailValidation()) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            onFieldSubmitted: (email) {
              if (email.emailValidation()) {
                ref.read(popupCalendarProvider).addGuest(email);
                clearTextField();
                clearTextField();
              }
            },
            clearController: (callback) => clearTextFieldCallback = callback,
          ),
          const SizedBox(height: 20),
          Column(
            children: eventDetails.guests
                .map((guest) => Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              guest.emailAddress,
                              style: TextStyle(
                                  fontFamily: 'RobotoRegular',
                                  color: theme.textFieldColor),
                            ),
                            if (guest.isOrganizer)
                              Text(
                                'Organizer',
                                style: TextStyle(
                                    color:
                                        theme.textFieldColor.withOpacity(0.5)),
                              ),
                          ],
                        ),
                        const Spacer(),
                        if (!guest.isOrganizer)
                          InkWell(
                            child:  Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: SvgPicture.asset(AppIcons.close, height: 18,width: 18,  color: theme.textFieldColor),
                            ),
                            onTap: () => ref
                                .read(popupCalendarProvider)
                                .removeAtGuest(guest),
                          ),
                      ],
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 0.3),
          const SizedBox(height: 10),
           Text('Guest permissions', style: TextStyle(fontSize: 17,  color: theme.textFieldColor)),
          Column(
            children: GuestPermissionsEnum.values.map((guestPermission) {
              final index =
                  GuestPermissionsEnum.values.indexOf(guestPermission);

              return Column(children: [
                const SizedBox(height: 20),
                CheckBoxText(
                  isActive: popupCalendarWatch.allPermissions()[index],
                  title: guestPermission.type,
                  onChanged: (modifyPermission) =>
                      ref.read(popupCalendarProvider).onChangePermission(
                            guestPermission,
                            modifyPermission,
                          ),
                ),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
