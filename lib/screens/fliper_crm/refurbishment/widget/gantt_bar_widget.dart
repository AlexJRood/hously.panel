import 'package:flutter/material.dart';

class GanttBarWidget extends StatelessWidget {
  final double start;
  final double end;
  const GanttBarWidget({super.key, required this.start, required this.end});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: start * 100),
        Container(
          height: 24,
          width: (end - start) * 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              colors: [Colors.cyanAccent, Colors.blueAccent],
            ),
          ),
        ),
      ],
    );
  }
}
