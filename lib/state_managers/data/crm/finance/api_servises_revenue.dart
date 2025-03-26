import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/models/revenue_plan_model.dart';
import 'package:hously_flutter/state_managers/data/crm/finance/filter_plans.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'dart:convert';


final revenuePlanProvider = StateNotifierProvider<RevenuePlanNotifier,
    AsyncValue<List<RevenuePlanModel>>>((ref) {
  return RevenuePlanNotifier();
});

class RevenuePlanNotifier
    extends StateNotifier<AsyncValue<List<RevenuePlanModel>>> {
  RevenuePlanNotifier() : super(const AsyncValue.loading()) {
    fetchRevenuePlans();
  }

  Future<void> fetchRevenuePlans(
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
        URLs.revenueFinancialPlans,
        queryParameters: queryParams,
        hasToken: true,
      );

      if (response == null) {
        const AsyncValue.data([]);

        return;
      }

      final decodedDatabody = utf8.decode(response.data);
      final decodeData = json.decode(decodedDatabody) as List;
      final plans = decodeData.map((plan) => RevenuePlanModel.fromJson(plan)).toList();

      state = AsyncValue.data(plans);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> createRevenuePlan(RevenuePlanModel newPlan) async {
    try {
      final response = await ApiServices.post(
        URLs.revenueFinancialPlans,
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
      if (response == null) return;

      if (response.statusCode == 201) {
        fetchRevenuePlans();
      } else {
        throw Exception('Failed to create plan');
      }
    } catch (error) {
      throw Exception('Failed to create Revenue plan: $error');
    }
  }

  Future<void> updateRevenuePlan(RevenuePlanModel updatedPlan) async {
    try {
      final response = await ApiServices.put(
        URLs.singleRevenueFinancialPlans('${updatedPlan.id}'),
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
        fetchRevenuePlans();
      } else {
        throw Exception('Failed to update plan');
      }
    } catch (error) {
      throw Exception('Failed to update Revenue plan: $error');
    }
  }

  Future<void> deleteRevenuePlan(int planId) async {
    try {
      final response = await ApiServices.delete(
        URLs.singleRevenueFinancialPlans('$planId'),
        hasToken: true,
      );
      if (response == null) return;

      if (response.statusCode == 204) {
        fetchRevenuePlans();
      } else {
        throw Exception('Failed to delete plan');
      }
    } catch (error) {
      throw Exception('Failed to delete Revenue plan: $error');
    }
  }

  Future<void> addPlanToRevenue(int planId) async {
    try {
      final response = await ApiServices.post(
        URLs.addPlanRevenueFinancialPlans('$planId'),
        hasToken: true,
      );
      if (response == null) return;

      if (response.statusCode == 200) {
        // Z powodzeniem dodano plan do wydatku
      } else {
        throw Exception('Failed to add plan to Revenue');
      }
    } catch (error) {
      throw Exception('Failed to add plan to Revenue: $error');
    }
  }

  Future<void> togglePaymentStatusForPlans(List<int> planIds) async {
    try {
      final response = await ApiServices.post(
        URLs.payedStatusRevenueFinancialPlans,
        data: {'plan_ids': planIds},
        hasToken: true,
      );
      if (response == null) return;

      if (response.statusCode == 200) {
        final filters = state.value != null ? _currentFilters() : null;
        // Refresh the list with the current filters
        fetchRevenuePlans(
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

final availableYearsRevenueProvider = FutureProvider<List<int>>((ref) async {
  final response = await ApiServices.get(
    ref:ref,
    URLs.availableYearsRevenueFinancialPlans, // Endpoint do pobierania dostępnych lat
    hasToken: true,
  );
  if (response == null) return [];
      final decodedExpensesBody = utf8.decode(response.data);
      final decodeExpenses = json.decode(decodedExpensesBody) as List;

  return (decodeExpenses as List).map((year) => year as int).toList();
});
