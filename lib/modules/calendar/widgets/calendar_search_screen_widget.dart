import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/routing/navigation_service.dart';

class CalendarSearchScreenWidget extends ConsumerWidget {
  const CalendarSearchScreenWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dummy Meeting Data
    final List<Map<String, dynamic>> dummyMeetings = [
      {"date": "Mar\n 11", "isSelected": true, "title": "Meeting with Alex", "time": "17:00 - 17:15"},
      {"date": "Mar\n 12", "isSelected": false, "title": "Meeting with Alex", "time": "17:00 - 17:15"},
      {"date": "Mar\n 13", "isSelected": false, "title": "Meeting with Alex", "time": "17:00 - 17:15"},
      {"date": "Mar\n 14", "isSelected": false, "title": "Meeting with Alex", "time": "17:00 - 17:15"},
      {"date": "Mar\n 15", "isSelected": false, "title": "Meeting with Alex", "time": "17:00 - 17:15"},
      {"date": "Mar\n 16", "isSelected": false, "title": "Meeting with Alex", "time": "17:00 - 17:15"},
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 32, 32, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            ref.read(navigationService).beamPop();
            print('younissss');
          },
        ),
        title: const Text(
          "Meeting",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: dummyMeetings.length,
        itemBuilder: (context, index) {
          final meeting = dummyMeetings[index];
          final bool isSelected = meeting["isSelected"] ?? false;

          return Row(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Date Label (With Blue Highlight)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    // Circle Highlight for Selected Date
                    if (isSelected)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(50, 80, 120, 1),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          meeting["date"].split(" ")[1], // Extract Day Number
                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      )
                    else
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Text(
                          meeting["date"],
                          style: const TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ),
                  ],
                ),
              ),

              // Meeting Card
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(33, 32, 32, 1),
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      // Meeting Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              meeting["title"],
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              meeting["time"],
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      // Profile Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          "assets/images/default_avatar.webp", // Dummy Image
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
