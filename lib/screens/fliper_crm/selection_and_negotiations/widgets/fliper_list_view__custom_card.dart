import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/gradiant_text_widget.dart';

class FlipperListViewCustomCard extends StatelessWidget {
  final String address;
  final String name;
  final String price;
  final String profitPotential;
  final String imageUrl;
  const FlipperListViewCustomCard({
    super.key,
    required this.price,
    required this.name,
    required this.address,
    required this.profitPotential,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 194,
      width: 230,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(41, 41, 41, 1),
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(6)),
              child:  Image.network(
                      imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address,
                    style: const TextStyle(
                        color: Color.fromRGBO(200, 200, 200, 1),
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w700),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      textAlign: TextAlign.end,
                      '~\$ $price',
                      style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const GradientText('Profit Potential:',
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(87, 148, 221, 1),
                            Color.fromRGBO(87, 222, 210, 1),
                          ]),
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                      GradientText('\$ $profitPotential',
                          gradient: const LinearGradient(colors: [
                            Color.fromRGBO(87, 148, 221, 1),
                            Color.fromRGBO(87, 222, 210, 1),
                          ]),
                          style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
