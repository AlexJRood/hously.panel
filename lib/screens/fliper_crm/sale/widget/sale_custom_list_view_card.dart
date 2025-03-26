import 'package:flutter/material.dart';

class SaleCustomListViewCard extends StatelessWidget {
  final String name;
  final String email;
  final String title;
  final String date;
  final String description;

  const SaleCustomListViewCard({
    super.key,
    required this.name,
    required this.email,
    required this.title,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 254,
      child: Card(
        color: Colors.grey[900],
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 13),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                            color: Color.fromRGBO(145, 145, 145, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 10),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.more_vert,
                    color: Color.fromRGBO(200, 200, 200, 1),
                    size: 12,
                  ),
                ],
              ),
              // Title and Date
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: Color.fromRGBO(255, 255, 255, 1), width: 3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Color.fromRGBO(166, 227, 184, 1),
                          fontStyle: FontStyle.italic),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 11,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const Text(
                ' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ',
                style: TextStyle(color: Color.fromRGBO(145, 145, 145, 1)),
                maxLines: 1,
              ),

              Text(
                '"$description"',
                style: const TextStyle(
                    color: Color.fromRGBO(200, 200, 200, 1), fontSize: 10),
              ),

              // Description
            ],
          ),
        ),
      ),
    );
  }
}
