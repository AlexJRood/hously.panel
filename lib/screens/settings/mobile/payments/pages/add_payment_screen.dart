import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_appbar.dart';
import 'package:hously_flutter/screens/settings/components/mobile/mobile_settings_components.dart';
import 'package:hously_flutter/screens/settings/components/security_screen_button.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class AddPaymentScreen extends ConsumerWidget {
  const AddPaymentScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient:
                CustomBackgroundGradients.getMainMenuBackground(context, ref)),
        child: Column(
          children: [
            // AppBar Section
            MobileSettingsAppbar(
              title: "Add Payment",
              onPressed: () {
                ref.read(navigationService).beamPop();
              },
            ),

            // Scrollable Fields Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Weryfikacja dwuetapowa".tr,
                            style: TextStyle(color: theme.mobileTextcolor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Zabezpiecz swoje konto za pomocą weryfikacji dwuetapowej"
                                .tr,
                            style: TextStyle(
                                color: theme.mobileTextcolor, fontSize: 12)),
                        SizedBox(
                          height: 25,
                        ),
                        PaymentButton(
                          isPc: false,
                          icon: Icons.credit_card,
                          text: 'Card',
                          onPressed: () {
                            ref
                                .watch(navigationService)
                                .pushNamedScreen(Routes.addCard);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PaymentButton(
                          isPc: false,
                          icon: Icons.credit_card,
                          text: 'Paypal ',
                          onPressed: () {
                            ref.read(navigationService).pushNamedScreen(
                                  Routes.addCard,
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Fixed Bottom Button Section
          ],
        ),
      ),
    );
  }
}

class AddcardScreen extends ConsumerWidget {
  final bool isCard;
  const AddcardScreen({super.key, required this.isCard});

  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final TextEditingController _cardnumbercontroller = TextEditingController();
    final TextEditingController _expirycontroller = TextEditingController();
    final TextEditingController _cvvcontroller = TextEditingController();
    final TextEditingController _namecontroller = TextEditingController();
    final TextEditingController _paypalcontroller = TextEditingController();
    List<FocusNode> passwordfocusnode =
        List.generate(5, (index) => FocusNode());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient:
                CustomBackgroundGradients.getMainMenuBackground(context, ref)),
        child: Center(
          child: Column(
            children: [
              // AppBar Section
              MobileSettingsAppbar(
                title: "Dodaj płatności".tr,
                onPressed: () {
                  ref.read(navigationService).beamPop();
                },
              ),

              // Scrollable Fields Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dodaj metodę płatności".tr,
                              style: TextStyle(color: theme.mobileTextcolor)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              "Dokonuj płatności szybciej, zapisując metodę płatności"
                                  .tr,
                              style: TextStyle(
                                  color: theme.mobileTextcolor, fontSize: 12)),
                          SizedBox(
                            height: 10,
                          ),
                          if (isCard == true) ...[
                            GradientTextFieldMobile(
                                isSuffix: false,
                                focusNode: passwordfocusnode[0],
                                value: "",
                                reqNode: passwordfocusnode[1],
                                controller: _cardnumbercontroller,
                                hintText: "Card Number"),
                            GradientTextFieldMobile(
                                isSuffix: false,
                                focusNode: passwordfocusnode[1],
                                value: "",
                                reqNode: passwordfocusnode[2],
                                controller: _expirycontroller,
                                hintText: "MM/YY"),
                            GradientTextFieldMobile(
                                isObscure: true,
                                focusNode: passwordfocusnode[2],
                                value: "",
                                reqNode: passwordfocusnode[3],
                                controller: _cvvcontroller,
                                hintText: "CVV"),
                            GradientTextFieldMobile(
                                isSuffix: false,
                                focusNode: passwordfocusnode[3],
                                value: "",
                                reqNode: passwordfocusnode[4],
                                controller: _namecontroller,
                                hintText: "Name"),
                          ],
                          if (isCard == false) ...[
                            GradientTextFieldMobile(
                                isObscure: true,
                                focusNode: passwordfocusnode[0],
                                value: "",
                                reqNode: passwordfocusnode[1],
                                controller: _paypalcontroller,
                                hintText: "Paypal"),
                          ]
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
    );
  }
}
