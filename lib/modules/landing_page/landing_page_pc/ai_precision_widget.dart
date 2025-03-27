import 'package:flutter/material.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'gradiant_text_widget.dart';

class AiPrecisionWidget extends StatelessWidget {
  final double paddingDynamic;
  const AiPrecisionWidget({super.key, required this.paddingDynamic});

  @override
  Widget build(BuildContext context) {
    final dynamicVerticalPadding = paddingDynamic / 3;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dynamicVerticalPadding),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingDynamic),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/group_113.png',
                    width: 424,
                    height: 281,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GradientText(
                              "AI ",
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(87, 222, 210, 1),
                                  Color.fromRGBO(87, 148, 221, 1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              style: AppTextStyles.libreCaslonHeading.copyWith(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Precision',
                              style: AppTextStyles.libreCaslonHeading.copyWith(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GradientText(
                                "REASON 1 ",
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(87, 222, 210, 1),
                                    Color.fromRGBO(87, 148, 221, 1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                style:
                                    AppTextStyles.libreCaslonHeading.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                'Our AI analyzes your preferences—budget, location, lifestyle—to\nquickly find the best home options for you. Effortless and tailored\nresults!',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(90, 90, 90, 1)),
                              ),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 48,
                              width: 247,
                              color: Colors.transparent,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Try the AI Experience Now ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(35, 35, 35, 1),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 14,
                                    color: Color.fromRGBO(35, 35, 35, 1),
                                  )
                                ],
                              ),
                            )),
                        const Divider()
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Network ',
                              style: AppTextStyles.libreCaslonHeading.copyWith(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                            GradientText(
                              "Monitoring",
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(87, 222, 210, 1),
                                  Color.fromRGBO(87, 148, 221, 1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              style: AppTextStyles.libreCaslonHeading.copyWith(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GradientText(
                                "REASON 2 ",
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(87, 222, 210, 1),
                                    Color.fromRGBO(87, 148, 221, 1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                style:
                                    AppTextStyles.libreCaslonHeading.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                'We continuously monitor thousands of listings to ensure the\nproperties you see are accurate, up-to-date, and ready to go. Our\nnetwork monitoring ensures you never miss a property!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 48,
                              width: 247,
                              color: Colors.transparent,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Explore Our Monitoring Advantage ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(35, 35, 35, 1),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 14,
                                    color: Color.fromRGBO(35, 35, 35, 1),
                                  )
                                ],
                              ),
                            )),
                        const Divider()
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/landingpage_ai_section.png',
                    width: 424,
                    height: 281,
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/landingpage_report_section.png',
                    width: 424,
                    height: 281,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Detailed ',
                              style: AppTextStyles.libreCaslonHeading.copyWith(
                                  fontSize: 36, fontWeight: FontWeight.bold),
                            ),
                            GradientText(
                              "Reports",
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(87, 222, 210, 1),
                                  Color.fromRGBO(87, 148, 221, 1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              style: AppTextStyles.libreCaslonHeading.copyWith(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GradientText(
                                "REASON 3 ",
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(87, 222, 210, 1),
                                    Color.fromRGBO(87, 148, 221, 1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                style:
                                    AppTextStyles.libreCaslonHeading.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: const Text(
                                'Curious about a property? Simply search and purchase a detailed\nreport that covers every angle of the property.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(90, 90, 90, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 48,
                              width: 247,
                              color: Colors.transparent,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Buy Your Property Report Today ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(35, 35, 35, 1),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 14,
                                    color: Color.fromRGBO(35, 35, 35, 1),
                                  )
                                ],
                              ),
                            )),
                        const Divider()
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
