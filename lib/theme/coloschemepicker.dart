import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showColorSchemeDialog(
    BuildContext context, WidgetRef ref, ThemeMode currenttheme) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          width: 300,
          height: 300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select a Color Scheme",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 3 items per row
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1, // Square containers
                      ),
                      itemCount: FlexScheme.values.length,
                      itemBuilder: (context, index) {
                        // Predefined color schemes
                        final scheme = FlexScheme.values[index];
                        final colors = currenttheme == ThemeMode.system ||
                                currenttheme == ThemeMode.light
                            ? FlexColor.schemes[scheme]?.light
                            : FlexColor.schemes[scheme]?.dark;

                        return GestureDetector(
                          onTap: () async {
                            // Save the selected color scheme   await savecurrenttheme(

                            ref.read(themeProvider.notifier).state =
                                (currenttheme == ThemeMode.system ||
                                        currenttheme == ThemeMode.light)
                                    ? ThemeMode.light
                                    : ThemeMode.dark;
                            // Update the color scheme provider
                            await savecurrenttheme((ref
                                .read(themeProvider.notifier)
                                .state = (currenttheme == ThemeMode.system ||
                                    currenttheme == ThemeMode.light)
                                ? ThemeMode.light
                                : ThemeMode.dark));
                            ref.read(colorSchemeProvider.notifier).state =
                                scheme;
                            await saveColorScheme(scheme, currenttheme);
                            // Update the theme mode provider

                            Navigator.pop(context); // Close dialog
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  colors?.primary ?? Colors.grey,
                                  colors?.primary ?? Colors.grey,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> saveColorScheme(FlexScheme? scheme, ThemeMode currenttheme) async {
  final prefs = await SharedPreferences.getInstance();
  if (scheme != null) {
    await prefs.setString('colorScheme', scheme.name);

    print(currenttheme.name);
  } else {
    await prefs.remove('colorScheme');
  }
}

Future<void> savecurrenttheme(ThemeMode currenttheme) async {
  final prefs = await SharedPreferences.getInstance();

  if (currenttheme != null) {
    await prefs.setString('currentheme', currenttheme.name);

    print(currenttheme.name);
  } else {
    await prefs.remove('currentheme');
  }
}

Future<void> saveCustomColor(Color color) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('customColor', color.value); // Save color as int
}
