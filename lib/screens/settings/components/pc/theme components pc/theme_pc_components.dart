import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

import 'package:hously_flutter/theme/apptheme.dart';

import 'package:hously_flutter/theme/coloschemepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeTileSelector extends ConsumerStatefulWidget {
  const ThemeTileSelector({super.key});

  @override
  ConsumerState<ThemeTileSelector> createState() => _ThemeTileSelectorState();
}

class _ThemeTileSelectorState extends ConsumerState<ThemeTileSelector> {
  @override
  @override
  Widget build(BuildContext context) {
    final currentthememode = ref.watch(themeProvider);
    final colorScheme = ref.watch(colorSchemeProvider);

    final themeModeNotifier = ref.read(themeProvider.notifier);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            fit: FlexFit.loose,
            child: ThemeTile(
                gradient: BackgroundGradients.backgroundGradientRight,
                currentheme: ThemeMode.system,
                containercolor: Colors.white,
                secondcolor: Colors.black,
                title: 'Motyw systemowy'.tr,
                isSelected: currentthememode == ThemeMode.system,
                groupValue: currentthememode!,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('colorScheme');
                  final colorSchemeNotifier =
                      ref.read(colorSchemeProvider.notifier);
                  colorSchemeNotifier.state = null;
                  themeModeNotifier.state = ThemeMode.system;
                  savecurrenttheme(ThemeMode.system);
                }),
          ),
          const SizedBox(width: 16),
          Flexible(
            flex: 3,
            fit: FlexFit.loose,
            child: ThemeTile(
                gradient:
                    currentthememode == ThemeMode.dark && colorScheme == null
                        ? const LinearGradient(
                            colors: [
                              AppColors.backgroundgradient1Light,
                              AppColors.backgroundgradient2Light
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          )
                        : LinearGradient(
                            colors: [scheme.primary, Colors.black],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                containercolor: Colors.black,
                secondcolor: Colors.white,
                currentheme: ThemeMode.dark,
                title: 'Ciemny motyw'.tr,
                isSelected: currentthememode == ThemeMode.dark,
                groupValue: currentthememode,
                onTap: () {
                  themeModeNotifier.state = ThemeMode.dark;
                  savecurrenttheme(ThemeMode.dark);
                }),
          ),
          const SizedBox(width: 16),
          if (currentthememode != ThemeMode.system && colorScheme != null) ...[
            Flexible(
              flex: 3,
              fit: FlexFit.loose,
              child: ThemeTile(
                  gradient: LinearGradient(
                    colors: [
                      scheme.primary.withOpacity(0.5),
                      scheme.secondary.withOpacity(0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  title: 'Light Theme'.tr,
                  containercolor: Colors.white,
                  secondcolor: Colors.grey,
                  currentheme: ThemeMode.light,
                  isSelected: currentthememode == ThemeMode.light,
                  groupValue: currentthememode,
                  onTap: () {
                    themeModeNotifier.state = ThemeMode.light;
                    savecurrenttheme(ThemeMode.light);
                  }),
            ),
          ],
          const Expanded(flex: 5, child: SizedBox()),
        ],
      ),
    );
  }
}

class ThemeTile extends ConsumerWidget {
  final ThemeMode currentheme;
  final String title;
  final bool isSelected;
  final ThemeMode groupValue; // Added groupValue here
  final VoidCallback onTap;
  final Color containercolor;
  final Color secondcolor;
  final Gradient gradient;

  const ThemeTile({
    super.key,
    required this.gradient,
    required this.currentheme,
    required this.containercolor,
    required this.secondcolor,
    required this.title,
    required this.isSelected,
    required this.groupValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final proTheme = ref.watch(isDefaultDarkSystemProvider);
    final colorscheme = ref.watch(colorSchemeProvider);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 230,
        height: 197,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          gradient: gradient,
          border: Border.all(
            color: isSelected
                ? proTheme
                    ? theme.bordercolor
                    : colorscheme == FlexScheme.blackWhite
                        ? Colors.lightBlueAccent
                        : Theme.of(context).colorScheme.secondary
                : Theme.of(context).iconTheme.color!,
            width: 3,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 6,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: Container(
                width: 150,
                height: 96,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: containercolor,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(width: 2, color: secondcolor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: secondcolor,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      // Use Expanded to prevent overflow
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width:
                                double.infinity, // Make it expand to the width
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: secondcolor,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              const SizedBox(width: 4),
                              CircleAvatar(
                                radius: 5,
                                backgroundColor: secondcolor,
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                // Use Expanded for flexible space
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 3,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: secondcolor),
                                    ),
                                    const SizedBox(height: 2),
                                    Container(
                                      height: 10,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: secondcolor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 53,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: secondcolor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).iconTheme.color,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio<ThemeMode>(
                    value: currentheme,
                    groupValue: groupValue,
                    activeColor: theme.textFieldColor,
                    onChanged: (_) => onTap(),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    // Make sure the title does not overflow
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: theme.textFieldColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
