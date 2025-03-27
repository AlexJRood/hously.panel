import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/theme/design/design.dart';

class GetHomeRecommendationsWidget extends StatelessWidget {
  final double paddingDynamic;
  const GetHomeRecommendationsWidget({super.key, required this.paddingDynamic});

  @override
  Widget build(BuildContext context) {
    final dynamicVerticalPadding = paddingDynamic / 3;
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.only(
          left: paddingDynamic,
          right: paddingDynamic,
          top: dynamicVerticalPadding - 25,
          bottom: dynamicVerticalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Section
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text(
                  'GET HOME RECOMMENDATIONS',
                  style: AppTextStyles.libreCaslonHeading.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Join us to access personalized recommendations, exclusive listings,\nand more features tailored just for you.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(142, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Add your onPressed action here
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                )
              ],
            ),
          ),

          // Right Section (Cards)
          Container(
            color: Colors.transparent,
            height: 420,
            width: 720,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 80,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 398,
                        height: 309,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(34, 57, 62, 1),
                              Color.fromRGBO(22, 25, 32, 1),
                            ]),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.9), // Shadow color with opacity
                                spreadRadius: 8, // How far the shadow spreads
                                blurRadius: 8, // Softness of the shadow
                                offset: const Offset(
                                    0, 20), // Position of the shadow (x, y)
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 185,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/landingpage.webp'),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      '---- Property type / 04 June 2024',
                                      style: TextStyle(
                                          fontSize: 12.93,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(145, 145, 145, 1)),
                                    ),
                                    const Text(
                                      'Parker Rd. Allentown',
                                      style: TextStyle(
                                          fontSize: 18.47,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromRGBO(145, 145, 145, 1)),
                                    ),
                                    const Text(
                                      'Milan, ITALY',
                                      style: TextStyle(
                                          fontSize: 12.93,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(145, 145, 145, 1)),
                                    ),
                                    RichText(
                                        text: const TextSpan(children: [
                                      TextSpan(
                                        text: '\$165.00',
                                        style: TextStyle(
                                            fontSize: 22.16,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                      TextSpan(
                                        text: '/1700 sq.ft',
                                        style: TextStyle(
                                            fontSize: 12.93,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                    ])),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 199,
                        child: Container(
                          width: 398,
                          height: 309,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(34, 57, 62, 1),
                                Color.fromRGBO(22, 25, 32, 1),
                              ]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 185,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/landingpage.webp'),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        '---- Property type / 04 June 2024',
                                        style: TextStyle(
                                            fontSize: 12.93,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                      const Text(
                                        'Parker Rd. Allentown',
                                        style: TextStyle(
                                            fontSize: 18.47,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                      const Text(
                                        'Milan, ITALY',
                                        style: TextStyle(
                                            fontSize: 12.93,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                      RichText(
                                          text: const TextSpan(children: [
                                        TextSpan(
                                          text: '\$165.00',
                                          style: TextStyle(
                                              fontSize: 22.16,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  145, 145, 145, 1)),
                                        ),
                                        TextSpan(
                                          text: '/1700 sq.ft',
                                          style: TextStyle(
                                              fontSize: 12.93,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  145, 145, 145, 1)),
                                        ),
                                      ])),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 0,
                  child: Container(
                    height: 64,
                    width: 247,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(32))),
                          child: SvgPicture.asset(AppIcons.location),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recommended homes',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(35, 35, 35, 1)),
                            ),
                            Text(
                              'Based on your budget',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(90, 90, 90, 1)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  child: Container(
                    height: 51,
                    width: 130,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.yellow.shade800),
                            Icon(Icons.star, color: Colors.yellow.shade800),
                            Icon(Icons.star, color: Colors.yellow.shade800),
                            Icon(Icons.star, color: Colors.yellow.shade800),
                          ],
                        ),
                        const Text(
                          '(238 reviews)',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(35, 35, 35, 1)),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 130,
                  right: 0,
                  child: Container(
                    height: 58,
                    width: 180,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(35, 35, 35, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))),
                          child: const Center(
                            child: Text(
                              '10K+',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Happy clients!',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(35, 35, 35, 1)),
                            ),
                            Text(
                              'Feedback received',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(90, 90, 90, 1)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
