import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/gradiant_text_widget.dart';

class CalculatorCheckStepWidget extends StatelessWidget {
  final String title;
  final int number;
  final String price;
  final bool isLast;
  const CalculatorCheckStepWidget(
      {super.key,
      required this.title,
      required this.number,
      required this.price,
      this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          spacing: 5,
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
              height: 60,
              width: 1,
              color: Colors.white,
            )
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STEP$number: ',
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  GradientText(
                    title,
                    gradient: const LinearGradient(colors: [
                      Color.fromRGBO(87, 222, 210, 1),
                      Color.fromRGBO(87, 148, 221, 1)
                    ]),
                    style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  )
                ],
              ),
              Column(
                spacing: 10,
                children: [
                  Container(
                    height: 46,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color.fromRGBO(166, 227, 184, 0.1)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '\$ $price',
                        style: const TextStyle(
                            color: Color.fromRGBO(145, 145, 145, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  if (isLast)
                    const Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Calculate \$ per SF',
                          style: TextStyle(
                              color: Color.fromRGBO(166, 227, 184, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Calculate refurbishment',
                          style: TextStyle(
                              color: Color.fromRGBO(166, 227, 184, 1),
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
