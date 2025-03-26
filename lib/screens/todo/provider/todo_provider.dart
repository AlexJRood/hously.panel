import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../const/url.dart';
import '../../../utils/api_services.dart';
import '../apis_model/tasks_model.dart';
import '../board/provider/board_details_provider.dart';

class CommentModel {
  final int id;
  final String user;
  final String title;
  final String comment;
  final String timestamp;

  CommentModel(
      {required this.user,
      required this.title,
      required this.comment,
      required this.timestamp,
      required this.id});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        id: json['id'] as int,
        user: json['user'] as String,
        title: json['title'] as String,
        comment: json['comment'] as String,
        timestamp: json['timestamp'] as String);
  }
}

class CommentsNotifier extends StateNotifier<List<CommentModel>> {
  CommentsNotifier() : super([]);

//fetch comments
  Future<void> fetchComments(String taskId, dynamic ref) async {
    try {
      state = [];
      final response = await ApiServices.get(
        ref: ref,
        URLs.getComments(taskId),
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        print('Comments fetch correctly');
        final String decodedResponse = utf8.decode(response.data);
        final List<dynamic> decodedData = jsonDecode(decodedResponse);

        state = decodedData
            .map((comment) =>
                CommentModel.fromJson(comment as Map<String, dynamic>))
            .toList();
      } else {
        debugPrint('Error: ${response?.statusCode}');
        throw Exception('Failed to fetch comments');
      }
    } catch (e) {
      debugPrint('Error fetching comments: $e');
      Get.snackbar('Error', 'Unable to fetch comments. Please try again.');
    }
  }

  // Add Comment
  Future<void> addComment(
      String taskId, String content, String author, dynamic ref) async {
    try {
      final response = await ApiServices.post(
        URLs.addComment(taskId),
        hasToken: true,
        data: {
          "title": author,
          "comment": content,
        },
      );

      if (response != null && response.statusCode == 201) {
        debugPrint('Comment added successfully');
        // Optionally refresh the comments list
        await fetchComments(taskId, ref);
      } else {
        debugPrint('Error: ${response?.statusCode}');
        throw Exception('Failed to add comment');
      }
    } catch (e) {
      debugPrint('Error adding comment: $e');
      throw e;
    }
  }

  Future<void> deleteComment(int taskId, int commentId) async {
    try {
      final response = await ApiServices.post(
        URLs.deleteComments(taskId.toString(), commentId.toString()),
        hasToken: true,
      );

      if (response != null && response.statusCode == 204) {
        debugPrint('Comment deleted successfully');
      } else {
        debugPrint('Comment delete failed');
      }
    } catch (e) {
      print(e);
    }
  }
}

// Riverpod provider
final commentsProvider =
    StateNotifierProvider<CommentsNotifier, List<CommentModel>>(
  (ref) => CommentsNotifier(),
);

/// Enum to represent the state of task addition
enum TaskState { initial, loading, success, error }

/// StateNotifier to manage the addTask functionality
class TaskNotifier extends StateNotifier<TaskState> {
  TaskNotifier(this.ref) : super(TaskState.initial);
  final Ref ref;

  /// Add Task Method
  Future<void> addTask(
      String taskName, int columnNumber, String projectId) async {
    try {
      // Set state to loading
      state = TaskState.loading;
      final boardDetails = ref.watch(boardDetailsStateProvider);
      final matchingItems = boardDetails.projectProgresses
          ?.asMap()
          .entries
          .where((entry) => entry.key == columnNumber)
          .map((entry) => entry.value)
          .toList();

      // Print the matching items
      print('younis: $columnNumber: ${matchingItems?.last.id}');
      final response = await ApiServices.post(
        URLs.addTask,
        hasToken: true,
        data: {
          "project": projectId,
          "name": taskName,
          "description": "Description for Tasks",
          "priority": "H",
          "meta_fields": {
            "some-field": "attribute",
          },
          "progress": matchingItems?.last.id,
        },
      );

      if (response != null && response.statusCode == 201) {
        debugPrint('Task added successfully');
        // Set state to success
        state = TaskState.success;
      } else {
        debugPrint('Error: ${response?.statusCode}');
        state = TaskState.error;
        throw Exception('Failed to add task');
      }
    } catch (e) {
      debugPrint('Error adding task: $e');
      // Set state to error
      state = TaskState.error;
      throw e;
    }
  }

  Future<void> addProgressBar(String projectId, String name) async {
    try {
      // Set state to loading
      state = TaskState.loading;

      final response = await ApiServices.post(
        URLs.addProgressBar(projectId),
        hasToken: true,
        data: {"project": projectId, "name": name},
      );

      if (response != null && response.statusCode == 201) {
        debugPrint('progressBar added successfully');
        // Set state to success
        state = TaskState.success;
      } else {
        debugPrint('Error: ${response?.statusCode}');
        state = TaskState.error;
        throw Exception('Failed to add progressBar');
      }
    } catch (e) {
      debugPrint('Error adding task: $e');
      // Set state to error
      state = TaskState.error;
    }
  }

