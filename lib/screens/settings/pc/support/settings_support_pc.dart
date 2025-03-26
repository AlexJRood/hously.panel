import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/screens/settings/components/pc/components/settings_tile_providers.dart';
import 'package:hously_flutter/screens/settings/components/security_screen_button.dart';

import 'package:hously_flutter/screens/settings/components/pc/payment%20components%20pc/payment_pc_components.dart';
import 'package:hously_flutter/screens/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:hously_flutter/screens/settings/components/pc/support%20components%20pc/support_pc_components.dart';
import 'package:hously_flutter/theme/apptheme.dart';

class SettingsSupportPc extends ConsumerWidget {
  const SettingsSupportPc({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isToggled = ref.watch(toggleProvider);
    final List<Map<String, dynamic>> supportdata = [
      {
        'icondata': Icons.home_filled,
        'title': 'ACCOUNT SETTINGS',
        'description':
            'Adjust settings, manage notifications, learn more about name changes and more.',
      },
      {
        'icondata': Icons.home_filled,
        'title': 'ACCOUNT SETTINGS',
        'description':
            'Adjust settings, manage notifications, learn more about name changes and more.',
      },
      {
        'icondata': Icons.home_filled,
        'title': 'ACCOUNT SETTINGS',
        'description':
            'Adjust settings, manage notifications, learn more about name changes and more.',
      },
      {
        'icondata': Icons.home_filled,
        'title': 'ACCOUNT SETTINGS',
        'description':
            'Adjust settings, manage notifications, learn more about name changes and more.',
      },
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isToggled) ...[
              const SizedBox(height: 1),
            ],
            // Container holding the content
            Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.appBarGradientcustom(
                    context, ref),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Shrinkable spaces on the left and right
                  const Flexible(
                    flex: 5,
                    child: SizedBox(width: 5),
                  ),
                  // Main content column
                  Flexible(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dokumentacja Wsparcia'.tr,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Potrzebujesz pomocy z czymś? Sprawdź najczęściej zadawane pytania'
                              .tr,
                          style: TextStyle(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          style: TextStyle(
                              color: Theme.of(context).iconTheme.color),
                          decoration: InputDecoration(
                            fillColor: Theme.of(context)
                                .iconTheme
                                .color!
                                .withOpacity(0.2),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                                color: Theme.of(context).iconTheme.color!),
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Shrinkable spaces on the right
                  const Flexible(
                    flex: 5,
                    child: SizedBox(width: 5),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            HeadingText(text: 'Popular Topics'),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 202,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: supportdata.length,
                itemBuilder: (context, index) {
                  return Supportile(
                    iconData: supportdata[index]['icondata']!,
                    title: supportdata[index]['title']!,
                    description: supportdata[index]['description']!,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
