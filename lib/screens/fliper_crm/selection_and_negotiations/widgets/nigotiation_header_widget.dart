import 'package:flutter/material.dart';

class NegotiationHeaderWidget extends StatelessWidget {
  final bool isMobile;
  const NegotiationHeaderWidget({super.key,this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 33,
                  width: 253,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(33, 32, 32, 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'Transaction name /title',
                      style: TextStyle(
                        color: Color.fromRGBO(145, 145, 145, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if(!isMobile)
          const Text(
            'HOUSLY',
            style: TextStyle(
              fontSize: 20, // Adjust logo size as needed
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
