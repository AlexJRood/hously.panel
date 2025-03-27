import 'package:flutter/material.dart';

class DeleteEventCardWidget extends StatelessWidget {
  const DeleteEventCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 161,
        width: 550,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(50, 50, 50, 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Delete this event?',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  Icons.close,
                  color: Color.fromRGBO(200, 200, 200, 1),
                  size: 20,
                )
              ],
            ),
            const Text(
              'This removes all recurrences of this event from your calendar.',
              style: TextStyle(
                  color: Color.fromRGBO(200, 200, 200, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    Container(
                      width: 65,
                      height: 32,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 32,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(200, 200, 200, 1),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: const Center(
                        child: Text(
                          'Delete the event',
                          style: TextStyle(
                              color: Color.fromRGBO(35, 35, 35, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