  Future<void> deleteProgressBar(String projectId, String progressId) async {
    try {
      final response = await ApiServices.delete(
          URLs.deleteProgressBar(projectId, progressId),
          hasToken: true);

      if (response != null && response.statusCode == 204) {
        print('Progress deleted successfully');
      } else {
        print('Progress deleting failed${response?.statusCode}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> updateProgressBar(
      {required String projectId,
      required String progressId,
      required String name}) async {
    try {
      final response = await ApiServices.put(
          hasToken: true,
          URLs.updateProgressBar(projectId, progressId),
          data: {"name": name});
      if (response != null && response.statusCode == 200) {
        print('Progress updated successfully');
      } else {
        print('Progress update failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> reOrderTask(
    int currentTaskOrdering,
    int newTaskOrdering,
    List<Tasks> tasks, // The current list of tasks
  ) async {
    try {
      state = TaskState.loading;

      if (currentTaskOrdering < 0 || currentTaskOrdering >= tasks.length) {
        throw RangeError(
            'currentTaskOrdering ($currentTaskOrdering) is out of range.');
      }

      if (newTaskOrdering < 0 || newTaskOrdering > tasks.length) {
        throw RangeError('newTaskOrdering ($newTaskOrdering) is out of range.');
      }

      final listIndexes = [];
      final updatedTasks = List<Tasks>.from(tasks);

      // Safely remove and insert the task
      final task = updatedTasks.removeAt(currentTaskOrdering);
      updatedTasks.insert(newTaskOrdering, task);

      for (var i in updatedTasks) {
        listIndexes.add(i.id);
      }

      for (int i = 0; i < updatedTasks.length; i++) {
        final taskToUpdate = updatedTasks[i];

        final response = await ApiServices.post(
          URLs.reOrderTask('${taskToUpdate.projectId}'),
          hasToken: true,
          data: {
            "progress": taskToUpdate.progressId,
            "tasks": listIndexes,
          },
        );

        if (response == null || response.statusCode != 200) {
          debugPrint('Error updating task ordering for ${taskToUpdate.id}');
          throw Exception('Failed to update task ordering');
        }
      }

      debugPrint('All tasks reordered successfully');
      state = TaskState.success;
    } catch (e) {
      debugPrint('Error in reOrderTask: $e');
      state = TaskState.error;
    }
  }

  Future<void> reProgressTask(int taskId, int newProgressId) async {
    state = TaskState.loading;
    try {
      if (taskId <= 0) {
        throw ArgumentError('taskId ($taskId) must be greater than 0.');
      }

      if (newProgressId <= 0) {
        throw ArgumentError(
            'newProgressId ($newProgressId) must be greater than 0.');
      }

      final response = await ApiServices.post(
        URLs.reProgressTask(taskId.toString()),
        hasToken: true,
        data: {
          "progress": newProgressId,
        },
      );

      if (response == null || response.statusCode != 200) {
        debugPrint('Error updating task reProgressing');
        throw Exception('Failed to update task progress');
      }

      debugPrint('Task reProgressed successfully');
      state = TaskState.success;
    } catch (e) {
      debugPrint('Error in reProgressTask: $e');
      state = TaskState.error;
    }
  }
}

/// Provider for the AddTaskNotifier
final taskProvider = StateNotifierProvider<TaskNotifier, TaskState>(
  (ref) => TaskNotifier(ref),
);

final taskFileProvider = StateProvider<Uint8List?>((ref) => null);

class TaskFileNotifier extends StateNotifier<List<Tasks>> {
  TaskFileNotifier(this.ref) : super([]);
  final Ref ref;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Update loading state
  void setLoading(bool value) {
    _isLoading = value;
    ref.notifyListeners(); // Notify listeners to rebuild UI when loading changes
  }

  Future<void> addFileToTask(String taskId) async {
    try {
      setLoading(true); // Start loading
      final image = await pickTaskFile();

      final formData = FormData();
      if (image!.isNotEmpty) {
        formData.files.add(MapEntry(
          'file',
          MultipartFile.fromBytes(image, filename: 'attachment.jpg'),
        ));
      }

      final response = await ApiServices.post(
        URLs.addFileToTask(taskId),
        hasToken: true,
        formData: formData,
      );

      if (response != null && response.statusCode == 200) {
        print('File added successfully to task');
        await fetchTaskFiles(taskId); // Refresh the task files
      } else {
        print('Failed to add file to task');
        print('Response: ${response?.data}');
      }
    } catch (e) {
      print('Error in addFileToTask: ${e.toString()}');
    } finally {
      setLoading(false); // Stop loading
    }
  }

  Future<void> fetchTaskFiles(String taskId) async {
    try {
      final response = await ApiServices.get(URLs.editTask(taskId),
          ref: ref, hasToken: true);

      if (response != null && response.statusCode == 200) {
        final String decodedResponse = utf8.decode(response.data);
        final Map<String, dynamic> decodedData = jsonDecode(decodedResponse);
        final taskDetails = Tasks.fromJson(decodedData);
        state = [taskDetails];
      } else {
        print(
            'Failed to fetch task files. Status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error fetching task files: $e');
    } finally {}
  }

  Future<Uint8List?> pickTaskFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List taskFile = await pickedFile.readAsBytes();
      ref.read(taskFileProvider.notifier).state = taskFile;
      return taskFile;
    }
    return null;
  }
}

final taskDetailsProvider =
    StateNotifierProvider<TaskFileNotifier, List<Tasks>>(
  (ref) => TaskFileNotifier(ref),
);
