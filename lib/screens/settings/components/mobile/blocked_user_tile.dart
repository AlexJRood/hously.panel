import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class BlockedUserTileMobile extends ConsumerWidget {
  final String userName;
  final String email;
  final String avatarUrl;
  final VoidCallback onUnblock;

  const BlockedUserTileMobile({
    Key? key,
    required this.userName,
    required this.email,
    required this.avatarUrl,
    required this.onUnblock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    return Container(
      color: Colors.transparent, // Example dark background color
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(8.0), // adjust corner radius as needed
            child: Image.asset(
              avatarUrl,
              width: 48.0, // match your desired size
              height: 48.0, // match your desired size
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12.0),
          // Name and email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: theme.mobileTextcolor,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: theme.mobileTextcolor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // Unblock button
          OutlinedButton(
            onPressed: onUnblock,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: theme.mobileTextcolor.withOpacity(0.7)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child:  Text(
              'Unblock',
              style: TextStyle(color: theme.mobileTextcolor),
            ),
          ),
        ],
      ),
    );
  }
}
