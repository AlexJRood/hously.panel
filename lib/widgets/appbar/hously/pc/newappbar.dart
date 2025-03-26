//lib/components/appbar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart'; 
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/screens/pop_pages/view_settings_page.dart';
import 'package:hously_flutter/widgets/appbar/widgets/logo_hously.dart';

import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'searchbargrid_pc.dart'
    as custom_search_bar_grid; // Używamy prefiksu CustomSearchBar

class TopAppBarGridPc extends StatelessWidget {
  const TopAppBarGridPc({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double maxWidth = 1920;
    const double minWidth = 480;
    const double maxLogoSize = 30;
    const double minLogoSize = 16;
    double logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) +
        minLogoSize;
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LogoHouslyWidget(),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final void Function()? onpressed;

  const FilterButton({required this.label, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xff5794DD).withOpacity(.2),
        // Match the dark button design
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextButton(
          onPressed: onpressed,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}

class ButtonTextRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTextButton("BUY", () {}),
          buildTextButton("RENT", () {}),
          buildTextButton("SELL", () {}),
          buildTextButton("INVEST", () {}),
          buildTextButton("BUILD", () {}),
        ],
      ),
    );
  }

  Widget buildTextButton(String label, void Function()? onpressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: TextButton(
        onPressed: onpressed,
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

Widget adsViewTopAppBar(BuildContext context, WidgetRef ref) {
  final GlobalKey coToMaRobicTopAppBar = GlobalKey();
  final GlobalKey viewChangerButtonTopAppBar = GlobalKey();
  double screenWidth = MediaQuery.of(context).size.width;
  final iconcolor = Theme.of(context).iconTheme.color;
  const double maxWidth = 1920;
  const double minWidth = 480;
  const double maxLogoSize = 30;
  const double minLogoSize = 16;
  double logoSize = (screenWidth - minWidth) /
          (maxWidth - minWidth) *
          (maxLogoSize - minLogoSize) +
      minLogoSize;
  logoSize = logoSize.clamp(minLogoSize, maxLogoSize);

  return Container(
    color: Colors.transparent,
    child: Row(
      children: [
        ElevatedButton(
          style: elevatedButtonStyleRounded,
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (_, __, ___) => const ViewSettingsPage(),
                transitionsBuilder: (_, anim, __, child) {
                  return FadeTransition(opacity: anim, child: child);
                },
              ),
            );
          },
          child: Hero(
            tag: 'CoToMaRobic',
            child: Container(
              key: coToMaRobicTopAppBar,
              height: 35,
              width: 35,
              color: Colors.transparent,
              child: Row(
                children: [
                  Icon(Icons.pie_chart, size: 30.0, color: iconcolor),
                ],
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: elevatedButtonStyleRounded,
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (_, __, ___) => const ViewPopChangerPage(),
                transitionsBuilder: (_, anim, __, child) {
                  return FadeTransition(opacity: anim, child: child);
                },
              ),
            );
          },
          child: Hero(
            tag: 'ViewChangerBarButton',
            child: Container(
              key: viewChangerButtonTopAppBar,
              height: 35,
              width: 35,
              color: Colors.transparent,
              child: const Row(
                children: [
                  Icon(
                    Icons.view_comfortable_rounded,
                    size: 30.0,
                    color: AppColors.light,
                  ),
                ],
              ),
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: custom_search_bar_grid.SearchBarGridpc(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              FilterButton(
                label: "Property Type",
                onpressed: () {},
              ),
              const SizedBox(width: 5),
              FilterButton(
                label: "Price",
                onpressed: () {},
              ),
              const SizedBox(width: 5),
              FilterButton(
                label: "Room",
                onpressed: () {},
              ),
              const SizedBox(width: 5),
              FilterButton(
                label: "Floor area",
                onpressed: () {},
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () =>
                    ref.read(navigationService).pushNamedScreen(Routes.filters),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xff5794DD).withOpacity(.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.filter_list, color: Colors.white),
                              onPressed: () {
                                // Handle filter icon press
                              },
                            ),
                            const Text(
                              "Filters",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
