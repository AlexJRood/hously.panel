import 'package:flutter/material.dart';

class TaskCreationListViewWidget extends StatelessWidget {
  const TaskCreationListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          height: 108,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Color.fromRGBO(41, 41, 41, 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(87, 148, 221, 0.1),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: const Text(
                          'Pending',
                          style: TextStyle(
                              color: Color.fromRGBO(161, 236, 230, 1)),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(87, 148, 221, 0.1),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: const Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Color.fromRGBO(200, 200, 200, 1),
                              size: 15,
                            ),
                            Text(
                              'Jan 10,2025',
                              style: TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.more_vert,
                    color: Color.fromRGBO(200, 200, 200, 1),
                    size: 15,
                  ),
                ],
              ),
              const Text(
                'Sending the keys or property access codes to the buyer.',
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const Text(
                'Comment...',
                style: TextStyle(
                    color: Color.fromRGBO(145, 145, 145, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        );
      },
    );
  }
}
