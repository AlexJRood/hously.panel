import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/models/expense_model.dart';
import 'package:hously_flutter/screens/fliper_crm/finance/models/expenses_response_model.dart';
import 'package:hously_flutter/utils/api_services.dart';

class ExpensesNotifier extends StateNotifier<List<Expense>> {
  ExpensesNotifier() : super([]);

  Future<void> fetchExpenses(dynamic ref) async {
    try {
      final response = await ApiServices.get(
        URLs.fetchExpenses,
        ref: ref,
        hasToken: true,
      );
      if (response != null && response.statusCode == 200) {
        final responseString = utf8.decode(response.data);
        final jsonResponse = jsonDecode(responseString);
        final expensesResponse = ExpensesResponse.fromJson(jsonResponse);
        state = expensesResponse.results;
        print('Expenses fetched successfully. Count: ${state.length}');
        for (var expense in state) {
          print(
              'Expense ID: ${expense.id}, Title: ${expense.title}, Amount: ${expense.amount}');
        }
      } else {
        print('Expenses fetch failed. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error fetching expenses: $e');
    }
  }

  Future<void> createExpenses(dynamic ref) async {
    try {
      final data = {
        "title": "Renovation Cost",
        "transaction": 1,
        "amount": 50000.00,
        "date": "2025-02-09"
      };
      final response = await ApiServices.post(URLs.createExpenses,
          hasToken: true, data: data);
      if (response != null && response.statusCode == 201) {
        print('Expense created successfully');
        await fetchExpenses(ref);
      } else {
        print('Expense creation failed. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error creating expense: $e');
    }
  }
}

final expensesProvider = StateNotifierProvider<ExpensesNotifier, List<Expense>>(
  (ref) => ExpensesNotifier(),
);
