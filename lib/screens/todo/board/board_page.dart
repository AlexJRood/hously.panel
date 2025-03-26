import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/todo/board/board_pc.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../data/design/design.dart';
import '../todo_mobile.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder:(context) =>  PieCanvas(
        theme:  const PieTheme(
          rightClickShowsMenu: true,
          leftClickShowsMenu: false,
          buttonTheme: PieButtonTheme(
            backgroundColor: AppColors.backgroundgradient1,
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
              return const BoardPc();
            } else {
              // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
              return const ToDoMobile();
            }
          },
        ),
      ),
    );
  }
}