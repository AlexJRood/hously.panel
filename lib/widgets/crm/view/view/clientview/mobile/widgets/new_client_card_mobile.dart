import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class NewClientCardMobile extends ConsumerWidget {
  final int id;
  final VoidCallback onTap;
  final String avatar;
  final String name;
  final String lastName;
  final String email;
  final String phoneNumber;

  const NewClientCardMobile({
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
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 15),
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(avatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: theme.whitewhiteblack.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Spacer(),
            const SizedBox(
              width: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                '$name $lastName',
                style: TextStyle(
                  color: theme.whitewhiteblack,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8), // Small space between name and icon
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              icon: Icon(
                Icons.mode_edit_outline_outlined,
                size: 18,
                color: theme.whitewhiteblack,
              ),
            ),
            const Spacer()
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mail_outline,
              color: theme.whitewhiteblack.withOpacity(0.5),
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              email,
              style: TextStyle(
                color: theme.whitewhiteblack.withOpacity(0.5),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_outlined,
              color: theme.whitewhiteblack.withOpacity(0.5),
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              phoneNumber,
              style: TextStyle(
                color: theme.whitewhiteblack.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
