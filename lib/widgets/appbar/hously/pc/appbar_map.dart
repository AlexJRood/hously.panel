import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/pop_pages/sort_pop_page.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/screens/pop_pages/view_settings_page.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'searchbar.dart' as custom_search_bar;

class TopAppBarMap extends ConsumerWidget {
  const TopAppBarMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey coToMaRobicTopAppBarMap = GlobalKey();
    final GlobalKey viewChangerButtonTopAppBarMap = GlobalKey();
    final GlobalKey sortButtonTopAppBarMap = GlobalKey();
    final screenWidth = MediaQuery.of(context).size.width;
    final widthRatio = screenWidth / 1920.0;
    final dynamicSizedBoxWidth = 150.0 * widthRatio - 50;
    final colorScheme = ref.watch(colorSchemeProvider);
    final currentthememode = ref.watch(themeProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: dynamicSizedBoxWidth),
          ElevatedButton(
            style: elevatedButtonStyleRounded,
            onPressed: () {
              final RenderBox? buttonRenderBox =
                  coToMaRobicTopAppBarMap.currentContext?.findRenderObject()
                      as RenderBox?;
              if (buttonRenderBox == null) return;
              final Offset buttonPosition =
                  buttonRenderBox.localToGlobal(Offset.zero);
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (_, __, ___) =>
                      ViewSettingsPage(buttonPosition: buttonPosition),
                  transitionsBuilder: (_, anim, __, child) {
                    return FadeTransition(opacity: anim, child: child);
                  },
                ),
              );
            },
            child: Hero(
              tag: 'CoToMaRobic', // Dodajemy Hero z tym samym tagiem
              child: Container(
                key: coToMaRobicTopAppBarMap,
                height: 35,
                width: 35,
                color: Colors.transparent,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    if (colorScheme != null &&
                        currentthememode != ThemeMode.system) {
                      // Return a gradient based on the color scheme
                      return CustomBackgroundGradients.appBarGradientcustom(
                              context, ref)
                          .createShader(bounds);
                    } else {
                      // Fallback gradient when colorScheme is null or currentthememode is system
                      return BackgroundGradients.appBarGradient
                          .createShader(bounds);
                    }
                  },
                  child: Icon(Icons.pie_chart,
                      color: Theme.of(context).iconTheme.color, size: 30.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: custom_search_bar.SearchBar(),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                style: elevatedButtonStyleRounded,
                onPressed: () {
                  final RenderBox? buttonRenderBox =
                      sortButtonTopAppBarMap.currentContext?.findRenderObject()
                          as RenderBox?;
                  if (buttonRenderBox == null) return;
                  final Offset buttonPosition =
                      buttonRenderBox.localToGlobal(Offset.zero);
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) =>
                          SortPopPage(buttonPosition: buttonPosition),
                      transitionsBuilder: (_, anim, __, child) {
                        return FadeTransition(opacity: anim, child: child);
                      },
                    ),
                  );
                },
                child: Hero(
                  tag: 'SortBarButton', // Dodajemy Hero z tym samym tagiem
                  child: Container(
                    key: sortButtonTopAppBarMap,
                    height: 35,
                    width: 35,
                    color: Colors.transparent,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        if (colorScheme != null &&
                            currentthememode != ThemeMode.system) {
                          // Return a gradient based on the color scheme
                          return CustomBackgroundGradients.appBarGradientcustom(
                                  context, ref)
                              .createShader(bounds);
                        } else {
                          // Fallback gradient when colorScheme is null or currentthememode is system
                          return BackgroundGradients.appBarGradient
                              .createShader(bounds);
                        }
                      },
                      child: Icon(Icons.sort,
                          color: Theme.of(context).iconTheme.color, size: 30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                style: elevatedButtonStyleRounded,
                onPressed: () {
                  final RenderBox? buttonRenderBox =
                      viewChangerButtonTopAppBarMap.currentContext
                          ?.findRenderObject() as RenderBox?;
                  if (buttonRenderBox == null) return;
                  final Offset buttonPosition =
                      buttonRenderBox.localToGlobal(Offset.zero);
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) =>
                          ViewPopChangerPage(buttonPosition: buttonPosition),
                      transitionsBuilder: (_, anim, __, child) {
                        return FadeTransition(opacity: anim, child: child);
                      },
                    ),
                  );
                },
                child: Hero(
                  tag:
                      'ViewChangerBarButton', // Dodajemy Hero z tym samym tagiem
                  child: Container(
                    key: viewChangerButtonTopAppBarMap,
                    height: 35,
                    width: 35,
                    color: Colors.transparent,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        if (colorScheme != null &&
                            currentthememode != ThemeMode.system) {
                          // Return a gradient based on the color scheme
                          return CustomBackgroundGradients.appBarGradientcustom(
                                  context, ref)
                              .createShader(bounds);
                        } else {
                          // Fallback gradient when colorScheme is null or currentthememode is system
                          return BackgroundGradients.appBarGradient
                              .createShader(bounds);
                        }
                      },
                      child: Icon(Icons.view_module,
                          color: Theme.of(context).iconTheme.color, size: 30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          SizedBox(
            width: dynamicSizedBoxWidth,
          )
        ],
      ),
    );
  }
}
