import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/screens/settings/components/security_screen_button.dart';
import 'package:hously_flutter/screens/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:hously_flutter/screens/settings/components/pc/theme%20components%20pc/theme_pc_components.dart';

import 'package:hously_flutter/screens/settings/components/pro_theme_tile.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/theme/coloschemepicker.dart';

class SettingsThemePc extends ConsumerWidget {
  const SettingsThemePc({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final customtheme = ref.watch(isDefaultDarkSystemProvider);
    final currentthememode = ref.watch(themeProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    final proTheme = ref.watch(isDefaultDarkSystemProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadingText(text: 'Wyświetlacz'.tr),
            const SizedBox(height: 13),
            SubtitleText(
              text: 'Wybierz opcję, która odpowiada Twoim preferencjom'.tr,
            ),
            const SizedBox(height: 13),
            const ThemeTileSelector(),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 200,
                      maxHeight: 371, // Avoid fixed heights
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: proTheme
                                ? theme.bordercolor
                                : colorscheme == FlexScheme.blackWhite
                                    ? Theme.of(context).colorScheme.onSecondary
                                    : Theme.of(context).colorScheme.secondary,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HeadingText(
                                          text: 'Kolor niestandardowy'.tr),
                                      const SizedBox(height: 13),
                                      SubtitleText(
                                        text:
                                            'Uzyskaj dostęp do zaawansowanej personalizacji w wersji Pro'
                                                .tr,
                                      ),
                                      const SizedBox(height: 9),
                                      ThemeTile(
                                        gradient: CustomBackgroundGradients
                                            .getMainMenuBackground(
                                                context, ref),
                                        currentheme: currentthememode!,
                                        containercolor: customtheme
                                            ? Colors.white
                                            : Theme.of(context).primaryColor,
                                        secondcolor: customtheme
                                            ? Colors.lightBlueAccent
                                            : colorscheme ==
                                                    FlexScheme.blackWhite
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary
                                                : Theme.of(context)
                                                    .iconTheme
                                                    .color!
                                                    .withOpacity(0.8),
                                        title: 'Motyw niestandardowy'.tr,
                                        isSelected: customtheme ? true : false,
                                        groupValue: currentthememode,
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.transparent,
                                    ),
                                    height: 300,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Select a Color Scheme",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color)),
                                        const SizedBox(height: 15),
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                color: theme.fillColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: proTheme
                                                        ? theme.bordercolor
                                                        : colorscheme ==
                                                                FlexScheme
                                                                    .blackWhite
                                                            ? Theme.of(context)
                                                                .colorScheme
                                                                .onSecondary
                                                            : Theme.of(context)
                                                                .colorScheme
                                                                .secondary,
                                                    width: 2)),
                                            child: GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount:
                                                    4, // Number of items per row
                                                crossAxisSpacing:
                                                    10, // Space between columns
                                                mainAxisSpacing:
                                                    10, // Space between rows
                                                childAspectRatio:
                                                    1.55, // Aspect ratio of each item
                                              ),
                                              itemCount:
                                                  FlexScheme.values.length,
                                              itemBuilder: (context, index) {
                                                // Predefined color schemes
                                                final scheme =
                                                    FlexScheme.values[index];
                                                final colors =
                                                    currentthememode ==
                                                                ThemeMode
                                                                    .system ||
                                                            currentthememode ==
                                                                ThemeMode.light
                                                        ? FlexColor
                                                            .schemes[scheme]
                                                            ?.light
                                                        : FlexColor
                                                            .schemes[scheme]
                                                            ?.dark;

                                                if (colors == null) {
                                                  // Log or handle the null case for debugging
                                                  debugPrint(
                                                      'Colors for scheme ${scheme.name} are null');
                                                }

                                                return GestureDetector(
                                                  onTap: () async {
                                                    ref
                                                        .read(themeProvider
                                                            .notifier)
                                                        .state = (currentthememode ==
                                                                ThemeMode
                                                                    .system ||
                                                            currentthememode ==
                                                                ThemeMode.light)
                                                        ? ThemeMode.light
                                                        : ThemeMode.dark;
                                                    // Update the color scheme provider
                                                    await savecurrenttheme((ref
                                                        .read(themeProvider
                                                            .notifier)
                                                        .state = (currentthememode ==
                                                                ThemeMode
                                                                    .system ||
                                                            currentthememode ==
                                                                ThemeMode.light)
                                                        ? ThemeMode.light
                                                        : ThemeMode.dark));
                                                    ref
                                                        .read(
                                                            colorSchemeProvider
                                                                .notifier)
                                                        .state = scheme;
                                                    await saveColorScheme(
                                                        scheme,
                                                        currentthememode);
                                                    // Update the theme mode provider
                                                  },
                                                  child: ColorSchemeTile(
                                                    containerColor:
                                                        colors?.primary ??
                                                            Colors.blueAccent,
                                                    secondColor: Theme.of(
                                                                context)
                                                            .iconTheme
                                                            .color
                                                            ?.withOpacity(
                                                                0.8) ??
                                                        Colors.black
                                                            .withOpacity(0.8),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 40),
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.star_border,
                                    size: 16,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  label: Text(
                                    'Upgrade To Pro',
                                    style: TextStyle(
                                      color: Theme.of(context).iconTheme.color,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                    ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
