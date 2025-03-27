import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/colors.dart';
import 'package:hously_flutter/modules/calendar/state/appointments_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/modules/calendar/widgets/elevated_button.dart';

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
        InkWell(
          onTap: () {
            ref.read(navigationService).beamPop();
          },
          child: const SizedBox(
            height: 32,
            width: 92,
            child: Center(
              child: Text(
                'Reschedule',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        const SizedBox(width: widgetSpace),
        InkWell(
          onTap: onSaved,
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(200, 200, 200, 1),
                borderRadius: BorderRadius.circular(6)),
            height: 32,
            width: 53,
            child: Center(
              child: Text(
                isEdit ? 'Edit' : 'Save',
                style: const TextStyle(
                    color: Color.fromRGBO(35, 35, 35, 1),
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
