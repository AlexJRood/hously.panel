import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';

class Finance2PropertyCard extends StatelessWidget {
  final bool isMobile;
  const Finance2PropertyCard({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isMobile ? 270 : 158,
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8)),
                        child: Image.asset(
                          "assets/images/landingpage.webp",
                          width: double.infinity, // Take full width
                          height: 130, // Adjusted height
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "Sponsored",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Content Section
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Warszawa, Mokotów, Poland",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const Text(
                          "Biały Kamień Street",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.straighten,
                                color: Colors.grey, height: 14,width: 14,),
                            const SizedBox(width: 4),
                            const Text("98 m²",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            const SizedBox(width: 10),
                            SvgPicture.asset(AppIcons.bed, color: Colors.grey, height: 14,width: 14,),
                            const SizedBox(width: 4),
                            const Text("2 Rooms",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            const SizedBox(width: 10),
                            SvgPicture.asset(AppIcons.bathroom, color: Colors.grey, height: 14,width: 14,),
                            const SizedBox(width: 4),
                            const Text("2 Bath",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                          ],
                        ),
                        const Divider(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("FOR SALE",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            Text(
                              "\$165,000",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/landingpage.webp",
                          width: 240,
                          height: 158,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(0, 0, 0, 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "Sponsored",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        spacing: 5,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Biały Kamień Street",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Warszawa, Mokotów, Poland",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(AppIcons.straighten,
                                  color: Colors.grey, height: 14,width: 14,),
                              const SizedBox(width: 4),
                              const Text("88 m²",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              const SizedBox(width: 10),
                              SvgPicture.asset(AppIcons.bed, color: Colors.grey, height: 14,width: 14,),
                              const SizedBox(width: 4),
                              const Text("2 Rooms",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                              const SizedBox(width: 10),
                              SvgPicture.asset(AppIcons.bathroom, color: Colors.grey, height: 14,width: 14,),
                              const SizedBox(width: 4),
                              const Text("2 Bath",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ],
                          ),
                          const Divider(),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("FOR SALE",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              Text(
                                "\$165,000",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
