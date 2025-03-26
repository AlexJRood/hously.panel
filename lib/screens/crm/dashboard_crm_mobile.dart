import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/crm/apptour_crm_bottombar.dart';
import 'package:hously_flutter/widgets/crm/client_tile_mobile.dart';
import 'package:hously_flutter/widgets/crm/dashboard/finance_chart.dart';
import 'package:hously_flutter/widgets/crm/dashboard/plans_chart.dart';
import 'package:hously_flutter/widgets/crm/dashboard/structure_chart.dart';
import 'package:hously_flutter/widgets/crm/dashboard/transactions_slider.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class DashboardCrmMobile extends ConsumerStatefulWidget {
  const DashboardCrmMobile({super.key});

  @override
  _DashboardCrmMobileState createState() => _DashboardCrmMobileState();
}

class _DashboardCrmMobileState extends ConsumerState<DashboardCrmMobile> {
  late GlobalKey oneKey;
  late GlobalKey twoKey;
  late GlobalKey threeKey;
  late GlobalKey fourKey;
  late GlobalKey fiveKey;
  late PageController _pageController1;

  int _currentPage1 = 10000; // Ustawiamy wysoką wartość początkową

// Dla drugiego PageView
  late PageController _pageController2;
  int _currentPage2 = 10000;
  final sideMenuKey = GlobalKey<SideMenuState>();

// Listy widgetów dla PageView
  final List<Widget> _pageView1Widgets = [
    const TransactionTypePieChart(isExpenses: true),
    const TransactionTypePieChart(isExpenses: false),
  ];

  final List<Widget> _pageView2Widgets = [
    const RevenueExpensesChart(),
    const FinancialPlansBarChart(),
  ];

  @override
  void initState() {
    _pageController1 = PageController(initialPage: _currentPage1);
    _pageController2 = PageController(initialPage: _currentPage2);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        oneKey = ref.read(crm1) ?? GlobalKey();
        twoKey = ref.read(crm2) ?? GlobalKey();
        threeKey = ref.read(crm3) ?? GlobalKey();
        fourKey = ref.read(crm4) ?? GlobalKey();
        fiveKey = ref.read(crm5) ?? GlobalKey();
        _checkAndStartShowCase();
      }
    });
    super.initState();
  }

  Future<void> _checkAndStartShowCase() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    final isShowCaseDisplayed = prefs.getBool('crmmobile') ?? false;

    if (!isShowCaseDisplayed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context).startShowCase([
          oneKey,
          twoKey,
          threeKey,
          fourKey,
          fiveKey,
        ]);
      });
      await prefs.setBool('crmmobile', true); // Mark showcase as displayed
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController1.dispose();
    _pageController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double halfScreenWidth = screenWidth / 2 - 60;
    double chartScreenHeight = screenHeight / 5 * 3 - 54;
    double pieChartScreenHeight = screenHeight / 5 * 2 - 54;

    // Obliczamy liczby stron i bieżące indeksy dla wskaźników
    final int pageCount1 = _pageView1Widgets.length;
    final int displayPageIndex1 = _currentPage1 % pageCount1;

    final int pageCount2 = _pageView2Widgets.length;
    final int displayPageIndex2 = _currentPage2 % pageCount2;
    return PopupListener(
      child: SafeArea(
        child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
              decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.customcrmright(context, ref),
              ),
              child: Column(
                children: [
                   AppBarMobile(sideMenuKey: sideMenuKey,),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: ClientTileMobile(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity != null) {
                                if (details.primaryVelocity! > 0) {
                                  // Swiping Right

                                  _pageController1.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                } else if (details.primaryVelocity! < 0) {
                                  // Swiping Left

                                  _pageController1.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: screenWidth - 30,
                              height: pieChartScreenHeight,
                              decoration: BoxDecoration(
                                gradient: CustomBackgroundGradients.crmadgradient(
                                    context, ref),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Stack(
                                children: [
                                  PageView.builder(
                                    controller: _pageController1,
                                    onPageChanged: (int page) {
                                      setState(() {
                                        _currentPage1 = page;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      final int actualIndex = index % pageCount1;
                                      return _pageView1Widgets[actualIndex];
                                    },
                                  ),
                                  // Strzałka w lewo
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_left,
                                          color:
                                              Theme.of(context).iconTheme.color),
                                      onPressed: () {
                                        _pageController1.previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                    ),
                                  ),
                                  // Strzałka w prawo
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_right,
                                          color:
                                              Theme.of(context).iconTheme.color),
                                      onPressed: () {
                                        _pageController1.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                    ),
                                  ),
                                  // Wskaźnik stron (kropki)
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:
                                          List.generate(pageCount1, (index) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: displayPageIndex1 == index
                                                ? Theme.of(context)
                                                    .iconTheme
                                                    .color
                                                : Colors.grey,
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: FinancialWidget(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity != null) {
                                if (details.primaryVelocity! > 0) {
                                  // Swiping Right

                                  _pageController2.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                } else if (details.primaryVelocity! < 0) {
                                  // Swiping Left

                                  _pageController2.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: screenWidth - 30,
                              height: pieChartScreenHeight,
                              decoration: BoxDecoration(
                                gradient: CustomBackgroundGradients.crmadgradient(
                                    context, ref),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Stack(
                                children: [
                                  PageView.builder(
                                    controller: _pageController2,
                                    onPageChanged: (int page) {
                                      setState(() {
                                        _currentPage2 = page;
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      final int actualIndex = index % pageCount2;
                                      return _pageView2Widgets[actualIndex];
                                    },
                                  ),
                                  // Strzałka w lewo
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_left,
                                          color:
                                              Theme.of(context).iconTheme.color),
                                      onPressed: () {
                                        _pageController2.previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                    ),
                                  ),
                                  // Strzałka w prawo
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_right,
                                          color:
                                              Theme.of(context).iconTheme.color),
                                      onPressed: () {
                                        _pageController2.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                    ),
                                  ),
                                  // Wskaźnik stron (kropki)
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:
                                          List.generate(pageCount2, (index) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: displayPageIndex2 == index
                                                ? Theme.of(context)
                                                    .iconTheme
                                                    .color
                                                : Colors.grey,
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  const ApptourCrmBottombar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _checkForToken() async {
    if (ApiServices.token != null) {
      // Usunięcie stron logowania i rejestracji z historii nawigacji
      ref
          .read(navigationHistoryProvider.notifier)
          .removeSpecificPages(['/login', '/register']);

      // Przekierowanie na ostatnią stronę w historii nawigacji
      final lastPage = ref.read(navigationHistoryProvider.notifier).lastPage;
      ref.read(navigationService).pushNamedReplacementScreen(lastPage);
    }
  }
}
