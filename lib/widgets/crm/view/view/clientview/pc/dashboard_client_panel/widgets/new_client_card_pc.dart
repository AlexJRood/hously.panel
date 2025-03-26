import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class NewClientCardPc extends ConsumerWidget {
  final int id;
  final VoidCallback onTap;
  final String avatar;
  final String name;
  final String lastName;
  final String email;
  final String phoneNumber;

  const NewClientCardPc({
    super.key,
    required this.onTap,
    required this.id,
    required this.avatar,
    required this.name,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 1920 * 150;
    itemWidth = max(150.0, min(itemWidth, 90.0));
    double minBaseTextSize = 12;
    double maxBaseTextSize = 16;
    final theme = ref.watch(themeColorsProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: itemWidth,
          height: itemWidth - 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(avatar),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text('$name $lastName',
                style: AppTextStyles.interMedium18.copyWith(
                    fontWeight: FontWeight.bold, color: theme.whitewhiteblack)),
            Row(
              children: [
                Icon(
                  Icons.email_outlined,
                  color: theme.whitewhiteblack,
                  size: 15,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(email,
                    style: AppTextStyles.interLight16.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: theme.whitewhiteblack,
                    )),
                const SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.phone_outlined,
                  color: theme.whitewhiteblack,
                  size: 15,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(phoneNumber,
                    style: AppTextStyles.interLight.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: theme.whitewhiteblack,
                    )),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
