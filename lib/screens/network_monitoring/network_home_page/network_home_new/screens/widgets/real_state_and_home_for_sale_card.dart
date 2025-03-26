import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/exclusive_offers_widget.dart';

class RealStateAndHomeForSaleCard extends StatelessWidget {
  final String imageUrl;
  final String? location;
  final String? address;
  final String size;
  final String rooms;
  final String bath;
  final String price;
  final bool isMobile;

  const RealStateAndHomeForSaleCard(
      {super.key,
      required this.imageUrl,
      this.location,
      this.address,
      required this.size,
      required this.rooms,
      required this.bath,
      required this.price,
      this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isMobile ? 0 : 6),
          color: const Color.fromRGBO(41, 41, 41, 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(isMobile ? 0 : 6)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location!,
                    style: const TextStyle(
                      color: Color.fromRGBO(200, 200, 200, 1),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address!,
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconText(icon: Icons.square_foot, text: '$size ㎡'),
                      IconText(icon: Icons.bed, text: '$rooms Rooms'),
                      IconText(icon: Icons.bathtub, text: '$bath Bath'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Divider(color: Color.fromRGBO(90, 90, 90, 1)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'FOR SALE',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
