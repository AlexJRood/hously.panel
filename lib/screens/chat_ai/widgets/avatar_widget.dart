import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(90),
        ),
        color: const Color.fromRGBO(255, 255, 255, 0.1),
        border: Border.all(
          color: const Color.fromRGBO(200, 200, 200, 1),
          width: 2.0,
        ),
      ),
      child: const Center(
        child: Text(
          'AI',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

