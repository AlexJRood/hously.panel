import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/models/expenses_plan_model.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/api_servises_expenses_plans.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/filter_plans.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:pie_menu/pie_menu.dart';

List<PieAction> pieMenuFinancalPlansExpenses(
    WidgetRef ref, BuildContext context, planId, ExpensesPlanModel plan) {
  return [
    PieAction(
      tooltip:  Text('Usuń'.tr),
      onSelect: () async {
        confirmDeletePlan(context, ref, planId);
      },
      child: const FaIcon(FontAwesomeIcons.trash),
    ),
    PieAction(
      tooltip:  Text('Edytuj'.tr),
      onSelect: () async {
        showEditPlanDialog(context, ref, plan);
      },
      child: const FaIcon(FontAwesomeIcons.filter),
    ),
    PieAction(
      tooltip:  Text('Dodaj do kosztów'.tr),
      onSelect: () async {
        await ref.read(expensesPlanProvider.notifier).addPlanToExpense(planId);
        context.showSnackBarLikeSection('Plan dodany do kosztów'.tr);
      },
      child: const FaIcon(FontAwesomeIcons.plusCircle),
    ),
    PieAction(
      tooltip: plan.isPayed
          ?  Text('Oznacz jako nieopłacone'.tr)
          :  Text('Oznacz jako opłacone'.tr),
      onSelect: () async {
        await ref
            .read(expensesPlanProvider.notifier)
            .togglePaymentStatusForPlans([planId]);
        context.showSnackBarLikeSection(plan.isPayed
            ? 'Oznaczono jako nieopłacone'.tr
              : 'Oznaczono jako opłacone'.tr);
      },
      child: plan.isPayed
          ? const FaIcon(FontAwesomeIcons.timesCircle)
          : const FaIcon(FontAwesomeIcons.checkCircle),
    ),
  ];
}

extension ContextExtension on BuildContext {
  void showSnackBarLikeSection(String message) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

void confirmDeletePlan(BuildContext context, WidgetRef ref, int planId) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this plan?'),
        actions: [
          TextButton(
            onPressed: () => ref.read(navigationService).beamPop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(expensesPlanProvider.notifier).deleteExpensePlan(planId);
              ref.read(navigationService).beamPop();
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

void showEditPlanDialog(
    BuildContext context, WidgetRef ref, ExpensesPlanModel plan) {
  showDialog(
    context: context,
    builder: (context) {
      final formKeyFunctions = GlobalKey<FormState>();
      double amount = plan.amount;
      String currency = plan.currency;
      String status = plan.status;
      int year = plan.year;
      int month = plan.month;

      return AlertDialog(
        title: const Text('Edit Financial Plan'),
        content: Form(
          key: formKeyFunctions,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                initialValue: amount.toString(),
                onSaved: (value) {
                  amount = double.tryParse(value ?? '0') ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Currency'),
                initialValue: currency,
                onSaved: (value) {
                  currency = value ?? 'USD';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status'),
                initialValue: status,
                onSaved: (value) {
                  status = value ?? 'Pending';
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Year'),
                initialValue: year.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  year = int.tryParse(value ?? year.toString()) ?? year;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Month'),
                initialValue: month.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  month = int.tryParse(value ?? month.toString()) ?? month;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(navigationService).beamPop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKeyFunctions.currentState?.validate() ?? false) {
                formKeyFunctions.currentState?.save();
                final updatedPlan = ExpensesPlanModel(
                  id: plan.id,
                  amount: amount,
                  currency: currency,
                  status: status,
                  dateCreate: plan.dateCreate,
                  year: year,
                  month: month,
                );
                ref
                    .read(expensesPlanProvider.notifier)
                    .updateExpensePlan(updatedPlan);
                ref.read(navigationService).beamPop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

void confirmDeleteMultiplePlans(
    BuildContext context, WidgetRef ref, Set<int> selectedPlans) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete these plans?'),
        actions: [
          TextButton(
            onPressed: () => ref.read(navigationService).beamPop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              for (var planId in selectedPlans) {
                ref
                    .read(expensesPlanProvider.notifier)
                    .deleteExpensePlan(planId);
              }
              ref.read(navigationService).beamPop();
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

void addMultiplePlansToExpenses(
    BuildContext context, WidgetRef ref, Set<int> selectedPlans) {
  for (var planId in selectedPlans) {
    // Here you would call your existing function to add plan to expense.
    ref.read(expensesPlanProvider.notifier).addPlanToExpense(planId);
  }
  context.showSnackBarLikeSection('Plans added to expenses.');
}

void togglePaymentStatusForSelectedPlans(
    BuildContext context, WidgetRef ref, Set<int> selectedPlans) {
  final filters = ref.read(filtersPlansProvider); // Pobierz aktualne filtry
  ref
      .read(expensesPlanProvider.notifier)
      .togglePaymentStatusForPlans(selectedPlans.toList())
      .then((_) {
    context.showSnackBarLikeSection('Payment status updated.');
    // Odśwież listę z aktualnymi filtrami
    ref.read(expensesPlanProvider.notifier).fetchExpensesPlans(
          years: filters.years.isNotEmpty ? filters.years : null,
          months: filters.months.isNotEmpty ? filters.months : null,
          ordering: filters.ordering,
        );
  }).catchError((error) {
    context.showSnackBarLikeSection('Error updating payment status.');
  });
}
