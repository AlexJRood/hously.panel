import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/state_managers/screen/calendar/appointments_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/calendar/elevated_button.dart';

class EventButtonsWidget extends ConsumerWidget {
  final VoidCallback onSaved;

  const EventButtonsWidget({required this.onSaved, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEdit = ref.watch(appointmentsProvider).isEdit;
    const widgetSpace = 10.0;
    final theme = ref.watch(themeColorsProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 150,
          child: ElevatedButtonWidget(
            bgColor: Theme.of(context).iconTheme.color,
            elevation: 0,
            child: Text(
              'Close',
              style: TextStyle(color: theme.textFieldColor),
            ),
            onTapped: () => ref.read(navigationService).beamPop(),
          ),
        ),
        const SizedBox(width: widgetSpace),
        SizedBox(
          width: 150,
          child: ElevatedButtonWidget(
            bgColor: Theme.of(context).primaryColor,
            elevation: 0,
            onTapped: onSaved,
            child: Text(
              isEdit ? 'Edit' : 'Save',
              style: TextStyle(color: Theme.of(context).iconTheme.color),
            ),
          ),
        ),
      ],
    );
  }
}
