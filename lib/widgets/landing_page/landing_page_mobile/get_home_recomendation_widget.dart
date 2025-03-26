import 'package:flutter/material.dart';
import 'package:hously_flutter/data/design/design.dart';

class GetHomeRecommendation extends StatelessWidget {
  const GetHomeRecommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 454,
      width: MediaQuery.of(context).size.width,
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get home recommendations',
                  style: AppTextStyles.libreCaslonHeading
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Join us to access personalized recommendations, exclusive listings, and more features tailored just for you.',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(145, 145, 145, 1)),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(260, 48),
                backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {

              },
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 220,
              width: 420,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 45,
                        top: 30,
                        child: Container(
                          width: 215,
                          height: 166,
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
                                height: 100,
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
                                            fontSize: 7,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                      const Text(
                                        'Parker Rd. Allentown',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                      const Text(
                                        'Milan, ITALY',
                                        style: TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                      RichText(
                                          text: const TextSpan(children: [
                                        TextSpan(
                                          text: '\$165.00',
                                          style: TextStyle(
                                              fontSize: 12,
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
                      Positioned(
                        top: 30,
                        left: 150,
                        child: Container(
                          width: 215,
                          height: 166,
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
                                height: 100,
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
                                            fontSize: 7,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                      const Text(
                                        'Parker Rd. Allentown',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                      const Text(
                                        'Milan, ITALY',
                                        style: TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromRGBO(
                                                145, 145, 145, 1)),
                                      ),
                                      RichText(
                                          text: const TextSpan(children: [
                                        TextSpan(
                                          text: '\$165.00',
                                          style: TextStyle(
                                              fontSize: 12,
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
                  Positioned(
                    bottom: 90,
                    left: 0,
                    child: Container(
                      height: 34,
                      width: 134,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(233, 233, 233, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 23,
                            width: 23,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                            child: const Icon(
                              Icons.location_on_outlined,
                              size: 12,
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
                                'Recommended homes',
                                style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(35, 35, 35, 1)),
                              ),
                              Text(
                                'Based on your budget',
                                style: TextStyle(
                                    fontSize: 6.5,
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
                    top: 10,
                    left: 50,
                    child: Container(
                      height: 28,
                      width: 70,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(233, 233, 233, 1),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.star,
                                  color: Colors.yellow.shade800, size: 10),
                              Icon(Icons.star,
                                  color: Colors.yellow.shade800, size: 10),
                              Icon(Icons.star,
                                  color: Colors.yellow.shade800, size: 10),
                              Icon(Icons.star,
                                  color: Colors.yellow.shade800, size: 10),
                            ],
                          ),
                          const Text(
                            '(238 reviews)',
                            style: TextStyle(
                                fontSize: 6.5,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(35, 35, 35, 1)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: 40,
                    child: Container(
                      height: 31,
                      width: 97,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(233, 233, 233, 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 21,
                            width: 21,
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(35, 35, 35, 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                            child: const Center(
                              child: Text(
                                '10K+',
                                style: TextStyle(
                                    fontSize: 7.5,
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
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(35, 35, 35, 1)),
                              ),
                              Text(
                                'Feedback received',
                                style: TextStyle(
                                    fontSize: 6,
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
      ),
    );
  }
}
