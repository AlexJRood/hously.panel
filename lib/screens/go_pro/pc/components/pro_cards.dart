import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class PremiumCard extends ConsumerWidget {
  final double mainContainerHeight;
  final double innerContainerHeight;
  final String title;
  final String originalPrice;
  final String discountedPrice;
  final String pricingDescription;
  final List<String> features;
  final bool ispremium;
  final void Function()? onPressed;

  const PremiumCard({
    Key? key,
    this.ispremium = false,
    required this.onPressed,
    required this.mainContainerHeight,
    required this.innerContainerHeight,
    required this.title,
    required this.originalPrice,
    required this.discountedPrice,
    required this.pricingDescription,
    required this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);
    final currentthememode = ref.watch(themeColorsProvider);
    final thememodechecker = ref.watch(isDefaultDarkSystemProvider);
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main card container
          Container(
            padding:
                const EdgeInsets.only(top: 25, bottom: 2, right: 2, left: 2),
            decoration: BoxDecoration(
              color: thememodechecker
                  ? Colors.lightBlueAccent
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            height: mainContainerHeight,
            width: 300,
            child: Container(
              decoration: BoxDecoration(
                gradient:
                    CustomBackgroundGradients.textFieldGradient(context, ref),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.only(
                  left: 12, right: 12, bottom: 12, top: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ispremium
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: thememodechecker
                                  ? Colors.red
                                  : Colors.red.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Icon(
                              Icons.safety_check_sharp,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 30,
                        ),
                  // Title
                  Flexible(
                    child: Text(
                      title,
                      style:  TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 10),
                      // Original price
                      Flexible(
                        child: Text(
                          discountedPrice,
                          style:  TextStyle(
                            color:  Theme.of(context).iconTheme.color,
                            decoration: TextDecoration.lineThrough,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          originalPrice,
                          style:  TextStyle(
                            fontSize: 27,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      // Pricing description
                      Flexible(
                        child: Text(
                          pricingDescription,
                          style:  TextStyle(
                            fontSize: 14,
                            color:  Theme.of(context).iconTheme.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:theme.fillColor,
                            foregroundColor:theme.textFieldColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: onPressed,
                          child:  Text(
                            'Get Started',
                            style: TextStyle(color: theme.textFieldColor,
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(
                    color: Theme.of(context).iconTheme.color,
                  ),
                  const SizedBox(height: 12),
                   Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        'Features you`ll love:',
                        style: TextStyle(
                            fontSize: 14,
                            color:Theme.of(context).iconTheme.color,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer()
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: features
                        .map((feature) => featureItem(feature,context))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          // Yearly discount text
           Positioned(
            top: 5, // Adjust as needed
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Yearly Discount Deal',
                style: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget featureItem(String text,BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
           SvgPicture.asset(AppIcons.check, color: Theme.of(context).iconTheme.color, height: 18,width: 18,),
          const SizedBox(width: 8),
          // Ensure feature text wraps properly
          Flexible(
            child: Text(
              text,
              style:  TextStyle(color:Theme.of(context).iconTheme.color, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class RealEstateGoalsWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return Expanded(
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient:
              CustomBackgroundGradients.appBarGradientcustom(context, ref),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Osiągnij swoje cele w nieruchomościach dzięki odpowiedniemu planowi'
                  .tr,
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Elastyczne opcje dla agentów, inwestorów i osób prywatnych – ulepsz swoją podróż w świecie nieruchomości już dziś!'
                  .tr,
              style: TextStyle(
                color: Theme.of(context).iconTheme.color!.withOpacity(0.8),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
