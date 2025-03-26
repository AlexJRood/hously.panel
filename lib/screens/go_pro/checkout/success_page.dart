import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/screens/go_pro/checkout/components/checkout_components.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';

class PaymentSuccessPage extends ConsumerWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    final sideMenuKey = GlobalKey<SideMenuState>();
    return Scaffold(
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Row(
          children: [
            Sidebar(sideMenuKey: sideMenuKey),
            Expanded(
              child: Container(
                color: theme.checkoutbackground,
                child: Column(
                  children: [
                    const TopAppBar(), // Place the TopAppBar at the top
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                    'assets/images/success_image.png',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Payment Successful!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Congratulations! Welcome to HOUSLY Pro.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color:
                                            colorscheme == FlexScheme.blackWhite
                                                ? Colors.blue
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: 400,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Successpagebutton(
                                          buttonheight: 40,
                                          onTap: () {},
                                          text: 'Download Invoice',
                                          hasicon: true,
                                          isborder: true,
                                          backgroundcolor: false,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Successpagebutton(
                                          buttonheight: 40,
                                          onTap: () {
                                            ref
                                                .read(navigationService)
                                                .pushNamedScreen(
                                                    Routes.homepage);
                                          },
                                          text: 'Go to Dashboard',
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
            ),
          ],
        ),
      ),
    );
  }
}
