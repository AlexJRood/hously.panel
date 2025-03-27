import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/modules/todo/data/default_stories_date.dart';
import 'package:hously_flutter/modules/todo/apis_model/tasks_model.dart';
import 'package:hously_flutter/modules/todo/view/model/task_model.dart';
import 'package:hously_flutter/api_services/api_services.dart';

import 'package:hously_flutter/modules/todo/apis_model/board_progress_model.dart';
import 'package:hously_flutter/modules/todo/board/provider/board_details_provider.dart';

final taskManagementProvider =
StateNotifierProvider<TaskManagementNotifier, List<ProjectProgresses>>((ref) {
  return TaskManagementNotifier(ref);
});

class TaskManagementNotifier extends StateNotifier<List<ProjectProgresses>> {
  TaskManagementNotifier(dynamic ref) : super([]) {
    fetchStories(ref);
  }

  onItemReorder(
      int oldItemIndex,
      int oldListIndex,
      int newItemIndex,
      int newListIndex,
      List<ProjectProgresses> storiesList,
      WidgetRef ref,
      ) {
    print('younis: onItemReorder');
    final updatedStories = List<ProjectProgresses>.from(storiesList);
    var movedItem =
    updatedStories[oldListIndex].tasks?.removeAt(oldItemIndex);
    movedItem = movedItem?.copyWith(priority: updatedStories[newListIndex].name);

    final updatedTargetChildren =
    List<Tasks>.from(updatedStories[newListIndex].tasks!)
      ..insert(newItemIndex, movedItem!);
    updatedStories[newListIndex] =
        updatedStories[newListIndex].copyWith(tasks: updatedTargetChildren);

    if (oldListIndex != newListIndex) {
      final updatedSourceChildren =
      List<Tasks>.from(updatedStories[oldListIndex].tasks!);
      updatedStories[oldListIndex] = updatedStories[oldListIndex]
          .copyWith(tasks: updatedSourceChildren);
    }

    ref.read(taskManagementProvider.notifier).updateStories(updatedStories);
  }

  onListReorder(int oldListIndex, int newListIndex,
      List<ProjectProgresses> storiesList, WidgetRef ref) {
    print('younis: onListReorder');
    if (newListIndex != storiesList.length) {
      final updatedStories = List<ProjectProgresses>.from(storiesList);
      var movedList = updatedStories.removeAt(oldListIndex);
      updatedStories.insert(newListIndex, movedList);

      ref.read(taskManagementProvider.notifier).updateStories(updatedStories);
    }
  }

  List<Tasks> tasksList = [];
  List<ProjectProgresses> storiesList = [];
  // int get lastTaskId => tasksList.isNotEmpty ? tasksList.last.id : 0;
  int get lastTaskId {
    if (state.isEmpty) return 0;
    return state
        .expand((story) => story.tasks!)
        .map((task) => task.id)
        .fold<int>(0, (maxId, id) => id! > maxId ? id : maxId);
  }


  Future<List<ProjectProgresses>> fetchStories(dynamic ref) async {
    print('Fetching stories...');

    // Initialize with default stories
    List<ProjectProgresses> storiesList = [];
    for (final item in defaultStories) {
      storiesList.add(ProjectProgresses.fromJson(item));
    }

    try {
      // Fetch data from API
      final response = await ApiServices.get(ref: ref,URLs.apiTask, hasToken: true);
      print('Response Status Code: ${response?.statusCode}');

      if (response?.statusCode == 200) {
        // Decode response body
        final responseBody = response?.data is Uint8List
            ? utf8.decode(response?.data)
            : response?.data;

        final jsonResponse = json.decode(responseBody);
        final List<dynamic> results = jsonResponse['results'];

        // Map API response to TaskModel
        final tasksList = results.map((taskJson) {
          return TaskModel.fromJson({
            'id': taskJson['id'],
            'name': taskJson['name'],
            'description': taskJson['name'], // Assuming description is same as name
            'is_completed': false, // Default value
            'priority': 'Low', // Default value
            'timestamp': taskJson['timestamp'],
            'creator': taskJson['user']?['id'] ?? 0,
            'progress': 0, // Default value
            'assigned_to_user': 0, // Default value
            'status': 'Todo', // Default value
          });
        }).toList();

        // Extract unique task names
        final taskNames = tasksList.map((task) => task.name).toSet();

        // Group tasks by their names
        for (final taskName in taskNames) {
          final groupedTasks = tasksList.where((task) => task.name == taskName).toList();
          final mapData = {
            'title': taskName, // Use task name as title
            'children': groupedTasks // Add grouped tasks as children
          };

          // Add grouped tasks to storiesList
          storiesList.add(ProjectProgresses.fromJson(mapData));
        }
        return storiesList;
      } else {
        print('Failed to fetch stories. Status Code: ${response?.statusCode}');
        print('Response Body: ${response?.data}');
        return storiesList;
      }
    } catch (error) {
      print('Error fetching stories: $error');
      return storiesList;
    }
  }




  void updateStories(List<ProjectProgresses> updatedStories) {
    print('younis: updateStories');

    state = updatedStories;
  }

  void addStory(String title) {
    print('younis: addStory');

    final newStory = ProjectProgresses(name: title,tasks: []);
    if (state.every((story) => story.name != title)) {
      state = [...state, newStory];
    }
  }

  void addTaskToStory(int storyIndex, String taskName) {
    print('younis: addTaskToStory');

    final updatedStories = List<ProjectProgresses>.from(state);

    if (storyIndex < updatedStories.length) {
      final story = updatedStories[storyIndex];
      final newTask = Tasks(
          id: lastTaskId + 1,
          name: taskName,
          timestamp: DateTime.now().toString(),
          description: '',
          isCompleted: false,
          priority: 'L',
          assignedToUser: 2);
      final updatedTasks = List<Tasks>.from(story.tasks!)..add(newTask);

      updatedStories[storyIndex] = story.copyWith(tasks: updatedTasks);
      updateStories(updatedStories);
    }
  }
}

final showAddListProvider = StateProvider<bool>((ref) => false);
final showAddTaskProvider = StateProvider<List<bool>>((ref) {
  final storiesList =
      ref.watch(boardDetailsManagementProvider).boardDetails; // Watch the stories list
  return List.generate(storiesList.projectProgresses!.length,
          (_) => false); // Initialize showAddTask for each story
});