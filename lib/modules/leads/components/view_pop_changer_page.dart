import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/theme/design/button_style.dart';

final selectedFeedViewProvider = StateProvider<String>(
    (ref) => Routes.leadsPanel); // Domyślnie ustawione na '/feedview'

class LeadViewPopChangerPage extends ConsumerStatefulWidget {
  final Offset? buttonPosition;
  const LeadViewPopChangerPage({super.key, this.buttonPosition});

  @override
  ViewPopPageChangerState createState() => ViewPopPageChangerState();
}

class ViewPopPageChangerState extends ConsumerState<LeadViewPopChangerPage> {
  late TextEditingController searchController;
  late TextEditingController excludeController;
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Oblicz proporcję szerokości
    // double widthRatio = screenWidth / 1920.0;

    // Oblicz szerokość dla dynamicznego SizedBox
    //  double dynamicSizedBoxWidth = screenWidth * 0.5;
    //  double dynamicSizedBoxHeight = screenHeight * 0.5;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Ta część odpowiada za efekt rozmycia tła
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Obsługa dotknięcia w dowolnym miejscu aby zamknąć modal
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Zawartość modalu
          Hero(
            tag: 'ViewChangerBarButton-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag 
            child: Padding(
              padding: widget.buttonPosition != null
                  ? EdgeInsets.only(
                      left: widget.buttonPosition!.dx,
                      top: widget.buttonPosition!.dy)
                  : EdgeInsets.only(
                      right: screenWidth * 0.2 - 45, top: screenHeight * 0.05),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  width: screenWidth * 0.2 <= 500 ? 450 : 450,
                  height: screenHeight * 0.8,
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Text(
                                'Wybierz widok wyszukiwania'.tr,
                                style: TextStyle(
                                  color: Theme.of(context).iconTheme.color,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // const SizedBox(height: 10),
                            ElevatedButton(
                              style: buttonSearchBar,
                              onPressed: () {
                                ref.read(navigationService).pushNamedScreen(
                                      Routes.leadsPanel,
                                    );
                                ref
                                    .read(selectedFeedViewProvider.notifier)
                                    .state = Routes.leadsPanel;
                                    Navigator.of(context).pop();
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 320,
                                      height: 180,
                                      child: Image.asset(
                                          'assets/images/view/lead_list.webp'),
                                    ),
                                    const SizedBox(height: 10),
                                    // Dodaj trochę przestrzeni między obrazem a tekstem
                                    Text(
                                      'List'.tr,
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: buttonSearchBar,
                              onPressed: () {
                                ref.read(navigationService).pushNamedScreen(
                                      Routes.leadsBoard,
                                    );
                                ref
                                    .read(selectedFeedViewProvider.notifier)
                                    .state = Routes.leadsBoard;
                                    Navigator.of(context).pop();
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 320,
                                      height: 180,
                                      child: Image.asset(
                                          'assets/images/view/lead_list.webp'),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Board'.tr,
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
