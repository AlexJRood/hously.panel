// providers/api_servises_expenses.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/expenses_plan_model.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/filter_plans.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'dart:convert';

final expensesPlanProvider = StateNotifierProvider<ExpensesPlanNotifier,
    AsyncValue<List<ExpensesPlanModel>>>((ref) {
  return ExpensesPlanNotifier();
});

class ExpensesPlanNotifier
    extends StateNotifier<AsyncValue<List<ExpensesPlanModel>>> {
  ExpensesPlanNotifier() : super(const AsyncValue.loading()) {
    fetchExpensesPlans();
  }

  Future<void> fetchExpensesPlans(
      {List<int>? years, List<int>? months, String? ordering,dynamic ref}) async {
    try {
      final now = DateTime.now();
      // Użyj bieżącego roku, jeśli `years` jest puste lub null
      final effectiveYears =
          (years == null || years.isEmpty) ? [now.year] : years;
      // Użyj bieżącego miesiąca, jeśli `months` jest puste lub null
      final effectiveMonths =
          (months == null || months.isEmpty) ? [now.month] : months;
      final queryParams = {
        'year': effectiveYears.join(','),
        'month': effectiveMonths.join(','),
        'ordering': ordering ?? 'amount',
      };
      final response = await ApiServices.get(
        ref: ref,
        URLs.expensesFinancialPlans,
        hasToken: true,
        queryParameters: queryParams,
      );

      if (response == null) {
        state =
            AsyncValue.error(Exception('Invalid request'), StackTrace.current);
        return;
      }

      final decodedDatabody = utf8.decode(response.data);
      final decodeData = json.decode(decodedDatabody) as List;
      final plans = decodeData.map((plan) => ExpensesPlanModel.fromJson(plan)).toList();

      state = AsyncValue.data(plans);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createExpensePlan(ExpensesPlanModel newPlan) async {
    try {
      final response = await ApiServices.post(
        URLs.expensesFinancialPlans,
        hasToken: true,
        data: {
          'amount': newPlan.amount,
          'currency': newPlan.currency,
          'status': newPlan.status,
          'date_create': newPlan.dateCreate,
          'year': newPlan.year,
          'month': newPlan.month,
        },
      );

      if (response == null) {
        throw Exception('Token not found');
      }
      if (response.statusCode == 201) {
        fetchExpensesPlans();
      } else {
        throw Exception('Failed to create plan');
      }
    } catch (error) {
      throw Exception('Failed to create expense plan: $error');
    }
  }

  Future<void> updateExpensePlan(ExpensesPlanModel updatedPlan) async {
    try {
      final response = await ApiServices.put(
        URLs.singleExpensesFinancialPlans('${updatedPlan.id}'),
        hasToken: true,
        data: {
          'amount': updatedPlan.amount,
          'currency': updatedPlan.currency,
          'status': updatedPlan.status,
          'year': updatedPlan.year,
          'month': updatedPlan.month,
        },
      );

      if (response == null) return;

      if (response.statusCode == 200) {
        fetchExpensesPlans();
      } else {
        throw Exception('Failed to update plan');
      }
    } catch (error) {
      throw Exception('Failed to update expense plan: $error');
    }
  }

  Future<void> deleteExpensePlan(int planId) async {
    try {
      final response = await ApiServices.delete(
        URLs.singleExpensesFinancialPlans('$planId'),
        hasToken: true,
      );

      if (response == null) return;
      if (response.statusCode == 204) {
        fetchExpensesPlans();
      } else {
        throw Exception('Failed to delete plan');
      }
    } catch (error) {
      throw Exception('Failed to delete expense plan: $error');
    }
  }

  Future<void> addPlanToExpense(int planId) async {
    try {
      final response = await ApiServices.post(
        URLs.addPlanExpenseFinancialPlans('$planId'),
        hasToken: true,
      );

      if (response == null) return;
      if (response.statusCode == 200) {
        // Z powodzeniem dodano plan do wydatku
      } else {
        throw Exception('Failed to add plan to expense');
      }
    } catch (error) {
      throw Exception('Failed to add plan to expense: $error');
    }
  }

  Future<void> togglePaymentStatusForPlans(List<int> planIds) async {
    try {
      final response = await ApiServices.post(
        URLs.payedStatusExpensesFinancialPlans,
        data: {'plan_ids': planIds},
        hasToken: true,
      );

      if (response == null) return;
      if (response.statusCode == 200) {
        final filters = state.value != null ? _currentFilters() : null;
        // Refresh the list with the current filters
        fetchExpensesPlans(
          years: filters?.years,
          months: filters?.months,
          ordering: filters?.ordering,
        );
      } else {
        // Handle error
        throw Exception('Failed to update payment status');
      }
    } catch (error) {
      // Handle error
      throw Exception('Error updating payment status: $error');
    }
  }

  Filters? _currentFilters() {
    // This method should retrieve the current filters from the state or wherever they are stored
    // Example placeholder logic, replace with actual filter retrieval logic
    return Filters(
      years: [2024],
      months: [9],
      ordering: 'amount',
    );
  }
}

final availableYearsExpensesPlansProvider = FutureProvider<List<int>>((ref) async {
  final response = await ApiServices.get(
    ref: ref,
    URLs.availableYearsExpensesFinancialPlans, // Endpoint do pobierania dostępnych lat
    hasToken: true,
  );

  if (response == null) return [];
      final decodedDatabody = utf8.decode(response.data);
      final decodeData = json.decode(decodedDatabody) as List;
  return decodeData.map((year) => year as int).toList();
});
