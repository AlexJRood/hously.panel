import 'package:flutter/material.dart';

class AddNoteWidget extends StatelessWidget {
  const AddNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        actions: const [
          Icon(
            Icons.check,
            color: Color.fromRGBO(255, 255, 255, 1),
          )
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          spacing: 20,
          children: [
            Text(
              '31 January 2025 at 13:17',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(200, 200, 200, 0.6),
              ),
            ),
            TextField(
              maxLines: null,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                hintText: 'Write your note here...',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(200, 200, 200, 0.6),
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
