import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/todo/view/widgets/comment_field.dart';
import 'package:hously_flutter/screens/todo/view/widgets/dialog_header.dart';
import 'package:hously_flutter/screens/todo/view/widgets/quick_access_option.dart';
import 'package:hously_flutter/screens/todo/view/widgets/side_bar_options.dart';
import 'package:hously_flutter/screens/todo/view/widgets/text_button_with_icon.dart';
import '../apis_model/tasks_model.dart';
import '../provider/todo_provider.dart';

class TaskDetailsPopup extends ConsumerStatefulWidget {
  final Tasks task;

  const TaskDetailsPopup({super.key, required this.task});

  @override
  ConsumerState<TaskDetailsPopup> createState() => _TaskDetailsPopupState();
}

class _TaskDetailsPopupState extends ConsumerState<TaskDetailsPopup> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref
          .read(taskDetailsProvider.notifier)
          .fetchTaskFiles(widget.task.id.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final taskDetails = ref.watch(taskDetailsProvider);
    if (taskDetails.isEmpty) {
      return const SizedBox();
    }

    final files = taskDetails.last.files;
    final attachment =
        (files != null && files.isNotEmpty) ? files.last.file : null;

    return Dialog(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: size.width * 0.75,
        padding: const EdgeInsets.all(16),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        child: SingleChildScrollView(
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (attachment != null && attachment.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 2.0, // Border width
                      ),
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          8.0), // Ensure content respects the border radius
                      child: Image.network(
                        attachment,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  const SizedBox(),
                const SizedBox(
                  height: 25,
                ),
                DialogHeader(task: widget.task),
                const SizedBox(height: 25),
                DialogContent(task: widget.task),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                color: Colors.grey,
                icon: const Icon(
                  Icons.close_rounded,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class DialogContent extends ConsumerStatefulWidget {
  final Tasks task;

  const DialogContent({super.key, required this.task});

  @override
  ConsumerState<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends ConsumerState<DialogContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      ref
          .read(commentsProvider.notifier)
          .fetchComments(widget.task.id.toString(), ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(commentsProvider);
    final attachments = ref.watch(taskDetailsProvider).last.files;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 45,
                  ),
                  QuickAccessOption(
                    'Member',
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 3),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.grey.withOpacity(0.95),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.withOpacity(0.3)),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  QuickAccessOption(
                    'Label',
                    TextButtonWithIcon(
                      label: 'Select Label',
                      onTap: () {},
                    ),
                  ),
                  QuickAccessOption(
                    'Due Date',
                    TextButtonWithIcon(
                      label: 'Select Due Date',
                      onTap: () {},
                    ),
                  ),
                  QuickAccessOption(
                    'Priority',
                    TextButtonWithIcon(
                      label: widget.task.priority == "H" ? 'Height' : 'Low',
                      onTap: () {},
                      icon: Icons.flag,
                      iconColor: widget.task.priority == "H"
                          ? Colors.red
                          : Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              BodyFields(
                headerIcon: Icons.text_snippet_outlined,
                action: () {},
                buttonLabel: 'Edit',
                header: const SectionHeader('Description'),
                field: Text(
                  '${widget.task.description}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              if(attachments!.isNotEmpty)
              const SizedBox(height: 40),
              if(attachments.isNotEmpty)
              AttachmentDisplay(ref: ref, taskId: widget.task.id.toString()),
              const SizedBox(height: 40),
              BodyFields(
                headerIcon: Icons.history,
                action: () {},
                buttonLabel: 'Show Details',
                header: const SectionHeader('Activity'),
                field: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Created by: ',
                        style: AppTextStyles.interMedium.copyWith(
                          color: AppColors.primaryColor.withOpacity(0.6),
                        ),
                      ),
                      TextSpan(
                        text: 'Json',
                        style: AppTextStyles.interMedium.copyWith(
                          color: AppColors.primaryColor.withOpacity(0.8),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle tap action here
                          },
                      ),
                      TextSpan(
                        text:
                            '   ${widget.task.timestamp.toString().substring(0, 16)}',
                        style: AppTextStyles.interMedium.copyWith(
                          color: AppColors.primaryColor.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CommentField(
                taskId: widget.task.id.toString(),
              ),
              const SizedBox(height: 20),
              comments.isEmpty
                  ? const Center(
                      child: Text('No comments available.'),
                    )
                  : SizedBox(
                      height: context.height * 0.5,
                      child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          if (index < 0 || index >= comments.length) {
                            return const SizedBox();
                          }
                          final data = comments[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: BodyFields(
                              headerIcon: Icons.account_circle_rounded,
                              header: SectionHeader(data.title,
                                  subTitle: data.timestamp
                                      .toString()
                                      .substring(0, 16)),
                              field: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints:
                                        const BoxConstraints(minWidth: 70),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(4, 4),
                                          blurRadius: 5,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Text(data.comment),
                                  ),
                                  TextButton(
                                    child: const Text('• Delete'),
                                    onPressed: () {
                                      ref
                                          .read(commentsProvider.notifier)
                                          .deleteComment(
                                              widget.task.id!, data.id)
                                          .whenComplete(
                                        () {
                                          ref
                                              .read(commentsProvider.notifier)
                                              .fetchComments(
                                                  widget.task.id.toString(),
                                                  ref);
                                        },
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
            flex: 1,
            child: SidebarOptions(
              taskId: widget.task.id.toString(),
            )),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {this.subTitle, super.key});
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        if (subTitle != null) ...[
          const SizedBox(
            width: 10,
          ),
          Text(
            subTitle!,
            style: AppTextStyles.interLight.copyWith(
              color: AppColors.primaryColor.withOpacity(0.8),
            ),
          ),
        ]
      ],
    );
  }
}

class BodyFields extends StatelessWidget {
  final Widget header;
  final Widget field;
  final VoidCallback? action;
  final IconData? headerIcon;
  final String? buttonLabel;

  const BodyFields({
    super.key,
    required this.header,
    required this.field,
    this.action,
    this.headerIcon,
    this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerIcon != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Icon(
              headerIcon,
              color: AppColors.primaryColor.withOpacity(0.8),
            ),
          )
        else
          const SizedBox(
            width: 40,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                header,
                const SizedBox(
                  width: 10,
                ),
                if (action != null && buttonLabel != null)
                  TextButtonWithIcon(
                      label: buttonLabel!, onTap: action!, verticalPadding: 0),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            field,
          ],
        )
      ],
    );
  }
}

class AttachmentDisplay extends StatelessWidget {
  final WidgetRef ref;
  final String taskId;

  const AttachmentDisplay({super.key, required this.ref, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final attachments = ref.watch(taskDetailsProvider).last.files;
    final isUploading =ref.watch(taskDetailsProvider.notifier).isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyFields(
          headerIcon: Icons.attachment,
          action: ()async {

                  await ref
                      .read(taskDetailsProvider.notifier)
                      .addFileToTask(taskId);
          },
          buttonLabel: isUploading? 'Uploading' : 'Add',
          header: const SectionHeader('Attachments'),
          field: Text(
            attachments!.isNotEmpty
                ? '${attachments.length} attachment(s) available.'
                : 'No attachments available.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          constraints: const BoxConstraints(
            minHeight: 100,
            maxHeight: 300,
          ),
          child: attachments.isNotEmpty
              ? ListView.builder(
                  itemCount: attachments.length,
                  itemBuilder: (context, index) {
                    final file = attachments[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          // Display the file thumbnail or preview
                          if (file.file != null && file.file!.isNotEmpty)
                            Container(
                              width: 200,
                              height: 100,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  file.file!,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                          // Display file details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (file.name != null)
                                  Text(
                                    'File Name: ${file.name}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                Text(
                                  'File ID: ${file.id}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  '${file.timestamp}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No attachments to display.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
        ),
      ],
    );
  }
}
