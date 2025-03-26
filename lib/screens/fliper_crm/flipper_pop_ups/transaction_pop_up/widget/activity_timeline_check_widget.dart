import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';

class ActivityTimelineCheckWidget extends StatelessWidget {
  final String title;
  final String date;
  final bool isMobile;
  const ActivityTimelineCheckWidget(
      {super.key,
      required this.title,
      required this.date,
      this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.transparent,
                  border: Border.all(
                      color: const Color.fromRGBO(200, 200, 200, 1))),
              child: Center(
                child:
                    SvgPicture.asset(AppIcons.check, color: Color.fromRGBO(200, 200, 200, 1)),
              ),
            ),
            Container(
              height: 70,
              width: 1,
              color: Colors.white,
            )
          ],
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                Text(
                  date,
                  style: const TextStyle(
                      color: Color.fromRGBO(145, 145, 145, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
            if (isMobile)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color: Color.fromRGBO(87, 148, 221, 1)))),
                  child: const Column(
                    children: [
                      Row(
                        spacing: 20,
                        children: [
                          Text(
                            'Initial Price:',
                            style: TextStyle(
                                color: Color.fromRGBO(200, 200, 200, 1),
                                fontSize: 10,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '\$120,000',
                            style: TextStyle(
                                color: Color.fromRGBO(200, 200, 200, 1),
                                fontSize: 10,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 20,
                        children: [
                          Text(
                            'Seller Offer:',
                            style: TextStyle(
                                color: Color.fromRGBO(233, 233, 233, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '\$118,000',
                            style: TextStyle(
                                color: Color.fromRGBO(233, 233, 233, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}
