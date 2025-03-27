import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isChecked = false;
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(19, 19, 19, 1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Navigation Links',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) => const Text(
                      'Buy',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(145, 145, 145, 1)),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Navigation Links',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) => const Text(
                      'Buy',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(145, 145, 145, 1)),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Navigation Links',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) => const Text(
                      'Buy',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(145, 145, 145, 1)),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Navigation Links',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) => const Text(
                      'Buy',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(145, 145, 145, 1)),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'HOUSLY.PRO',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Subscribe to our newsletter for the latest recommendations, and news.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 48,
              width: 345,
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.arrow_forward,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  fillColor: Colors.transparent,
                  filled: true,
                  hintText: 'Email',
                  hintStyle:
                      const TextStyle(color: Color.fromRGBO(145, 145, 145, 1)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(90, 90, 90, 1))),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    _isChecked = value ?? false;
                  },
                  activeColor: Colors.blue,
                  checkColor: Colors.white,
                  side: const BorderSide(color: Colors.grey),
                ),
                const Expanded(
                  child: Text(
                    'I agree with our Terms of Service, Privacy Policy and\nour default Notification Settings.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 18),
            Stack(
              children: [
                Image.asset('assets/images/hously_pro.png'),
                const Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        'Copyright @ 2424 Hously.',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'All rights reserved. Icons by Icons8',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
