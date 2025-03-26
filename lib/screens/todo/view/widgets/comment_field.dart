import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/screens/todo/provider/todo_provider.dart';

class CommentField extends ConsumerStatefulWidget {
  final String taskId;
  const CommentField({super.key,required this.taskId});

  @override
  ConsumerState<CommentField> createState() => _CommentFieldState();
}

class _CommentFieldState extends ConsumerState<CommentField> {

  @override
  void initState() {
    super.initState();
  }
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.grey,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Add a comment...',
                border: InputBorder.none,
                isDense: true,
              ),
              maxLines: null,
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            if (_controller.value.text.trim().isEmpty) {
              Get.snackbar('Error', 'Comment cannot be empty!');
              return;
            }
            try {
              ref.read(commentsProvider.notifier).addComment(widget.taskId, _controller.text, 'Younis',ref).whenComplete(() {
                ref.read(commentsProvider.notifier).fetchComments(widget.taskId,ref);
              },);
              _controller.clear();

              Get.snackbar('Success', 'Comment added successfully!');
            } catch (e) {
              debugPrint('Error adding comment: $e');
              Get.snackbar('Error', 'Unable to add comment. Please try again.');
            }
          },
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}