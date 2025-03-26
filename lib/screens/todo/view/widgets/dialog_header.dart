import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/todo/apis_model/tasks_model.dart';
import 'package:hously_flutter/screens/todo/view/model/task_model.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

class DialogHeader extends ConsumerWidget {
  final Tasks task;

  const DialogHeader({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.table_rows_rounded,
            color: AppColors.primaryColor.withOpacity(0.8),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.name!,
              style: AppTextStyles.interMedium22.copyWith(
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor.withOpacity(0.95),
                height: 0,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'in list: ',
                    style: AppTextStyles.interSemiBold14.copyWith(
                      color: AppColors.dark50,
                    ),
                  ),
                  TextSpan(
                    text: task.priority,
                    style: AppTextStyles.interSemiBold14.copyWith(
                      color: AppColors.dark50,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle tap action here
                      },
                  ),
                ],
              ),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const Spacer(),
       const SizedBox()
      ],
    );
  }
}