

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';

import '../../../state_managers/data/filter_provider.dart';
import '../../../state_managers/data/landing_page_provider.dart';
import 'filters_widget.dart';

import 'dart:ui' as ui;





class AppBarLandingPageWidget extends ConsumerWidget {
  const AppBarLandingPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);


      return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
              child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 20,
                      children: [
                        Text(
                          'BUY',
                      style: AppTextStyles.interSemiBold14Light50,
                        ),
                        Text(
                          'RENT',
                      style: AppTextStyles.interSemiBold14Light50,
                        ),
                        Text(
                          'SELL',
                      style: AppTextStyles.interSemiBold14Light50,
                        ),
                        Text(
                          'INVEST',
                      style: AppTextStyles.interSemiBold14Light50,
                        ),
                        Text(
                          'BUILD',
                      style: AppTextStyles.interSemiBold14Light50,
                        ),
                      ],
                    ),
                    Text(
                      'HOUSLY',
                      style: AppTextStyles.houslyAiLogo30,
                    )
                  ],
                ),
                );
      

  }
}
