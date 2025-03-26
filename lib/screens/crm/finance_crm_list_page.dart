// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
// import 'package:hously_flutter/const/route_constant.dart';
// import 'package:hously_flutter/data/design/design.dart';
// import 'package:hously_flutter/screens/crm/dashboard_crm_mobile.dart';
// import 'package:hously_flutter/screens/crm/finance_crm_pc_list.dart';
// import 'package:hously_flutter/state_managers/services/navigation_service.dart';
// import 'package:pie_menu/pie_menu.dart';
//
// class FinanceCrmListPage extends ConsumerWidget {
//   const FinanceCrmListPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return KeyboardListener(
//       focusNode: FocusNode()..requestFocus(),
//       onKeyEvent: (KeyEvent event) {
//         // Check if the pressed key matches the stored pop key
//         KeyBoardShortcuts().handleKeyNavigation(event, ref,context);
//         if (event.logicalKey == ref.watch(adclientprovider) &&
//             event is KeyDownEvent) {
//           ref.read(navigationService).pushNamedScreen(Routes.proFinanceRevenueAdd);
//         }
//       },
//       child: PieCanvas(
//         theme: const PieTheme(
//           rightClickShowsMenu: true,
//           leftClickShowsMenu: false,
//           buttonTheme: PieButtonTheme(
//             backgroundColor: AppColors.buttonGradient1,
//             iconColor: Colors.white,
//           ),
//           buttonThemeHovered: PieButtonTheme(
//             backgroundColor: Color.fromARGB(96, 58, 58, 58),
//             iconColor: Colors.white,
//           ),
//         ),
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             if (constraints.maxWidth > 1080) {
//               // Jeśli jest to aplikacja webowa lub aplikacja desktopowa z szerokością większą niż 1420
//               return const FinanceCrmPcList();
//             } else {
//               // W przeciwnym razie (aplikacja mobilna lub aplikacja desktopowa z mniejszą szerokością)
//               return DashboardCrmMobile();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
