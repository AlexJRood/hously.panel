import 'package:flutter/material.dart';
import 'package:hously_flutter/theme/design/design.dart';

class OverMissionWidget extends StatelessWidget {
  final double paddingDynamic;
  const OverMissionWidget({super.key, required this.paddingDynamic});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 620,
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Center(
        child: SizedBox(
          height: 470,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingDynamic),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Image.asset(
                      'assets/images/frame_427322549.png',
                      height: 420,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Our Mission',
                          style: AppTextStyles.libreCaslonHeading.copyWith(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(35, 35, 35, 1),
                          ),
                        ),
                        const Text(
                          'We are a passionate team dedicated to creating meaningful experiences\nthrough innovative design and technology. Our mission is to connect\npeople, inspire creativity, and empower communities. With a focus on\nuser-centered solutions, we aim to bridge gaps, solve problems, and\nbring ideas to life.',
                          style: TextStyle(
                            color: Color.fromRGBO(145, 145, 145, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 48,
                          width: 181,
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              minimumSize: const Size(181, 48),
                            ),
                            child: const Text(
                              'Learn More',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '270+',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(35, 35, 35, 1),
                                    ),
                                  ),
                                  Text(
                                    'Property for rent\navailable now',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(90, 90, 90, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '7K+',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(35, 35, 35, 1),
                                    ),
                                  ),
                                  Text(
                                    'Modern property\navailable',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(90, 90, 90, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '740+',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(35, 35, 35, 1),
                                    ),
                                  ),
                                  Text(
                                    'Satisfied customer\nconnected with us',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(90, 90, 90, 1),
                                    ),
                                  ),
                                ],
                              ),
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
        ),
      ),
    );
  }
}
