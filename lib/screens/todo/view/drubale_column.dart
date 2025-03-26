import 'dart:developer' as developer;
import 'package:drag_and_drop_lists/drag_and_drop_item.dart';
import 'package:drag_and_drop_lists/drag_and_drop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/todo/apis_model/tasks_model.dart';
import 'package:hously_flutter/screens/todo/view/task_pup_up.dart';
import 'package:hously_flutter/state_managers/data/crm/task_management/task_management_provider.dart';
import 'package:provider/provider.dart';

import '../apis_model/board_progress_model.dart';
import '../board/provider/board_details_provider.dart';
import '../board/provider/board_provider.dart';
import '../provider/todo_provider.dart';
import 'model/task_model.dart';

class DraggableWidget {
  draggableWidget(
      {context,
      required ProjectProgresses story,
      required int storyIndex,
      required String projectId,
      required WidgetRef ref}) {
    return DragAndDropList(
      contentsWhenEmpty: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          'No task in this story',
          style: AppTextStyles.interMedium.copyWith(
            color: AppColors.light50,
          ),
        ),
      ),
      decoration: const BoxDecoration(
        color: AppColors.light25,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      header: BuildHeader(
        story.name!,
        ref: ref,
        progressId: story.id!.toString(),
        projectId: story.project.toString(),
        storyIndex: storyIndex,
      ),
      footer: BuildFooter(
        storyIndex,
        projectId: projectId,
      ),
      children: List.generate(story.tasks!.length, growable: false, (index) {
        return DraggableItemWidget()
            .buildItem(context, story.tasks![index], ref);
      }),
    );
  }
}

class BuildHeader extends StatelessWidget {
  const BuildHeader(this.title,
      {super.key,
      required this.ref,
      required this.progressId,
      required this.projectId,
      required this.storyIndex});
  final WidgetRef ref;
  final String title;
  final String projectId;
  final String progressId;
  final int storyIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
        gradient: CrmGradients.loginGradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('  '),
          Text(
            title,
            style: AppTextStyles.interMedium14,
          ),
          GestureDetector(
            onTapDown: (details) {
              _showPopover(context, details);
            },
            child: const Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }

  void _showPopover(BuildContext context, TapDownDetails details) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: [
        const PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.add, color: Colors.grey),
              SizedBox(width: 8),
              Text('Add task'),
            ],
          ),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.grey),
              SizedBox(width: 8),
              Text('Edit progress'),
            ],
          ),
        ),
        const PopupMenuItem<int>(
          value: 3,
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 3) {
        _onDelete();
      } else if (value == 1) {
        _onAddTask();
      } else if (value == 2) {
        _onEditProgress(context);
      }
    });
  }

  void _onEditProgress(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Progress Name'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Enter progress name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref
                    .read(taskProvider.notifier)
                    .updateProgressBar(
                      projectId: projectId,
                      progressId: progressId,
                      name: nameController.text.trim(),
                    )
                    .whenComplete(() {
                  ref
                      .read(boardDetailsManagementProvider.notifier)
                      .fetchBoardDetails(ref.watch(boardIdProvider).toString());
                });
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onAddTask() {
    final currentShowAddTask = ref.watch(showAddTaskProvider);
    currentShowAddTask[storyIndex] = !currentShowAddTask[storyIndex];
    ref.read(showAddTaskProvider.notifier).state =
        List.from(currentShowAddTask);
  }

  void _onDelete() {
    ref
        .read(taskProvider.notifier)
        .deleteProgressBar(projectId, progressId)
        .whenComplete(
      () {
        ref
            .read(boardDetailsManagementProvider.notifier)
            .fetchBoardDetails(ref.watch(boardIdProvider).toString());
      },
    );
  }
}

class BuildFooter extends ConsumerStatefulWidget {
  final int
      storyIndex; // Pass the index of the story where the task will be added
  final String projectId;
  static final TextEditingController taskNameController =
      TextEditingController();

  const BuildFooter(this.storyIndex, {super.key, required this.projectId});

  @override
  ConsumerState<BuildFooter> createState() => _BuildFooterState();
}

class _BuildFooterState extends ConsumerState<BuildFooter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showAddTask = ref.watch(showAddTaskProvider);
    final addTaskState = ref.watch(taskProvider);
    return Center(
      child: Column(
        children: [
          if (!showAddTask[widget.storyIndex])
            IconButton(
              icon: const Icon(Icons.add),
              color: AppColors.light,
              onPressed: () {
                final currentShowAddTask = ref.watch(showAddTaskProvider);
                currentShowAddTask[widget.storyIndex] =
                    !currentShowAddTask[widget.storyIndex];
                ref.read(showAddTaskProvider.notifier).state =
                    List.from(currentShowAddTask);
              },
            ),
          if (showAddTask[widget.storyIndex])
            Container(
              padding: const EdgeInsets.all(10),
              width: 300,
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  TextField(
                    autofocus: true,
                    controller: BuildFooter.taskNameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Task Name',
                      hintStyle: AppTextStyles.interMedium14
                          .copyWith(color: AppColors.dark50),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.backgroundgradient2,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                        onPressed: () {
                          try {
                            if (BuildFooter
                                .taskNameController.text.isNotEmpty) {
                              final taskName =
                                  BuildFooter.taskNameController.text;
                              ref
                                  .read(taskManagementProvider.notifier)
                                  .addTaskToStory(widget.storyIndex, taskName);
                              ref
                                  .read(taskProvider.notifier)
                                  .addTask(BuildFooter.taskNameController.text,
                                      widget.storyIndex, widget.projectId)
                                  .whenComplete(
                                () {
                                  ref
                                      .read(boardDetailsManagementProvider
                                          .notifier)
                                      .fetchBoardDetails(ref
                                          .watch(boardIdProvider)
                                          .toString());
                                },
                              );
                            }
                          } catch (e) {
                            developer.log('Error adding task: $e');
                          }
                          BuildFooter.taskNameController.clear();
                        },
                        child: addTaskState == TaskState.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Add Task"),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          final currentShowAddTask =
                              ref.read(showAddTaskProvider);
                          final updatedShowAddTask =
                              List<bool>.from(currentShowAddTask);
                          updatedShowAddTask[widget.storyIndex] = false;
                          ref.read(showAddTaskProvider.notifier).state =
                              updatedShowAddTask;

                          BuildFooter.taskNameController.clear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class DraggableItemWidget {
  buildItem(BuildContext context, Tasks task, WidgetRef ref) {
    return DragAndDropItem(
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (_) => TaskDetailsPopup(task: task),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
          child: Card(
            elevation: 5,
            child: ListTile(
              title: Text(task.name!),
              trailing: task.priority == 'Accepted'
                  ? const Icon(Icons.check_circle_rounded,
                      color: AppColors.revenueGreen)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
