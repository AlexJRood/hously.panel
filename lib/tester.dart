import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/settings/components/pc/profile%20components%20pc/profile_pc_components.dart';
import 'package:hously_flutter/screens/settings/components/pc/theme%20components%20pc/theme_pc_components.dart';
import 'package:hously_flutter/screens/settings/components/pro_theme_tile.dart';
import 'package:hously_flutter/screens/settings/components/security_screen_button.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/theme/coloschemepicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';

final themeModeNotifier = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class ThemeTestScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentthememode = ref.watch(themeProvider);
    final colorScheme = ref.watch(colorSchemeProvider);

    final themeModeNotifier = ref.read(themeProvider.notifier);

    final scheme = theme.colorScheme;

    final themee = ref.watch(themeColorsProvider);
    final customtheme = ref.watch(isDefaultDarkSystemProvider);

    final colorscheme = ref.watch(colorSchemeProvider);
    final proTheme = ref.watch(isDefaultDarkSystemProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Theme Test")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
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
                        gradient: currentthememode == ThemeMode.dark &&
                                colorScheme == null
                            ? const LinearGradient(
                                colors: [Colors.black, Colors.black],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              )
                            : LinearGradient(
                                colors: [Colors.black, Colors.black],
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
                          savecurrentthemeDark(ref);
                        }),
                  ),
                  const SizedBox(width: 16),
                  if (currentthememode != ThemeMode.system &&
                      colorScheme != null) ...[
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
                    // const SizedBox(width: 16),
                    // Flexible(
                    //   flex: 3,
                    //   fit: FlexFit.loose,
                    //   child: ThemeTile(
                    //       gradient: LinearGradient(
                    //         colors: [
                    //           scheme.primary.withOpacity(0.5),
                    //           scheme.secondary.withOpacity(0.5),
                    //         ],
                    //         begin: Alignment.topLeft,
                    //         end: Alignment.bottomRight,
                    //       ),
                    //       title: 'Custom Dark Theme'.tr,
                    //       containercolor: Colors.white,
                    //       secondcolor: Colors.grey,
                    //       currentheme: ThemeMode.light,
                    //       isSelected:
                    //           currentthememode == ThemeMode.dark,
                    //       groupValue: currentthememode,
                    //       onTap: () {
                    //         themeModeNotifier.state = ThemeMode.light;
                    //         savecurrenttheme(ThemeMode.light);
                    //       }),
                    // ),
                  ],
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kolor niestandardowy'.tr),
                      const SizedBox(height: 13),
                      Text(
                        'Uzyskaj dostęp do zaawansowanej personalizacji w wersji Pro'
                            .tr,
                      ),
                      const SizedBox(height: 9),
                      ThemeTile(
                        gradient:
                            CustomBackgroundGradients.getMainMenuBackground(
                                context, ref),
                        currentheme: currentthememode!,
                        containercolor: customtheme
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        secondcolor: customtheme
                            ? Colors.lightBlueAccent
                            : colorscheme == FlexScheme.blackWhite
                                ? Theme.of(context).colorScheme.onSecondary
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select a Color Scheme",
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: themee.fillColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: proTheme
                                        ? themee.bordercolor
                                        : colorscheme == FlexScheme.blackWhite
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
                                crossAxisCount: 4, // Number of items per row
                                crossAxisSpacing: 10, // Space between columns
                                mainAxisSpacing: 10, // Space between rows
                                childAspectRatio:
                                    1.55, // Aspect ratio of each item
                              ),
                              itemCount: FlexScheme.values.length,
                              itemBuilder: (context, index) {
                                // Predefined color schemes
                                final scheme = FlexScheme.values[index];
                                final colors =
                                    currentthememode == ThemeMode.system ||
                                            currentthememode == ThemeMode.light
                                        ? FlexColor.schemes[scheme]?.light
                                        : FlexColor.schemes[scheme]?.dark;

                                if (colors == null) {
                                  // Log or handle the null case for debugging
                                  debugPrint(
                                      'Colors for scheme ${scheme.name} are null');
                                }

                                return GestureDetector(
                                  onTap: () async {
                                    ref.read(themeProvider.notifier).state =
                                        (currentthememode == ThemeMode.system ||
                                                currentthememode ==
                                                    ThemeMode.light)
                                            ? ThemeMode.light
                                            : ThemeMode.dark;
                                    // Update the color scheme provider
                                    await savecurrenttheme((ref
                                        .read(themeProvider.notifier)
                                        .state = (currentthememode ==
                                                ThemeMode.system ||
                                            currentthememode == ThemeMode.light)
                                        ? ThemeMode.light
                                        : ThemeMode.dark));
                                    ref
                                        .read(colorSchemeProvider.notifier)
                                        .state = scheme;
                                    await saveColorScheme(
                                        scheme, currentthememode);
                                    // Update the theme mode provider
                                  },
                                  child: ColorSchemeTile(
                                    containerColor:
                                        colors?.primary ?? Colors.blueAccent,
                                    secondColor: Theme.of(context)
                                            .iconTheme
                                            .color
                                            ?.withOpacity(0.8) ??
                                        Colors.black.withOpacity(0.8),
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
            const Divider(),
            Text("Buttons",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {},
                child: Text("Elevated Button",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface))),
            OutlinedButton(
                onPressed: () {}, child: const Text("Outlined Button")),
            TextButton(onPressed: () {}, child: const Text("Text Button")),
            IconButton(onPressed: () {}, icon: const Icon(Icons.star)),
            FloatingActionButton(
                onPressed: () {}, child: const Icon(Icons.add)),
            const Divider(),
            Text("Inputs",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 10),
            const TextField(
                decoration: InputDecoration(labelText: "TextField")),
            TextFormField(
                decoration: const InputDecoration(labelText: "TextFormField")),
            DropdownButtonFormField(
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration:
                  const InputDecoration(labelText: "Dropdown Form Field"),
              value: "Option 1",
              onChanged: (val) {},
              items: ["Option 1", "Option 5", "Option 3"].map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
            ),
            const Divider(),
            Text("Selection Controls",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 10),
            Switch(value: true, onChanged: (val) {}),
            Switch(value: false, onChanged: (val) {}),
            Checkbox(value: true, onChanged: (val) {}),
            Radio(value: 1, groupValue: 1, onChanged: (val) {}),
            ToggleButtons(
              isSelected: [true, false, false],
              onPressed: (index) {},
              children: const [
                Icon(Icons.format_bold),
                Icon(Icons.format_italic),
                Icon(Icons.format_underline)
              ],
            ),
            const Divider(),
            Text("Sliders & Dropdowns",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 10),
            Slider(value: 0.5, onChanged: (val) {}),
            DropdownButton(
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              value: "Option 1",
              onChanged: (val) {},
              items: ["Option 1", "Option 2", "Option 3"].map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
            ),
            const Divider(),
            Text("Containers & Cards",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Container with Card Color",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "This is a Card",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
    );
  }
}

