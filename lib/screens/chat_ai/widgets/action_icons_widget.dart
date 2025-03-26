import 'package:flutter/material.dart';

class ActionIcons extends StatelessWidget {
  const ActionIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 18.0, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.thumb_up_alt_outlined,
            color: Colors.grey,
            size: 20,
          ),
          SizedBox(width: 8),
          Icon(
            Icons.reply,
            color: Colors.grey,
            size: 20,
          ),
          SizedBox(width: 8),
          Icon(
            Icons.more_vert,
            color: Colors.grey,
            size: 20,
          ),
        ],
      ),
    );
  }
}
