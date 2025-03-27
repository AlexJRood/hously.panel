import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/modules/todo/apis_model/tasks_model.dart';
import 'package:hously_flutter/api_services/api_services.dart';

import '../../apis_model/board_details_model.dart';

/// Enum to represent the loading states
enum BoardDetailsState { idle, loading, success, error }

final boardDetailsManagementProvider = StateNotifierProvider<BoardDetailsNotifier, BoardDetailsWrapper>((ref) {
  return BoardDetailsNotifier(ref);
});

/// Wrapper class for state and loading status
class BoardDetailsWrapper {
  final BoardDetailsModel boardDetails;
  final BoardDetailsState state;

  BoardDetailsWrapper({
    required this.boardDetails,
    required this.state,
  });

  BoardDetailsWrapper copyWith({
    BoardDetailsModel? boardDetails,
    BoardDetailsState? state,
  }) {
    return BoardDetailsWrapper(
      boardDetails: boardDetails ?? this.boardDetails,
      state: state ?? this.state,
    );
  }
}

/// Initial state for the wrapper
final BoardDetailsWrapper defaultBoardDetailsWrapper = BoardDetailsWrapper(
  boardDetails: boardDetailsModelDefault,
  state: BoardDetailsState.idle,
);

class BoardDetailsNotifier extends StateNotifier<BoardDetailsWrapper> {
  BoardDetailsNotifier(this.ref) : super(defaultBoardDetailsWrapper);
  final Ref ref;
  Future<void> fetchBoardDetails(String projectId) async {
    try {
      // Set loading state
      state = state.copyWith(state: BoardDetailsState.loading);

      final response = await ApiServices.get(ref:ref,URLs.projectDetails(projectId));
      if (response != null && response.statusCode == 200) {
        final String decodedResponse = utf8.decode(response.data);
        final Map<String, dynamic> decodedData = jsonDecode(decodedResponse);
        final boardDetails = BoardDetailsModel.fromJson(decodedData);

        // Set success state with new data
        state = state.copyWith(
          boardDetails: boardDetails,
          state: BoardDetailsState.success,
        );
        ref.read(boardDetailsStateProvider.notifier).state = boardDetails;
        final tasksDetails = boardDetails.projectProgresses?.map((projectProgress) {
          return projectProgress.tasks;
        }).toList();
        ref.read(tasksDetailsProvider.notifier).state = tasksDetails;
      } else {
        // Set error state
        state = state.copyWith(state: BoardDetailsState.error);
        throw Exception('Failed to fetch board details');
      }
    } catch (e) {
      // Set error state
      state = state.copyWith(state: BoardDetailsState.error);
      print(e);
    }
  }
}


final boardDetailsStateProvider = StateProvider<BoardDetailsModel>((ref) {
  return boardDetailsModelDefault; // Initial default value
});

final tasksDetailsProvider = StateProvider<List<List<Tasks>?>?>((ref) {
  return [[Tasks()]];
},);