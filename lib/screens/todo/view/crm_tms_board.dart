import 'dart:developer' as developer;
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/todo/view/drubale_column.dart';
import 'package:hously_flutter/screens/todo/view/model/task_model.dart';
import 'package:hously_flutter/state_managers/data/crm/task_management/task_management_provider.dart';

import '../board/provider/board_details_provider.dart';
import '../board/provider/board_provider.dart';
import '../provider/todo_provider.dart';

class CrmToDoBoard extends ConsumerStatefulWidget {
  const CrmToDoBoard({super.key});

  @override
  ConsumerState<CrmToDoBoard> createState() => _CrmToDoBoardState();
}

class _CrmToDoBoardState extends ConsumerState<CrmToDoBoard> {
  final TextEditingController storyNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref
          .read(boardDetailsManagementProvider.notifier)
          .fetchBoardDetails(ref.watch(boardIdProvider).toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final showAddList = ref.watch(showAddListProvider);
    final storiesList = ref.watch(boardDetailsManagementProvider).boardDetails;
    final boardState = ref.watch(taskProvider);
    if (storiesList.name!.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return DragAndDropLists(
      children:
          List.generate(storiesList.projectProgresses!.length + 1, (index) {
        if (index == storiesList.projectProgresses?.length) {
          if (showAddList) {
            return DragAndDropList(
              canDrag: false,
              children: [
                DragAndDropItem(
                  canDrag: false,
                  child: Container(
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
                          controller: storyNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter List Name',
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
                                  backgroundColor:
                                      AppColors.backgroundgradient2,
                                  foregroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                onPressed: () async {
                                  try {
                                    if (storyNameController.text.isNotEmpty) {
                                      ref
                                          .read(taskManagementProvider.notifier)
                                          .addStory(storyNameController.text);
                                      await ref
                                          .read(taskProvider.notifier)
                                          .addProgressBar(
                                              ref
                                                  .watch(boardIdProvider)
                                                  .toString(),
                                              storyNameController.text)
                                          .whenComplete(
                                        () {
                                          ref
                                              .read(boardManagementProvider
                                                  .notifier)
                                              .fetchBoards(ref);
                                          ref
                                              .read(
                                                  boardDetailsManagementProvider
                                                      .notifier)
                                              .fetchBoardDetails(ref
                                                  .watch(boardIdProvider)
                                                  .toString());
                                        },
                                      );
                                      ref
                                          .read(showAddListProvider.notifier)
                                          .state = false;

                                      print('new task added');
                                    }
                                  } catch (e) {
                                    developer.log('adding story error is: $e');
                                  }
                                  storyNameController.clear();
                                },
                                child: boardState == TaskState.loading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text('Add to List')),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () {
                                ref.read(showAddListProvider.notifier).state =
                                    false;
                                storyNameController.clear();
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return DragAndDropList(
            canDrag: false,
            children: [
              DragAndDropItem(
                canDrag: false,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: CrmGradients.adGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    color: AppColors.light,
                    onPressed: () {
                      ref.read(showAddListProvider.notifier).state = true;
                    },
                  ),
                ),
              ),
            ],
          );
        }

        return DraggableWidget().draggableWidget(
            story: storiesList.projectProgresses![index],
            storyIndex: index,
            context: context,
            projectId: ref.watch(boardIdProvider).toString(),
            ref: ref);
      }),
      onItemAdd: (newItem, listIndex, newItemIndex) {
        print(
            'younis new Item: $newItem  listIndex: $listIndex newItemIndex: $newItemIndex');
      },
      onItemReorder: (oldItemIndex, oldListIndex, newItemIndex, newListIndex) {
        final boardDetails = ref.watch(boardDetailsStateProvider);

        // Get the progress ID of the new list
        final progressId = boardDetails.projectProgresses
            ?.asMap()
            .entries
            .firstWhere(
              (entry) => entry.key == newListIndex,
            )
            .value
            .id;

        // Get the task ID of the task being reordered
        final taskId = boardDetails.projectProgresses
            ?.asMap()
            .entries
            .firstWhere(
              (entry) => entry.key == oldListIndex,
            )
            .value
            .tasks
            ?.asMap()
            .entries
            .firstWhere(
              (taskEntry) => taskEntry.key == oldItemIndex,
            )
            .value
            .id;

        // Handle progress update if the list has changed
        if (oldListIndex != newListIndex &&
            taskId != null &&
            progressId != null) {
          ref
              .read(taskProvider.notifier)
              .reProgressTask(taskId, progressId)
              .whenComplete(() {
            ref
                .read(boardDetailsManagementProvider.notifier)
                .fetchBoardDetails(ref.watch(boardIdProvider).toString());
          });
        }

        // Handle reordering within the same list
        final oldListTasks = boardDetails.projectProgresses
            ?.asMap()
            .entries
            .firstWhere(
              (entry) => entry.key == oldListIndex,
            )
            .value
            .tasks;

        if (oldListTasks != null) {
          ref
              .read(taskProvider.notifier)
              .reOrderTask(oldItemIndex, newItemIndex, oldListTasks)
              .whenComplete(() {
            ref
                .read(boardDetailsManagementProvider.notifier)
                .fetchBoardDetails(ref.watch(boardIdProvider).toString());
          });
        }

        // Debug log for reorder action
        print(
            'onItemReorder:\n  oldItemIndex: $oldItemIndex,\n  oldListIndex: $oldListIndex,\n  newItemIndex: $newItemIndex,\n  newListIndex: $newListIndex');
      },
      onListReorder: (oldListIndex, newListIndex) {
        ref.read(taskManagementProvider.notifier).onListReorder(
            oldListIndex, newListIndex, storiesList.projectProgresses!, ref);
        print(
            'onListReorder:\n oldListIndex ${oldListIndex},\n  newListIndex:  ${newListIndex}');
      },
      axis: Axis.horizontal,
      listWidth: 300,
      listDraggingWidth: 300,
      listPadding: const EdgeInsets.all(10),
    );
  }
}
