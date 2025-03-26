import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class AboutPageMobile extends ConsumerStatefulWidget {
  @override
  _AboutPageMobileState createState() => _AboutPageMobileState();
}

class _AboutPageMobileState extends ConsumerState<AboutPageMobile> {
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _notesController;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);
    final color = Theme.of(context).primaryColor;

    return Scaffold(
      // Remove/Adjust if you need SideMenuManager or gradient
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 810,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/aboutustop.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // 2) Dark Overlay
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: SvgPicture.asset(
                            AppIcons.menu,
                            color: Colors.white,
                            height: 18,
                            width: 18,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Sign up",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      // Constrain the width for better readability on larger screens
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Big heading
                            Row(
                              children: [
                                Text(
                                  "About ",
                                  style: GoogleFonts.libreCaslonText(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Hously.PRO",
                                  style: GoogleFonts.inter(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Description
                            Text(
                              "We provide a revolutionary real estate experience by combining advanced technology with a personalized touch.Our mission is clear: to make buying, selling, and managing real estate seamless, intelligent, and empowering for everyone involved.",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xffE9E9E9),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // "Contact an Agent" button
                            SizedBox(
                              height: 44,
                              width: MediaQuery.of(context).size.width * .5,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  elevation: 2,
                                ),
                                child: Text(
                                  "Contact an Agent",
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  color: const Color(0xff131313),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 1) Statistics in a Row
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StatItem(
                              number: "270+",
                              label: "Property for rent available now"),
                          DividerWidget(),
                          SizedBox(
                            height: 7,
                          ),
                          StatItem(
                              number: "7K+",
                              label: "Modern property available"),
                          DividerWidget(),
                          SizedBox(
                            height: 7,
                          ),
                          StatItem(
                              number: "740+",
                              label: "Satisfied customer connected with us"),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // 2) “Our Mission” Section (Image on left, Text on right)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              'assets/images/aboutusimage.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 40),
                          Text(
                            "Our Mission",
                            style: GoogleFonts.libreCaslonText(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "We are a passionate team dedicated to creating meaningful "
                            "experiences through innovative design and technology. Our "
                            "mission is to connect people, inspire creativity, and empower "
                            "communities. With a focus on user-centered solutions, we aim to "
                            "bridge gaps, solve problems, and bring ideas to life.",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xffC8C8C8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  // vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                elevation: 2,
                              ),
                              child: Text(
                                "Contact us",
                                style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 720,
                  color: const Color(0xff212020),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Expanded(
                        // Remove this Expanded if you get layout errors,
                        // or place this widget in a parent Column/Row.
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Top Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/images/aboutusimage2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Title
                              Text(
                                "What’s important to us",
                                style: GoogleFonts.libreCaslonText(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Paragraph
                              Text(
                                "We are a passionate team dedicated to creating meaningful experiences through innovative design and technology. Our mission is to connect people, inspire creativity, and empower communities.",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xff919191),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Value Items
                              const BuildValueItem(
                               icon: Icons.people,
                                title: "People",
                                description: "Our goal is to build lasting relationships with clients and agents.",
                              ),
                              const Divider2(),
                              const SizedBox(height: 10),

                              const BuildValueItem(
                                icon: Icons.handshake,
                                title:"Service",
                                description: "Our goal is to build lasting relationships with clients and agents.",
                              ),
                              const Divider2(),
                              const SizedBox(height: 10),
                              const BuildValueItem(
                                icon:  Icons.star,
                                title: "Integrity",
                                description:  "Our goal is to build lasting relationships with clients and agents.",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 750,
                  width: double.infinity,
                  color: const Color(0xff131313),
                  child: Stack(
                    children: [
                      /// 1) Background image
                      Positioned.fill(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 500,
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          child: Image.asset(
                            'assets/images/aboutusimage3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      /// 2) Foreground container (the form) with rounded top corners
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 200,
                        child: Container(
                          // Adjust this height as needed
                          height: 530,
                          decoration: const BoxDecoration(
                            color: Color(0xff131313),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                // In case content exceeds the container height
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Let's get in touch.",
                                      style: GoogleFonts.libreCaslonText(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: _firstNameController,
                                      decoration:
                                          _inputDecoration('First Name'),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your first name";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: _lastNameController,
                                      decoration: _inputDecoration('Last Name'),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your last name";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: _phoneController,
                                      decoration:
                                          _inputDecoration('Phone Number'),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your phone number";
                                        }
                                        if (!RegExp(r'^\d{10}$')
                                            .hasMatch(value)) {
                                          return "Enter a valid 10-digit phone number";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: _emailController,
                                      decoration: _inputDecoration('Email'),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your email";
                                        }
                                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                            .hasMatch(value)) {
                                          return "Enter a valid email address";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      controller: _notesController,
                                      decoration: InputDecoration(
                                        labelText: "Notes",
                                        labelStyle: const TextStyle(
                                          fontSize: 11,
                                          color: Color(0xFFC8C8C8),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 2),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 2),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        alignLabelWithHint: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 2),
                                        ),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.black),
                                      maxLines: 3,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter your notes";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // All fields are valid, proceed with submission
                                            debugPrint(
                                                "Form submitted successfully!");
                                            // Add your submission logic here
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          elevation: 2,
                                        ),
                                        child: Text(
                                          "Submit",
                                          style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // The main container for your footer
                      Container(
                        // Set a height if you want a fixed footer area
                        height: 1000,
                        width: double.infinity,
                        color: Colors.grey[900],
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 1) Top Row: the four columns side by side
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FooterColumn(
                                  title: "Navigation Links",
                                  items: const [
                                    "Buy",
                                    "Rent",
                                    "Sell",
                                    "Invest",
                                    "Build",
                                    "Recommended deals",
                                  ],
                                  onItemTap: (item) {
                                    // Handle tap for the item here
                                    print("Tapped on $item");
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                FooterColumn(
                                  title: "Categories",
                                  items: const [
                                    "Flat",
                                    "Studio apartment",
                                    "Apartment",
                                    "Vacation homes",
                                    "Commercial spaces",
                                    "Luxury apartments",
                                    "Garages",
                                  ],
                                  onItemTap: (item) {
                                    // Handle tap for the item here
                                    print("Tapped on $item");
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                FooterColumn(
                                  title: "Terms and settings",
                                  items: const [
                                    "Privacy Policy",
                                    "Terms and conditions",
                                    "Cookie Policy",
                                    "User Agreements",
                                  ],
                                  onItemTap: (item) {
                                    // Handle tap for the item here
                                    print("Tapped on $item");
                                  },
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                FooterColumn(
                                  title: "About",
                                  items: const [
                                    "About Hously",
                                    "How we work",
                                    "Careers", // Example extra link
                                  ],
                                  onItemTap: (item) {
                                    // Handle tap for the item here
                                    print("Tapped on $item");
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            /// 2) Brand & Newsletter Section
                            Text(
                              "HOUSLY.PRO",
                              style: GoogleFonts.inter(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Subscribe to our newsletter for the latest recommendations, and news.",
                              style: GoogleFonts.inter(
                                  color: const Color(0xffE9E9E9),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 10),

                            // Email TextField with arrow suffix
                            SizedBox(
                              height: 40,
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Adjust to your needs
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.inter(
                                    color: const Color(0xff919191),
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                      color: Color(0xff5A5A5A),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                      color: Color(0xff5A5A5A),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                      color: Color(0xff5A5A5A),
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 14,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      // Handle subscribe action
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(2.0),
                                      decoration: const BoxDecoration(
                                        color: Color(0xff2F2F2F),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(6),
                                          bottomRight: Radius.circular(6),
                                        ),
                                      ),
                                      child: SvgPicture.asset(
                                        AppIcons.simpleArrowForward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  suffixIconConstraints: const BoxConstraints(
                                    minWidth: 40,
                                    minHeight: 48,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Checkbox
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // The checkbox on the far left
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked = value ?? false;
                                    });
                                  },
                                ),

                                // The text on the far right, wrapped by Expanded to avoid overflow
                                Expanded(
                                  child: Text(
                                    "I agree with our Terms of Service, Privacy Policy and our default Notification Settings.",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            /// 3) Footer / Copyright
                            Container(
                              height: 40,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.asset(
                                      'assets/images/aboutusbottom.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Copyright © 2424 Hously.",
                                          style: TextStyle(
                                            color: Color(0xffE9E9E9),
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          " All rights reserved. Icons by Icons8",
                                          style: TextStyle(
                                            color: Color(0xffE9E9E9),
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 4) Bottom Wave/Shape
                      Positioned(
                        // Adjust these values to match exactly how you want it to appear
                        bottom: -27,
                        left: 250,
                        right: 250,
                        child: Image.asset(
                          'assets/images/aboutusbottom.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 11, color: Color(0xFFC8C8C8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xffE2E8F0), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}

class FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;
  final Function(String) onItemTap;

  const FooterColumn({
    Key? key,
    required this.title,
    required this.items,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        for (var item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: InkWell(
              onTap: () => onItemTap(item),
              child: Text(
                item,
                style: GoogleFonts.inter(
                  color: const Color(0xffE9E9E9),
                  fontSize: 15,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ButtonTextRowAboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 8),
          TextButtonWidget(label: "BUY", onPressed: () {}),
          TextButtonWidget(label: "RENT", onPressed: () {}),
          TextButtonWidget(label: "SELL", onPressed: () {}),
          TextButtonWidget(label: "INVEST", onPressed: () {}),
          TextButtonWidget(label: "BUILD", onPressed: () {}),
        ],
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const TextButtonWidget({
    required this.label,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: MouseRegion(
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.white
                        .withOpacity(0.4); // White shade on hover
                  }
                  return Colors.transparent; // Default transparent background
                },
              ),
            ),
            onPressed: onPressed,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white, // Text remains white
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String number;
  final String label;

  const StatItem({
    required this.number,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xffC8C8C8),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
} // Divider Widget

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(0xff5A5A5A),
    );
  }
}

class Divider2 extends StatelessWidget {
  const Divider2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: const Color(0xffFFFFFF),
    );
  }
}

class BuildValueItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const BuildValueItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: const Color(0xffC8C8C8),
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