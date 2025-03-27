import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/api_services/api_services.dart';

import '../../apis_model/get_user_board_model.dart';

final boardManagementProvider =
StateNotifierProvider<BoardManagementNotifier, BoardModel>((ref) {
  return BoardManagementNotifier();
});

class BoardManagementNotifier extends StateNotifier<BoardModel> {
  BoardManagementNotifier() : super(boardModelDefault);

  Future<void> fetchBoards(dynamic ref) async {
    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.apiTask,
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        print('Boards fetched correctly');
        final String decodedResponse = utf8.decode(response.data);
        final Map<String, dynamic> decodedData = jsonDecode(decodedResponse);


        // Parse and assign the state
        state = BoardModel.fromJson(decodedData);
        print('Parsed BoardModel: ${state.results?.last.name}');
      }
    } catch (e) {
      print('Error fetching boards: $e');
    }
  }
}

final boardIdProvider = StateProvider<int>((ref) => 1);