class ShimmerTesterScreen extends StatelessWidget {
  const ShimmerTesterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Tester'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 800, child: ThemeTestScreen()),
              const Text('Carousel Loading'),
              SizedBox(height: 800, child: Carouselloading(height: 200)),
              const SizedBox(height: 20),
              const Text('Shimmer Loading Row'),
              SizedBox(
                height: 800,
                child: ShimmerLoadingRow(
                  itemWidth: 100,
                  itemHeight: 100,
                  placeholderwidget:
                      ShimmerPlaceholder(width: 100, height: 100),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Shimmer Effect Settings Photo'),
              const SizedBox(height: 800, child: ShimmerEffectSettingsPhoto()),
              const SizedBox(height: 20),
              const Text('Shimmer Placeholder Circle'),
              const SizedBox(
                  height: 800, child: ShimmerPlaceholdercircle(radius: 50)),
              const SizedBox(height: 20),
              const Text('Shimmer Placeholder Without Width'),
              const SizedBox(
                  height: 800,
                  child: ShimmerPlaceholderwithoutwidth(height: 50)),
              const SizedBox(height: 20),
              const Text('Shimmer Placeholder Mobile'),
              const SizedBox(height: 800, child: ShimmerPlaceholdermobile()),
              const SizedBox(height: 20),
              const Text('Shimmer Advertisement List Full'),
              // SizedBox(
              //   height: 800,
              //   child: ShimmerAdvertisementlistFull(
              //       scrollController: ScrollController()),
              // ),
              // const SizedBox(height: 20),
              // const Text('Shimmer Advertisement Grid'),
              // SizedBox(
              //   height: 800,
              //   child: ShimmerAdvertisementGrid(
              //     scrollController: ScrollController(),
              //     crossAxisCount: 2,
              //   ),
              // ),
              const SizedBox(height: 20),
              const Text('Shimmer Placeholder With Text'),

              // const SizedBox(height: 20),
              const Text('Shimmer Advertisements List PC'),
              SizedBox(
                height: 800,
                child: ShimmerAdvertisementsListPc(
                  adFiledSize: 300,
                  scrollController: ScrollController(),
                  dynamicPadding: 8.0,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Shimmer Advertisements List Mobile'),
              SizedBox(
                height: 800,
                child: ShimmerAdvertisementsListmobile(
                  adFiledSize: 300,
                  scrollController: ScrollController(),
                  dynamicPadding: 8.0,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Notification Card Shimmer'),
              const SizedBox(height: 800, child: NotificationCardShimmer()),
            ],
          ),
        ),
      ),
    );
  }
}
