import 'package:flutter/material.dart';
import 'package:hously_flutter/data/design/design.dart';

import '../landing_page_pc/gradiant_text_widget.dart';

class AiPrecisionWidget extends StatelessWidget {
  const AiPrecisionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1500,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/group_113.png',
                  height: 230,
                  fit: BoxFit.cover,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const GradientText(
                          "AI ",
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(87, 222, 210, 1),
                              Color.fromRGBO(87, 148, 221, 1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          style: TextStyle(
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
                    GradientText(
                      "REASON 1 ",
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(87, 222, 210, 1),
                          Color.fromRGBO(87, 148, 221, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      style: AppTextStyles.libreCaslonHeading.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'Our AI analyzes your preferences—budget, location, lifestyle—to\nquickly find the best home options for you. Effortless and tailored\nresults!',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(90, 90, 90, 1)),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 48,
                      width: 247,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            iconAlignment: IconAlignment.end,
                            label: const Text(
                              'Try the AI Experience Now',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(35, 35, 35, 1),
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_forward,
                              size: 14,
                              color: Color.fromRGBO(35, 35, 35, 1),
                            ),
                          )
                        ],
                      ),
                    )),
                const Divider()
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/landingpage_ai_section.png',
                  height: 230,
                  fit: BoxFit.cover,
                ),
                Column(
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
                    GradientText(
                      "REASON 2 ",
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(87, 222, 210, 1),
                          Color.fromRGBO(87, 148, 221, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      style: AppTextStyles.libreCaslonHeading.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'We continuously monitor thousands of listings to ensure the properties you see are accurate, up-to-date, and ready to go. Our network monitoring ensures you never miss a property!',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(90, 90, 90, 1)),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 48,
                      width: 247,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            iconAlignment: IconAlignment.end,
                            label: const Text(
                              'Try the AI Experience Now',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(35, 35, 35, 1),
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_forward,
                              size: 14,
                              color: Color.fromRGBO(35, 35, 35, 1),
                            ),
                          )
                        ],
                      ),
                    )),
                const Divider()
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/landingpage_report_section.png',
                  height: 230,
                  fit: BoxFit.cover,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GradientText(
                          "Detailed ",
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
                          'Reports',
                          style: AppTextStyles.libreCaslonHeading.copyWith(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    GradientText(
                      "REASON 3 ",
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(87, 222, 210, 1),
                          Color.fromRGBO(87, 148, 221, 1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      style: AppTextStyles.libreCaslonHeading.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'Curious about a property? Simply search and purchase a detailed report that covers every angle of the property.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(90, 90, 90, 1)),
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 48,
                      width: 247,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Ensure valid shape
                              ),
                            ),
                            onPressed: () {},
                            iconAlignment: IconAlignment.end,
                            label: const Text(
                              'Try the AI Experience Now',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(35, 35, 35, 1),
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_forward,
                              size: 14,
                              color: Color.fromRGBO(35, 35, 35, 1),
                            ),
                          ),
                        ],
                      ),
                    )),
                const Divider()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
