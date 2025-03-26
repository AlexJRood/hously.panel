import 'package:flutter/material.dart';
import 'package:hously_flutter/data/design/design.dart';

class OverMissionWidget extends StatelessWidget {
  const OverMissionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 845,
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: Image.asset(
                'assets/images/frame_427322549.png',
                height: 222,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Our Mission',
              style: AppTextStyles.libreCaslonHeading
                  .copyWith(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text(
              'We are a passionate team dedicated to creating meaningful experiences through innovative design and technology. Our mission is to connect people, inspire creativity, and empower communities. With a focus on user-centered solutions, we aim to bridge gaps, solve problems, and bring ideas to life. ',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(145, 145, 145, 1)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {

              },
              child: const Text(
                'Learn More',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Property for rent available now',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(90, 90, 90, 1),
                  ),
                ),
              ],
            ),
            const Divider(),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Modern property available',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(90, 90, 90, 1),
                  ),
                ),
              ],
            ),
            const Divider(),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Satisfied customer connected with us',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(90, 90, 90, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
