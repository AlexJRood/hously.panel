import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

final selectedFinanceViewProvider = StateProvider<String>(
    (ref) => '/pro/finance');

class ViewPopPageChangerCrmFinance extends ConsumerWidget {
  const ViewPopPageChangerCrmFinance({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              color: Colors.black.withOpacity(0.85),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Obsługa dotknięcia w dowolnym miejscu aby zamknąć modal
          GestureDetector(
            onTap: () => ref.read(navigationService).beamPop(),
          ),
          // Zawartość modalu
          Hero(
            tag: 'ViewChangerBarButton-${UniqueKey().toString()}', // need to be change both sides of hero need the same tag 
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                    right: screenWidth * 0.2 - 45, top: screenHeight * 0.05),
                child: Container(
                  width: screenWidth * 0.2 <= 500 ? 450 : 450,
                  height: screenHeight * 0.8,
                  decoration: BoxDecoration(
                    gradient: BackgroundGradients.appBarGradient,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: buttonSearchBar,
                          onPressed: () {
                            ref
                                    .read(selectedFinanceViewProvider.notifier)
                                    .state =
                                '/pro/finance-draggable'; // Aktualizacja Providera
                            ref
                                .read(navigationService)
                                .pushNamedScreen(Routes.proDraggable);
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
                                  style: const TextStyle(
                                    color: Colors.white,
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
                            ref
                                    .read(selectedFinanceViewProvider.notifier)
                                    .state =
                                '/pro/finance'; // Aktualizacja Providera
                            ref
                                .read(navigationService)
                                .pushNamedScreen(Routes.proFinance);
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
                                const SizedBox(
                                    height:
                                        10), // Dodaj trochę przestrzeni między obrazem a tekstem
                                 Text(
                                  'Widok siatki'.tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // // const SizedBox(height: 10),
                        //  ElevatedButton(
                        //   style: buttonSearchBar,
                        //       onPressed: () {
                        //     ref.read(selectedFinanceViewProvider.notifier).state = '/fullsize'; // Aktualizacja Providera
                        //     Navigator.of(context).pushNamed('/fullsize'); // Natychmiastowa nawigacja do wybranej strony
                        //   },
                        //   child: Material(
                        //   color: Colors.transparent,
                        //     child: Column(
                        //       children: [
                        //         SizedBox(
                        //           width: 320,
                        //           height: 180,
                        //           child:
                        //               Image.asset('assets/images/full_size_view.webp'),
                        //         ),
                        //         const SizedBox(height: 10),
                        //         const Text(
                        //           'Fill size',
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 20,),),

                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // // const SizedBox(height: 10),
                        //  ElevatedButton(
                        //   style: buttonSearchBar,
                        //       onPressed: () {
                        //     ref.read(selectedFinanceViewProvider.notifier).state = '/listview'; // Aktualizacja Providera
                        //     Navigator.of(context).pushNamed('/listview'); // Natychmiastowa nawigacja do wybranej strony
                        //   },
                        //   child: Material(
                        //   color: Colors.transparent,
                        //     child: Column(
                        //       children: [
                        //         SizedBox(
                        //           width: 320,
                        //           height: 180,
                        //           child:
                        //               Image.asset('assets/images/full_size_view.webp'),
                        //         ),
                        //         const SizedBox(height: 10),
                        //         const Text(
                        //           'List view',
                        //           style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 20,),),

                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                      ],
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
