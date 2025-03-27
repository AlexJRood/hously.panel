import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/appbar/appbar_pc.dart';
import 'package:hously_flutter/widgets/bars/bottom_bar.dart';
import 'package:hously_flutter/widgets/bars/sidebar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:pie_menu/pie_menu.dart';

class BarManager extends ConsumerWidget {
  final List<Widget> children;
  final GlobalKey<SideMenuState> sideMenuKey;
  final bool isBarHoveroverUI;

  const BarManager({
    super.key,
    required this.children,
    required this.sideMenuKey,
    this.isBarHoveroverUI = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    // 💻 DESKTOP
    return SafeArea(
      child: PieCanvas(
        theme: const PieTheme(
          rightClickShowsMenu: true,
          leftClickShowsMenu: false,
          buttonTheme: PieButtonTheme(
            backgroundColor: AppColors.buttonGradient1,
            iconColor: Colors.white,
          ),
          buttonThemeHovered: PieButtonTheme(
            backgroundColor: Color.fromARGB(96, 58, 58, 58),
            iconColor: Colors.white,
          ),
        ),
        child: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Stack(
            children: [
              if (!isMobile) ...[
                Container(
                  color: AppColors.dark,
                  child: Row(
                    children: [
                      Sidebar(sideMenuKey: sideMenuKey),
                      Expanded(
                        child: Column(
                          children: [
                            if (!isBarHoveroverUI)
                                const SizedBox(height:60),

                            if (children.isEmpty)
                                const Center(child: Text("Brak danych — dodaj lead")),
                                                      
                            ...children,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  top: 0,
                  right: 0,
                  left: 60,
                  child: TopAppBar(),
                ),
              ],
              if (isMobile) ...[
                // 📱 MOBILE

                Container(
                  color: AppColors.dark,
                  child: Column(
                    children: [            
                    if (!isBarHoveroverUI)
                        const SizedBox(height:60),
            
                    if (children.isEmpty)
                        const Center(child: Text("Brak danych — dodaj lead")),
                    ...children,
                    ],
                  ),
                ),
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: TopAppBar(),
                ),
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomBarMobile(),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
