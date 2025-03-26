import 'package:flutter/material.dart';
import 'package:hously_flutter/data/design/design.dart';

class HereToHelpWidget extends StatelessWidget {
  final double paddingDynamic;
  const HereToHelpWidget({super.key, required this.paddingDynamic});

  @override
  Widget build(BuildContext context) {
    final dynamicVerticalPadding = paddingDynamic / 2;
    return Container(
      width: double.infinity,
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: paddingDynamic, vertical: dynamicVerticalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Here to Help You Move Forward',
                    style: AppTextStyles.libreCaslonHeading.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(35, 35, 35, 1)),
                  ),
                  Container(
                    height: 48,
                    width: 247,
                    color: Colors.transparent,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Contact an Agent ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(35, 35, 35, 1),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: Color.fromRGBO(35, 35, 35, 1),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),

              /// **Fix: Using IntrinsicHeight to align all InfoCardWidgets**
              const IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // First InfoCard
                    Expanded(
                      child: InfoCardWidget(
                        title: 'Buy a home',
                        description:
                            'Buying a home is a big decision. Whether you\'re a\nfirst-time buyer or an experienced investor, we\nprovide the tools, insights, and AI-powered search\nto help you find the best deals on properties that\nmatch your needs.',
                        buttonText: 'Browse homes',
                      ),
                    ),

                    // First Divider
                    VerticalDivider(
                        width: 40,
                        thickness: 2,
                        color: Color.fromRGBO(200, 200, 200, 1)),

                    // Second InfoCard
                    Expanded(
                      child: InfoCardWidget(
                        title: 'Sell a home',
                        description:
                            'Ready to sell your property? We make the process\nsimple, fast, and profitable. Our platform connects\nyou with a wide network of buyers and helps you\nset the best price based on real-time market data.',
                        buttonText: 'See your options',
                      ),
                    ),

                    // Second Divider
                    VerticalDivider(
                        width: 40,
                        thickness: 2,
                        color: Color.fromRGBO(200, 200, 200, 1)),

                    // Third InfoCard
                    Expanded(
                      child: InfoCardWidget(
                        title: 'Rent a home',
                        description:
                            'Looking to rent? We have a wide selection of\nrental properties to fit your lifestyle and budget.\nFrom city apartments to suburban homes, find\nyour ideal space quickly with our tailored search\noptions.',
                        buttonText: 'Find rentals',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;

  const InfoCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.libreCaslonHeading.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 2,
          width: 62,
          color: const Color.fromRGBO(145, 145, 145, 1),
        ),
        const SizedBox(height: 12),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(22, 25, 32, 1),
                  Color.fromRGBO(34, 57, 62, 1),
                ]),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(233, 233, 233, 1)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
