import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/calendar/calendar_mobile.dart';
import 'package:hously_flutter/modules/calendar/calendar_pc.dart';
import 'package:pie_menu/pie_menu.dart';

class AgentCalendarPage extends ConsumerWidget {
  const AgentCalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PieCanvas(
      theme: const PieTheme(
        rightClickShowsMenu: true,
        leftClickShowsMenu: false,
        buttonTheme: PieButtonTheme(
          backgroundColor: AppColors.buttonGradient1,
          iconColor: Colors.white,
        ),
        buttonThemeHovered: PieButtonTheme(
          backgroundColor: Color.fromARGB(96, 58, 58, 58),
          iconColor: Colors.white,
        ),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 1080) {
            // Jeśli jest to aplikacja webowa lub aplikacja desktopowa z szerokością większą niż 1420
            return const AgentCalendarPc();
          } else {
            // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
            return AgentCalendarMobile();
          }
        },
      ),
    );
  }
}
