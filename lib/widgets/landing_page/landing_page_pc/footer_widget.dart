import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/route_constant.dart';
import '../../../screens/pop_pages/view_pop_changer_page.dart';
import '../../../state_managers/services/navigation_service.dart';

class FooterWidget extends ConsumerWidget {
  final double paddingDynamic;

  const FooterWidget({super.key, required this.paddingDynamic});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateToAboutUs(BuildContext context) {
      ref.read(navigationService).pushNamedScreen(Routes.aboutusview);
      ref.read(selectedFeedViewProvider.notifier).state = Routes.aboutusview;
    }

    bool isChecked = false;
    const double footerSpacer = 10;
    return Container(
      height: 500,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromRGBO(19, 19, 19, 1)),
      child: Stack(
        children: [
          Positioned(
              bottom: -10,
              right: 0,
              left: 0,
              height: 120,
              child: Image.asset('assets/images/hously_pro.png')),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: paddingDynamic, vertical: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'HOUSLY.PRO',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Subscribe to our newsletter for the\nlatest recommendations, and news.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 48,
                            width: 345,
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.arrow_forward,
                                  color: Color.fromRGBO(145, 145, 145, 1),
                                ),
                                fillColor: Colors.transparent,
                                filled: true,
                                hintText: 'Email',
                                hintStyle: const TextStyle(
                                    color: Color.fromRGBO(145, 145, 145, 1)),
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
                              StatefulBuilder(
                                builder: (context, setState) => Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        isChecked = value;
                                      });
                                    }
                                  },
                                  checkColor: Colors.black, // This sets the tick color
                                  activeColor: Colors.white, // Background color when checked
                                ),
                              )
,
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
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),

                    // Navigation Links
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: footerSpacer,
                        children: [
                          Text(
                            'Navigation Links',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Buy', style: TextStyle(color: Colors.white70)),
                          Text('Rent', style: TextStyle(color: Colors.white70)),
                          Text('Sell', style: TextStyle(color: Colors.white70)),
                          Text('Invest',
                              style: TextStyle(color: Colors.white70)),
                          Text('Build',
                              style: TextStyle(color: Colors.white70)),
                          Text('Recommended deals',
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),

                    // Categories
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: footerSpacer,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Flat', style: TextStyle(color: Colors.white70)),
                          Text('Studio apartment',
                              style: TextStyle(color: Colors.white70)),
                          Text('Apartment',
                              style: TextStyle(color: Colors.white70)),
                          Text('Vacation homes',
                              style: TextStyle(color: Colors.white70)),
                          Text('Commercial spaces',
                              style: TextStyle(color: Colors.white70)),
                          Text('Luxury apartments',
                              style: TextStyle(color: Colors.white70)),
                          Text('Garages',
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),

                    // Terms and About
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: footerSpacer,
                        children: [
                          Text(
                            'Terms and settings',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Privacy Policy',
                              style: TextStyle(color: Colors.white70)),
                          Text('Terms and conditions',
                              style: TextStyle(color: Colors.white70)),
                          Text('Cookie Policy',
                              style: TextStyle(color: Colors.white70)),
                          Text('User Agreements',
                              style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: footerSpacer,
                      children: [
                        const Text(
                          'About',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => navigateToAboutUs(context),
                          child: const Text('About Hously',
                              style: TextStyle(color: Colors.white70)),
                        ),
                        const Text('How we work',
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // Footer Bottom Section
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2024 Hously. All rights reserved. Icons by Icons8',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
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
