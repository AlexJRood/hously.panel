import 'package:flutter/material.dart';

class MonitoringCustomMap extends StatelessWidget {
  final bool isMobile;
  const MonitoringCustomMap({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          isMobile
              ? 'assets/images/monitoring-map-mobile.png'
              : 'assets/images/map-1212.png',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          height: 180,
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            height: 32,
            width: 103,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(35, 35, 35, 1),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: const Center(
              child: Text(
                'Show on Map',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(200, 200, 200, 1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
