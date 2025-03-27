import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

import '../../theme/backgroundgradient.dart';
import '../../widgets/side_menu/side_menu_manager.dart';
import '../../widgets/bars/sidebar.dart';

class AboutPage extends ConsumerStatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends ConsumerState<AboutPage> {
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
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Row(
          children: [
            Sidebar(sideMenuKey: sideMenuKey),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: CustomBackgroundGradients.backgroundGradientRight1(
                      context, ref),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(color: Color(0xff000000)),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/aboutustop.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                              maxWidth: 800,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 14.0),
                                                          child: Image.asset(
                                                              'assets/images/aboutuspreference.png',
                                                              height: 16,
                                                              width: 16),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        TextButton(
                                                          onPressed: () {},
                                                          child: const Text(
                                                              "Preferences",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {},
                                                          child: const Text(
                                                              "Join / Log in",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children:
                                                          [
                                                        "BUY",
                                                        "RENT",
                                                        "SELL",
                                                        "INVEST",
                                                        "BUILD"
                                                      ]
                                                              .map(
                                                                  (item) =>
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                8),
                                                                        child:
                                                                            TextButton(
                                                                          onPressed:
                                                                              () {},
                                                                          child: Text(
                                                                              item,
                                                                              style: const TextStyle(color: Colors.white)),
                                                                        ),
                                                                      ))
                                                              .toList(),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  "Hously",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            height: 450,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                    maxWidth:
                                                        800, // Limits width for better readability
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(32),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              // Title
                                                              Row(
                                                                children: [
                                                                  Flexible(
                                                                    child:
                                                                        FittedBox(
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                      // Scales text down to fit

                                                                      child:
                                                                          Text(
                                                                        "About ",
                                                                        style: GoogleFonts
                                                                            .libreCaslonText(
                                                                          fontSize:
                                                                              42,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        softWrap:
                                                                            true,
                                                                        overflow:
                                                                            TextOverflow.visible,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        FittedBox(
                                                                      fit: BoxFit
                                                                          .scaleDown,
                                                                      // Scales text down to fit
                                                                      child:
                                                                          Text(
                                                                        "Hously.PRO",
                                                                        style: GoogleFonts
                                                                            .inter(
                                                                          fontSize:
                                                                              42,
                                                                          // Base size, will shrink if needed
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 16),
                                                              // Description
                                                              Text(
                                                                "We provide a revolutionary real estate experience by combining advanced technology with a personalized touch.\n"
                                                                "Our mission is clear: to make buying, selling, and managing real estate seamless, intelligent, and empowering for everyone involved.",
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontSize: 16,
                                                                  color: const Color(
                                                                      0xffE9E9E9),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                softWrap: true,
                                                                overflow:
                                                                    TextOverflow
                                                                        .visible,
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                              // CTA Button
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () {},
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          16),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                  elevation: 2,
                                                                ),
                                                                child: Text(
                                                                  "Contact an Agent",
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 600,
                                            width: double.infinity,
                                            color: const Color(0xff131313),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 40),
                                            child: Column(
                                              children: [
                                                // Statistics Row
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const StatItem(
                                                        number: "270+",
                                                        text:
                                                            "Property for rent available now"),
                                                    Divider(),
                                                    const StatItem(
                                                        number: "7K+",
                                                        text:
                                                            "Modern property available"),
                                                    Divider(),
                                                    const StatItem(
                                                        number: "740+",
                                                        text:
                                                            "Satisfied customer connected with us"),
                                                  ],
                                                ),
                                                const SizedBox(height: 40),
                                                // Mission Section wrapped in a SizedBox for inner layout control
                                                SizedBox(
                                                  height: 400,
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 24),
                                                      child: Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                          maxWidth:
                                                              800, // Limits width for better readability
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        // Mission row
                                                        child: Row(
                                                          children: [
                                                            // Left Image
                                                            Expanded(
                                                              flex: 2,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/aboutusimage.png',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 40),
                                                            // Right Text Content
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Our Mission",
                                                                    style: GoogleFonts
                                                                        .libreCaslonText(
                                                                      fontSize:
                                                                          26,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          12),
                                                                  Text(
                                                                    "We are a passionate team dedicated to creating meaningful experiences through innovative design and technology. Our mission is to connect people, inspire creativity, and empower communities. With a focus on user-centered solutions, we aim to bridge gaps, solve problems, and bring ideas to life.",
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      fontSize:
                                                                          14,
                                                                      color: const Color(
                                                                          0xffC8C8C8),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade, // Show ellipsis when overflowing
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {},
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              20,
                                                                          vertical:
                                                                              16),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(6),
                                                                      ),
                                                                      elevation:
                                                                          2,
                                                                    ),
                                                                    child: Text(
                                                                      "Contact us",
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            child: Container(
                                              width: double.infinity,
                                              color: const Color(0xff5A5A5A),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 40,
                                                      vertical: 40),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 24),
                                                  child: ConstrainedBox(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 800),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      // Prevent stretch
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            // Prevent unnecessary expansion
                                                            children: [
                                                              Text(
                                                                "What’s important to us",
                                                                style: GoogleFonts
                                                                    .libreCaslonText(
                                                                  fontSize: 26,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 16),
                                                              Text(
                                                                "We are a passionate team dedicated to creating meaningful experiences through innovative design and technology. Our mission is to connect people, inspire creativity, and empower communities.",
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontSize: 14,
                                                                  color: const Color(
                                                                      0xffC8C8C8),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                              const BuildValueItem(
                                                                  icon: Icons
                                                                      .people,
                                                                  title:
                                                                      "People",
                                                                  description:
                                                                      "Our goal is to build lasting relationships with clients and agents."),
                                                              const BuildValueItem(
                                                                  icon: Icons
                                                                      .handshake,
                                                                  title:
                                                                      "Service",
                                                                  description:
                                                                      "We adopt a mindset of abundance, prioritizing ethics over profits."),
                                                              const BuildValueItem(
                                                                  icon: Icons
                                                                      .star,
                                                                  title:
                                                                      "Integrity",
                                                                  description:
                                                                      "The core of every relationship lies in trust, professionalism, and excellence."),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 40),
                                                        Expanded(
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            child: Image.asset(
                                                              'assets/images/aboutusimage2.png',
                                                              fit: BoxFit.cover,
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

                                          Container(
                                            height: 530,
                                            width: double.infinity,
                                            color: const Color(0xff131313),
                                            padding: const EdgeInsets.all(20),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 24),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                    maxWidth:
                                                        800, // Limits width for better readability
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: IntrinsicHeight(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        // Left Side: Image
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/aboutusimage3.png',
                                                                  // Remove fixed height so it fills the available vertical space
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 40),

                                                        Expanded(
                                                          child: Form(
                                                            key: _formKey,
                                                            // Assign the key to the form
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Let's get in touch.",
                                                                  style: GoogleFonts
                                                                      .libreCaslonText(
                                                                    fontSize:
                                                                        26,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            _firstNameController,
                                                                        decoration:
                                                                            _inputDecoration('First Name'),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Please enter your first name";
                                                                          }
                                                                          return null;
                                                                        },
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Expanded(
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            _lastNameController,
                                                                        decoration:
                                                                            _inputDecoration('Last Name'),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                        validator:
                                                                            (value) {
                                                                          if (value == null ||
                                                                              value.isEmpty) {
                                                                            return "Please enter your last name";
                                                                          }
                                                                          return null;
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                TextFormField(
                                                                  controller:
                                                                      _phoneController,
                                                                  decoration:
                                                                      _inputDecoration(
                                                                          'Phone Number'),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .phone,
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return "Please enter your phone number";
                                                                    }
                                                                    if (!RegExp(
                                                                            r'^\d{10}$')
                                                                        .hasMatch(
                                                                            value)) {
                                                                      return "Enter a valid 10-digit phone number";
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                TextFormField(
                                                                  controller:
                                                                      _emailController,
                                                                  decoration:
                                                                      _inputDecoration(
                                                                          'Email'),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .emailAddress,
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return "Please enter your email";
                                                                    }
                                                                    if (!RegExp(
                                                                            r'^[^@]+@[^@]+\.[^@]+')
                                                                        .hasMatch(
                                                                            value)) {
                                                                      return "Enter a valid email address";
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                TextFormField(
                                                                  controller:
                                                                      _notesController,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        "Notes",
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Color(
                                                                          0xFFC8C8C8),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors
                                                                              .red,
                                                                          width:
                                                                              2),
                                                                    ),
                                                                    focusedErrorBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors
                                                                              .red,
                                                                          width:
                                                                              2),
                                                                    ),
                                                                    floatingLabelBehavior:
                                                                        FloatingLabelBehavior
                                                                            .auto,
                                                                    alignLabelWithHint:
                                                                        true,
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors
                                                                              .black,
                                                                          width:
                                                                              1),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                      borderSide: const BorderSide(
                                                                          color: Colors
                                                                              .blue,
                                                                          width:
                                                                              2),
                                                                    ),
                                                                  ),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  maxLines: 4,
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return "Please enter your notes";
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                    height: 20),
                                                                ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (_formKey
                                                                        .currentState!
                                                                        .validate()) {
                                                                      // All fields are valid, proceed with submission
                                                                      print(
                                                                          "Form submitted successfully!");
                                                                      // Add your submission logic here
                                                                    }
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            16),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                    ),
                                                                    elevation:
                                                                        2,
                                                                  ),
                                                                  child: Text(
                                                                    "Submit",
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
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
                                          // Values Section
                                          // Contact Section
                                          Stack(
                                            children: [
                                              Container(
                                                height: 340,
                                                width: double.infinity,
                                                color: Colors.grey[900],
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Top Row: Newsletter Subscription
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Left Side: Branding & Newsletter
                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "HOUSLY.PRO",
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontSize: 28,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              const Text(
                                                                "Subscribe to our newsletter for the latest recommendations, and news.",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xffE9E9E9)),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),

                                                              // Text Field with Arrow Inside
                                                              Container(
                                                                height: 40,
                                                                width: 425,
                                                                child:
                                                                    TextField(
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  // Ensures input text is white
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Email",
                                                                    hintStyle:
                                                                        GoogleFonts
                                                                            .inter(
                                                                      color: const Color(
                                                                          0xff919191),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        color: Color(
                                                                            0xff5A5A5A),
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        color: Color(
                                                                            0xff5A5A5A),
                                                                        width:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6),
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        color: Color(
                                                                            0xff5A5A5A),
                                                                        width:
                                                                            2,
                                                                      ),
                                                                    ),
                                                                    contentPadding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            16,
                                                                        vertical:
                                                                            14),
                                                                    suffixIcon:
                                                                        GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // Add action for arrow click
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              48,
                                                                          // Ensures it fits well inside
                                                                          height:
                                                                              double.infinity,
                                                                          // Matches TextField height
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                Color(0xff2F2F2F),
                                                                            borderRadius:
                                                                                BorderRadius.only(
                                                                              topRight: Radius.circular(6),
                                                                              bottomRight: Radius.circular(6),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            AppIcons.simpleArrowForward,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    suffixIconConstraints:
                                                                        const BoxConstraints(
                                                                      minWidth:
                                                                          40,
                                                                      minHeight:
                                                                          48, // Ensures proper alignment
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              const SizedBox(
                                                                  height: 10),

                                                              // Selectable Checkbox
                                                              CheckboxListTile(
                                                                value:
                                                                    _isChecked,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    _isChecked =
                                                                        value!;
                                                                  });
                                                                },
                                                                controlAffinity:
                                                                    ListTileControlAffinity
                                                                        .leading,
                                                                title:
                                                                    const Text(
                                                                  "I agree with our Terms of Service, Privacy Policy and our default Notification Settings.",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white70,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 20),
                                                        // Right Side: Links
                                                        const Expanded(
                                                          flex: 3,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              BuildFooterColumn(
                                                                  title:
                                                                      "Navigation Links",
                                                                  items: [
                                                                    "Buy",
                                                                    "Rent",
                                                                    "Sell",
                                                                    "Invest",
                                                                    "Build",
                                                                    "Recommended deals"
                                                                  ]),
                                                              BuildFooterColumn(
                                                                  title:
                                                                      "Categories",
                                                                  items: [
                                                                    "Flat",
                                                                    "Studio apartment",
                                                                    "Apartment",
                                                                    "Vacation homes",
                                                                    "Commercial spaces",
                                                                    "Luxury apartments",
                                                                    "Garages"
                                                                  ]),
                                                              BuildFooterColumn(
                                                                  title:
                                                                      "Terms and settings",
                                                                  items: [
                                                                    "Privacy Policy",
                                                                    "Terms and conditions",
                                                                    "Cookie Policy",
                                                                    "User Agreements"
                                                                  ]),
                                                              BuildFooterColumn(
                                                                  title:
                                                                      "About",
                                                                  items: [
                                                                    "About Hously",
                                                                    "How we work",
                                                                    "How we work"
                                                                  ]),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    // Copyright Text
                                                    const Center(
                                                      child: Text(
                                                        "Copyright © 2424 Hously. All rights reserved. Icons by Icons8",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white70,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                bottom: -27,
                                                left: 250,
                                                right: 250,
                                                child: Image.asset(
                                                  'assets/images/aboutusbottom.png',
                                                  // Replace with your actual image path
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

class BuildFooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;

  const BuildFooterColumn({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.mulish(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // Remove default padding
                alignment: Alignment.centerLeft, // Align text to the left
              ),
              child: Text(
                item,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xff919191),
                ),
              ),
            )),
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
          BuildTextButton(label: "BUY", onPressed: () {}),
          BuildTextButton(label: "RENT", onPressed: () {}),
          BuildTextButton(label: "SELL", onPressed: () {}),
          BuildTextButton(label: "INVEST", onPressed: () {}),
          BuildTextButton(label: "BUILD", onPressed: () {}),
        ],
      ),
    );
  }
}

class BuildTextButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const BuildTextButton({
    super.key,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.white.withOpacity(0.4);
                }
                return Colors.transparent;
              },
            ),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String number;
  final String text;

  const StatItem({
    super.key,
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xffC8C8C8),
          ),
        ),
      ],
    );
  }
}

// Divider Widget
class Divider extends StatelessWidget {
  const Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 2,
      color: Colors.white24,
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
      padding: const EdgeInsets.only(top: 16), // Fixed 'custom' to 'top'
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 11,
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
