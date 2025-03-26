import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/screens/go_pro/checkout/components/checkout_components.dart';
import 'package:hously_flutter/screens/go_pro/checkout/success_page.dart';
import 'package:hously_flutter/screens/go_pro/pc/components/faq.dart';
import 'package:hously_flutter/screens/go_pro/pc/components/features.dart';

import 'package:hously_flutter/screens/go_pro/pc/components/pro_cards.dart';
import 'package:hously_flutter/screens/go_pro/pc/components/const.dart';

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_logo.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';

class CheckoutPc extends ConsumerStatefulWidget {
  const CheckoutPc({super.key});

  @override
  ConsumerState<CheckoutPc> createState() => _CheckoutPcState();
}

class _CheckoutPcState extends ConsumerState<CheckoutPc> {
  List<FocusNode> checkoutnodes = List.generate(14, (index) => FocusNode());
  final TextEditingController cardNumbercontroller = TextEditingController();
  final TextEditingController experyDatecontroller = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String selectedtype = 'Monthly';
  String paymentmethod = 'Card';
  String? selectedCountrycard;

  @override
  void initState() {
    super.initState();
    checkoutnodes = List.generate(10, (_) => FocusNode());
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    double screenheight = MediaQuery.of(context).size.height;
    final theme = ref.watch(themeColorsProvider);
    final sideMenuKey = GlobalKey<SideMenuState>();
    return Scaffold(
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Row(
          children: [
            Sidebar(
              sideMenuKey: sideMenuKey,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    gradient: CustomBackgroundGradients.getMainMenuBackground(
                        context, ref)),
                child: Center(
                  child: Column(
                    children: [
                      const TopAppBarLogoRegisterPage(),
                      Container(
                        width: 950,
                        height: 650,
                        child: Row(
                          children: [
                            // Left Section: Plan Selection
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppIcons.arrowBack),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Back',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Premium Plan",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).iconTheme.color,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "We'll email you a reminder 3 days before your trial ends.",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!
                                              .withOpacity(0.7)),
                                    ),
                                    const SizedBox(height: 16),
                                    RadioListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      hoverColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      value: "Monthly",
                                      groupValue: selectedtype,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedtype = 'Monthly';
                                        });
                                      },
                                      activeColor:
                                          Theme.of(context).iconTheme.color,
                                      title: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Monthly",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text("All features for one month",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color!
                                                        .withOpacity(0.7),
                                                  )),
                                            ],
                                          ),
                                          const Spacer(),
                                          Text("\$89.00",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Divider(
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    RadioListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      hoverColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.1),
                                      value: "Yearly",
                                      groupValue: selectedtype,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedtype = 'Yearly';
                                        });
                                      },
                                      activeColor:
                                          Theme.of(context).iconTheme.color,
                                      title: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Yearly",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text("All features for one year",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color!
                                                        .withOpacity(0.7),
                                                  )),
                                            ],
                                          ),
                                          const Spacer(),
                                          Text("\$890.00",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Divider(
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text("Subtotal",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        const Spacer(),
                                        Text("\$89.00",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Text(
                                        "Add promotion code",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Divider(
                                        color: Theme.of(context)
                                            .iconTheme
                                            .color!
                                            .withOpacity(0.7)),
                                    const SizedBox(height: 10),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Text(
                                          "Total due today",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                              fontSize: 18),
                                        ),
                                        const Spacer(),
                                        Text("\$89.00",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Guaranteed to be safe & secure, ensuring that all transactions "
                                      "are protected with the highest level of security.",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!
                                              .withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Theme.of(context).iconTheme.color,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: theme.fillColor,
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child: Image.asset(
                                                  'assets/images/search.png',
                                                  scale: 10,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                'Continue with Google',
                                                style: TextStyle(
                                                    color: theme.textFieldColor,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'or',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Divider(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text("Payment method",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        children: [
                                          RadioListTile(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            value: "Card",
                                            groupValue: paymentmethod,
                                            onChanged: (value) {
                                              setState(() {
                                                paymentmethod = 'Card';
                                              });
                                            },
                                            activeColor: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            title: Text("Card",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color)),
                                          ),
                                          if (paymentmethod == 'Card') ...[
                                            GradientTextFieldcheckout(
                                              focusNode: checkoutnodes[0],
                                              reqNode: checkoutnodes[1],
                                              controller: cardNumbercontroller,
                                              hintText: 'Card Number',
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      GradientTextFieldcheckout(
                                                    focusNode: checkoutnodes[1],
                                                    reqNode: checkoutnodes[2],
                                                    controller:
                                                        experyDatecontroller,
                                                    hintText: 'MM/YY',
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child:
                                                      GradientTextFieldcheckout(
                                                    focusNode: checkoutnodes[2],
                                                    reqNode: checkoutnodes[3],
                                                    controller: cvvController,
                                                    hintText: 'CVV',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            GradientTextFieldcheckout(
                                              focusNode: checkoutnodes[3],
                                              reqNode: checkoutnodes[4],
                                              controller: nameController,
                                              hintText: 'Name on Card',
                                            ),
                                            const SizedBox(height: 8),
                                            GradientDropdownCountrycheckout(
                                              hintText: 'Country',
                                              countries: countries,
                                              selectedCountry:
                                                  selectedCountrycard,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedCountrycard = value;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Column(
                                        children: [
                                          RadioListTile(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            value: "PayPal",
                                            groupValue: paymentmethod,
                                            onChanged: (value) {
                                              setState(() {
                                                paymentmethod = 'PayPal';
                                              });
                                            },
                                            activeColor: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            title: Text("PayPal",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color)),
                                          ),
                                          const SizedBox(height: 16),
                                          if (paymentmethod == 'PayPal') ...[
                                            GradientDropdownCountrycheckout(
                                              hintText: 'Country',
                                              countries: countries,
                                              selectedCountry:
                                                  selectedCountrycard,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedCountrycard = value;
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                          ElevatedButton(
                                            onPressed: () {
                                              ref
                                                  .read(navigationService)
                                                  .pushNamedScreen(
                                                      Routes.success);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: theme.fillColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Subscribe',
                                                style: TextStyle(
                                                  color: theme.textFieldColor,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
