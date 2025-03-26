import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm_with_back.dart';

import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_clientview_content.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/client_shimmer.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_appbar.dart';

import 'package:hously_flutter/platforms/html_utils_stub.dart'
    if (dart.library.html) 'package:hously_flutter/platforms/html_utils_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/secure_storage.dart';

import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/widgets/bottom_bar_client.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/widgets/side_buttons_client.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/utils/view_changer.dart';

import 'package:pie_menu/pie_menu.dart';

import '../../../../../../../routes/navigation_history_provider.dart';
import 'dart:ui' as ui;

void copyToClipboard(BuildContext context, String listingUrl) {
  Clipboard.setData(ClipboardData(text: listingUrl)).then((_) {
    final successSnackBar = Customsnackbar().showSnackBar(
      "success",
      'Link skopiowany do schowka!'.tr,
      "success",
      () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
  });
}

class NewClientsViewFull extends ConsumerStatefulWidget {
  final String tagClientViewPop;
  final dynamic clientViewPop;
  final String activeSection;
  final String activeAd;

  const NewClientsViewFull({
    super.key,
    required this.tagClientViewPop,
    required this.clientViewPop,
    required this.activeSection,
    required this.activeAd,
  });

  @override
  NewClientsViewFullState createState() => NewClientsViewFullState();
}

class NewClientsViewFullState extends ConsumerState<NewClientsViewFull> {
  late String mainImageUrl;
  final SecureStorage secureStorage = SecureStorage();
  String activeSection = 'Dashboard';
  String openTransaction = '';
  @override
  void initState() {
    super.initState();
    print(widget.clientViewPop);
    // Ustawienie aktywnej sekcji na podstawie przekazanej wartości
    setState(() {
      activeSection = widget.activeSection;
    });
  }

  // Combined function to change the section and open the transaction
  void openTransactionSection(
      String section, AgentTransactionModel transaction) {
    setState(() {
      activeSection = section; // Change the active section
      openTransaction =
          transaction.id.toString(); // Set the specific transaction to open
    });
    // Update the URL accordingly
    updateUrl(
        '/pro/clients/${widget.clientViewPop.id}/Transakcje/${transaction.id}');
  }

  // Changing section
  void _changeSection(String section) {
    setState(() {
      activeSection = section;
    });
    ref.read(navigationHistoryProvider.notifier).addPage(section);

    // Aktualizacja URL na podstawie aktywnej sekcji
    updateUrl('/pro/clients/${widget.clientViewPop.id}/$activeSection');
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    final theme = ref.watch(themeColorsProvider);

    return PieCanvas(
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
      child: userAsyncValue.when(
        data: (user) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    color: Colors.black.withOpacity(0.85),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                GestureDetector(
                  onTap: () => ref.read(navigationService).beamPop(),
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: SizedBox(
                        width: screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SidebarClientAgentCrm(
                              onTabSelected: _changeSection,
                              activeSection: activeSection,
                            ),
                            Expanded(
                              flex: 11,
                              child: ClientViewContent(
                                activeSection: activeSection,
                                clientViewPop: widget.clientViewPop,
                                activeAd: widget.activeAd,
                                openTransaction:
                                    openTransaction, // Przekaż openTransaction
                              ),
                            ),
                            // Expanded(
                            //   flex: 1,
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(
                            //       right: 10,
                            //       bottom: 17,
                            //     ),
                            //     child: Visibility(
                            //       visible: screenHeight > 400,
                            //       child: Column(
                            //         children: [
                            //           Spacer(),
                            //           SideButtonsClient(
                            //             ref: ref,
                            //             isMapVisible: _isMapVisible,
                            //           ),
                            //           SizedBox(
                            //               height:
                            //                   MediaQuery.of(context).size.height <
                            //                           1536
                            //                       ? 0
                            //                       : MediaQuery.of(context)
                            //                               .size
                            //                               .height *
                            //                           0.2)
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topRight,
                      child: TopAppBarCRMWithBack(
                        routeName: Routes.proClients,
                      ),
                    ), // change to production
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const ClientShimmer(),
        error: (error, stack) => Text('Błąd: $error'.tr),
      ),
    );
  }
}
