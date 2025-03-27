import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/todo/data/sidebar_data.dart';
import 'package:image_picker/image_picker.dart';

import '../../provider/todo_provider.dart';
import 'text_button_with_icon.dart';

class SidebarOptions extends ConsumerWidget {
  final String taskId;

  const SidebarOptions({super.key, required this.taskId});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sidebarData.map((item) {
        if (item['type'] == 'header') {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(item['title']!.toString(),
                style: AppTextStyles.interMedium14.copyWith(
                  color: theme.taskHeaderColor,
                )),
          );
        } else {
          return TextButtonWithIcon(
              label: item['title']!.toString(),
              icon: item['icon'] as IconData?,
              onTap: () async {
                if (item['title']!.toString() == 'Attachment') {
                  try {
                    await ref.read(taskDetailsProvider.notifier).addFileToTask(
                              taskId);
                  } catch (e) {
                    print('Error in onTap: ${e.toString()}');
                  }
                }
              });
        }
      }).toList(),
    );
  }


}
