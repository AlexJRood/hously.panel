import 'package:flutter/material.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 770,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/mapa.png'),
                  fit: BoxFit.cover)),
        ),
        Positioned(
          right: 30,
          child: SizedBox(
            height: 770,
            width: 420,
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 50),
              separatorBuilder: (context, index) => const SizedBox(
                height: 30,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      'assets/images/landingpage.webp',
                      height: 206,
                      width: 420,
                      fit: BoxFit
                          .cover, // Optional: Ensures the image scales correctly
                    ),
                  ),
                  const Positioned(
                    bottom: 20,
                    left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$129.00',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          'Biały Kamień Street',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
