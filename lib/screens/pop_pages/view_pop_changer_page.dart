import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

final selectedFeedViewProvider = StateProvider<String>(
    (ref) => '/feedview'); // Domyślnie ustawione na '/feedview'

class ViewPopChangerPage extends ConsumerStatefulWidget {
  final Offset? buttonPosition;
  const ViewPopChangerPage({super.key, this.buttonPosition});

  @override
  ViewPopPageChangerState createState() => ViewPopPageChangerState();
}

class ViewPopPageChangerState extends ConsumerState<ViewPopChangerPage> {
  late TextEditingController searchController;
  late TextEditingController excludeController;
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;

  @override
  void initState() {
    super.initState();
    final filterNotifier = ref.read(filterProvider.notifier);
    searchController = TextEditingController(text: filterNotifier.searchQuery);
    excludeController =
        TextEditingController(text: filterNotifier.excludeQuery);
    minPriceController = TextEditingController(
        text: filterNotifier.filters['min_price']?.toString());
    maxPriceController = TextEditingController(
        text: filterNotifier.filters['max_price']?.toString());
  }

  @override
  void dispose() {
    searchController.dispose();
    excludeController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

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
            tag: 'ViewChangerBarButton',
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
                            ElevatedButton(
                              style: buttonSearchBar,
                              onPressed: () {
                                ref.read(navigationService).pushNamedScreen(
                                      Routes.mapView,
                                    );
                                ref
                                    .read(selectedFeedViewProvider.notifier)
                                    .state = Routes.mapView;
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 320,
                                      height: 180,
                                      child: Image.asset(
                                          'assets/images/map_view.webp'),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Mapa'.tr,
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
                            // const SizedBox(height: 10),
                            ElevatedButton(
                              style: buttonSearchBar,
                              onPressed: () {
                                ref.read(navigationService).pushNamedScreen(
                                      Routes.feedView,
                                    );
                                ref
                                    .read(selectedFeedViewProvider.notifier)
                                    .state = Routes.feedView;
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 320,
                                      height: 180,
                                      child: Image.asset(
                                          'assets/images/feed_view.webp'),
                                    ),
                                    const SizedBox(height: 10),
                                    // Dodaj trochę przestrzeni między obrazem a tekstem
                                    Text(
                                      'Widok siatki'.tr,
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
                                      Routes.basicview,
                                    );
                                ref
                                    .read(selectedFeedViewProvider.notifier)
                                    .state = Routes.basicview;
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 320,
                                      height: 180,
                                      child: Image.asset(
                                          'assets/images/basic_view.png'),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Basic view'.tr,
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
                                      Routes.fullSize,
                                    );
                                ref
                                    .read(selectedFeedViewProvider.notifier)
                                    .state = Routes.fullSize;
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 320,
                                      height: 180,
                                      child: Image.asset(
                                          'assets/images/full_size_view.webp'),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Fill size',
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

                            // const SizedBox(height: 10),
                            ElevatedButton(
                              style: buttonSearchBar,
                              onPressed: () {
                                ref.read(navigationService).pushNamedScreen(
                                      Routes.listview,
                                    );
                                ref
                                    .read(selectedFeedViewProvider.notifier)
                                    .state = Routes.listview;
                              },
                              child: Material(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 320,
                                      height: 180,
                                      child: Image.asset(
                                          'assets/images/full_size_view.webp'),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'List view',
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
                            const SizedBox(
                              height: 10,
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
