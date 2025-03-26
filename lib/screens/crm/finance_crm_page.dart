import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/crm/draggable_finance_crm_mobile.dart';
import 'package:hously_flutter/screens/crm/draggable_finance_crm_pc.dart';
import 'package:hously_flutter/screens/crm/dashboard_crm_mobile.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:showcaseview/showcaseview.dart';

class FinanceCrmPage extends ConsumerWidget {
  const FinanceCrmPage({super.key});

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
            return const DraggableFinanceCrmPc();
          } else {
            // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
            return DraggableFinanceCrmMobile();
          }
        },
      ),
    );
  }
}
