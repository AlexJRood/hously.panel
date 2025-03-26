// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:hously_flutter/const/backgroundgradient.dart';
//
// import 'package:hously_flutter/theme/apptheme.dart';
// import 'package:hously_flutter/const/route_constant.dart';
// import 'package:hously_flutter/data/design/design.dart';
// import 'package:hously_flutter/state_managers/data/crm/finance/api_servises_expenses.dart';
// import 'package:hously_flutter/state_managers/data/crm/finance/dio_provider.dart';
// import 'package:hously_flutter/state_managers/data/crm/finance/filter_plans.dart';
// import 'package:hously_flutter/state_managers/services/navigation_service.dart';
// import 'package:hously_flutter/widgets/crm/appbar_crm.dart';
// import 'package:hously_flutter/widgets/crm/finance/features/expenses/expenses_list.dart';
// import 'package:hously_flutter/widgets/crm/finance/features/revenue_list.dart';
// import 'package:hously_flutter/widgets/sidebar/sidebar_crm.dart';
// import 'package:hously_flutter/widgets/crm/view/view/buttons.dart';
// import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
// import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
//
// import '../../widgets/side_menu/slide_rotate_menu.dart';
//
// class FinanceCrmPcList extends ConsumerWidget {
//   const FinanceCrmPcList({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedList = ref
//         .watch(filtersPlansProvider.select((filters) => filters.selectedList));
//     double screenWidth = MediaQuery.of(context).size.width;
//     final sideMenuKey = GlobalKey<SideMenuState>();
//
//     return KeyboardListener(
//       focusNode: FocusNode()..requestFocus(),
//       onKeyEvent: (KeyEvent event) {
//         // Check if the pressed key matches the stored pop key
//         KeyBoardShortcuts().handleKeyNavigation(event, ref, context);
//         final Set<LogicalKeyboardKey> pressedKeys =
//             HardwareKeyboard.instance.logicalKeysPressed;
//         final LogicalKeyboardKey? shiftKey = ref.watch(togglesidemenu1);
//         if (pressedKeys.contains(ref.watch(adclientprovider)) &&
//             !pressedKeys.contains(shiftKey)) {
//           ref
//               .read(navigationService)
//               .pushNamedScreen(Routes.proFinanceRevenueAdd);
//         } if(ref.read(navigationService).canBeamBack()){
//           KeyBoardShortcuts().handleBackspaceNavigation(event, ref);
//         }
//       },
//       child: Scaffold(
//         body: SideMenuManager.sideMenuSettings(
//           menuKey: sideMenuKey,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: CustomBackgroundGradients.customcrmright(context, ref),
//             ),
//             child: Stack(
//               children: [
//                 Row(
//                   children: [
//                      SidebarAgentCrm(
//                        sideMenuKey: sideMenuKey,
//                      ),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           const TopAppBarCRM(),
//                           Expanded(
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     width: screenWidth / 5 * 3,
//                                     child: const FilterSection(),
//                                   ),
//                                   Flexible(
//                                     child: selectedList == 'Revenue'
//                                         ? const CrmRevenueList() // Show revenue list
//                                         : const CrmExpensesList(), // Show expenses list
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Positioned(
//                   right: 20,
//                   bottom: 20,
//                   child: FinanceCrmSideButtons(ref: ref),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class FilterSection extends ConsumerStatefulWidget {
//   const FilterSection({super.key});
//
//   @override
//   _FilterSectionState createState() => _FilterSectionState();
// }
//
// class _FilterSectionState extends ConsumerState<FilterSection> {
//   bool allowMultipleSelection = false;
//   String _selectedOrdering = 'date_create_asc'; // Default sorting
//
//   @override
//   Widget build(BuildContext context) {
//     final availableYearsAsync = ref.watch(availableYearsExpensesProvider);
//     final filters = ref.watch(
//         filtersPlansProvider); // Get the global filters including selectedList
//     final theme = ref.watch(themeColorsProvider);
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ChoiceChip to select between Revenue and Expenses list
//           Wrap(
//             spacing: 8.0,
//             children: [
//               ChoiceChip(
//                 checkmarkColor: Theme.of(context).iconTheme.color,
//                 selectedColor:
//                     Theme.of(context).primaryColor, // Color when selected
//                 backgroundColor: theme.fillColor,
//
//                 label: Text(
//                   'Revenue',
//                   style: TextStyle(
//                     color: filters.selectedList == 'Revenue'
//                         ? Theme.of(context).iconTheme.color
//                         : theme.textFieldColor,
//                   ),
//                 ),
//                 selected: filters.selectedList ==
//                     'Revenue', // Check global selectedList
//                 onSelected: (selected) {
//                   ref
//                       .read(filtersPlansProvider.notifier)
//                       .setSelectedList('Revenue'); // Update global state
//                   _applyFilters(ref);
//                 },
//               ),
//               ChoiceChip(
//                 checkmarkColor: Theme.of(context).iconTheme.color,
//                 selectedColor:
//                     Theme.of(context).primaryColor, // Color when selected
//                 label: Text(
//                   'Expenses',
//                   style: TextStyle(
//                     color: filters.selectedList == 'Expenses'
//                         ? Theme.of(context).iconTheme.color
//                         : theme.textFieldColor,
//                   ),
//                 ),
//                 backgroundColor: theme.fillColor,
//                 selected: filters.selectedList ==
//                     'Expenses', // Check global selectedList
//                 onSelected: (selected) {
//                   ref
//                       .read(filtersPlansProvider.notifier)
//                       .setSelectedList('Expenses'); // Update global state
//                   _applyFilters(ref);
//                 },
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//
//           // Year and Month filters (common for both lists)
//           availableYearsAsync.when(
//             data: (years) {
//               return Wrap(
//                 spacing: 8.0,
//                 runSpacing: 8,
//                 children: years.map((year) {
//                   final isSelected = filters.years.contains(year);
//                   return ChoiceChip(
//                     checkmarkColor: Theme.of(context).iconTheme.color,
//                     backgroundColor: theme.fillColor,
//                     selectedColor: Theme.of(context).primaryColor,
//                     label: Text(
//                       '$year',
//                       style: TextStyle(
//                         color: isSelected
//                             ? Theme.of(context).iconTheme.color
//                             : theme.textFieldColor,
//                       ),
//                     ),
//                     selected: isSelected,
//                     onSelected: (_) {
//                       if (allowMultipleSelection) {
//                         ref
//                             .read(filtersPlansProvider.notifier)
//                             .toggleYear(year);
//                       } else {
//                         ref.read(filtersPlansProvider.notifier).setYear(year);
//                       }
//                       _applyFilters(ref);
//                     },
//                   );
//                 }).toList(),
//               );
//             },
//             loading: () => const Center(child: CircularProgressIndicator()),
//             error: (error, stack) =>
//                 const Center(child: Text('Error loading years')),
//           ),
//
//           const SizedBox(height: 15),
//
//           Wrap(
//             spacing: 8.0,
//             runSpacing: 8,
//             children: List.generate(12, (index) {
//               final month = index + 1;
//               final isSelected = filters.months.contains(month);
//               return ChoiceChip(
//                 checkmarkColor: Theme.of(context).iconTheme.color,
//                 backgroundColor: theme.fillColor,
//                 selectedColor: Theme.of(context).primaryColor,
//                 label: Text(
//                   '${_monthName(month)}',
//                   style: TextStyle(
//                     color: isSelected
//                         ? Theme.of(context).iconTheme.color
//                         : theme.textFieldColor,
//                   ),
//                 ),
//                 selected: isSelected,
//                 onSelected: (_) {
//                   if (allowMultipleSelection) {
//                     ref.read(filtersPlansProvider.notifier).toggleMonth(month);
//                   } else {
//                     ref.read(filtersPlansProvider.notifier).setMonth(month);
//                   }
//                   _applyFilters(ref);
//                 },
//               );
//             }),
//           ),
//           const SizedBox(height: 16),
//
//           // Other filter options (clear filters, sort ordering, etc.)
//           Align(
//             alignment: Alignment.centerRight,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text('Wybierz wiele lat i miesięcy'.tr,
//                     style: AppTextStyles.interMedium10),
//                 Switch(
//                   value: allowMultipleSelection,
//                   onChanged: (value) {
//                     setState(() {
//                       allowMultipleSelection = value;
//                       if (!allowMultipleSelection) {
//                         final currentYear = DateTime.now().year;
//                         final currentMonth = DateTime.now().month;
//                         ref.read(filtersPlansProvider.notifier).clearYears();
//                         ref.read(filtersPlansProvider.notifier).clearMonths();
//                         ref
//                             .read(filtersPlansProvider.notifier)
//                             .setYear(currentYear);
//                         ref
//                             .read(filtersPlansProvider.notifier)
//                             .setMonth(currentMonth);
//                       }
//                     });
//                     _applyFilters(ref);
//                   },
//                 ),
//                 const Spacer(),
//                 DropdownButton<String>(
//                   style: AppTextStyles.interMedium,
//                   dropdownColor: AppColors.dark75,
//                   value: _selectedOrdering,
//                   items: [
//                     DropdownMenuItem(
//                         value: 'amount_asc', child: Text('Kwota rosnąco'.tr)),
//                     DropdownMenuItem(
//                         value: 'amount_desc', child: Text('Kwota malejąco'.tr)),
//                     DropdownMenuItem(
//                         value: 'date_create_asc',
//                         child: Text('Od najnowszego'.tr)),
//                     DropdownMenuItem(
//                         value: 'date_create_desc',
//                         child: Text('Od najstarszego'.tr)),
//                   ],
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedOrdering = value ?? 'amount_asc';
//                     });
//                     _applyFilters(ref);
//                   },
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     ref.read(filtersPlansProvider.notifier).clearFilters();
//                     _applyFilters(ref);
//                   },
//                   child: Text('Wyczyść filtry'.tr,
//                       style: AppTextStyles.interMedium),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _monthName(int month) {
//     final monthNames = [
//       'Styczeń'.tr,
//       'Luty'.tr,
//       'Marzec'.tr,
//       'Kwiecień'.tr,
//       'Maj'.tr,
//       'Czerwiec'.tr,
//       'Lipiec'.tr,
//       'Sierpień'.tr,
//       'Wrzesień'.tr,
//       'Październik'.tr,
//       'Listopad'.tr,
//       'Grudzień'.tr,
//     ];
//     return monthNames[month - 1];
//   }
//
//   void _applyFilters(WidgetRef ref) {
//     final filters = ref.read(filtersPlansProvider);
//
//     if (filters.selectedList == 'Revenue') {
//       ref.read(crmRevenueProvider.notifier).fetchRevenue(
//             years: filters.years.isNotEmpty ? filters.years : null,
//             months: filters.months.isNotEmpty ? filters.months : null,
//             ordering: _selectedOrdering,
//           );
//     } else if (filters.selectedList == 'Expenses') {
//       ref.read(expensesPlanProvider.notifier).fetchExpensesPlans(
//             years: filters.years.isNotEmpty ? filters.years : null,
//             months: filters.months.isNotEmpty ? filters.months : null,
//             ordering: _selectedOrdering,
//           );
//     }
//   }
// }
