import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigationHistoryProvider = StateNotifierProvider<NavigationHistoryNotifier, List<String>>((ref) {
  return NavigationHistoryNotifier();
});

class NavigationHistoryNotifier extends StateNotifier<List<String>> {
  NavigationHistoryNotifier() : super([]) {
    loadHistoryFromLocalStorage();
  }

  Future<void> loadHistoryFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getString('navigationHistory');
    if (historyJson != null) {
      state = List<String>.from(json.decode(historyJson));
    }
  }

  void removeSpecificPages(List<String> pagesToRemove) {
    state = state.where((page) => !pagesToRemove.contains(page)).toList();
    saveHistoryToLocalStorage();
  }

  void removeLastPage() {
    if (state.isNotEmpty) {
      state = state.sublist(0, state.length - 1);
    }
    saveHistoryToLocalStorage();
  }

  void addPage(String page) {
    state = [...state, page];
    saveHistoryToLocalStorage();
  }

  void saveHistoryToLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('navigationHistory', json.encode(state));
  }

  String get lastPage => state.isNotEmpty ? state.last : Routes.homepage;
}


