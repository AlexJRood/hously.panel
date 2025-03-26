import 'dart:ui' as ui;
import 'package:hously_flutter/platforms/html_utils_stub.dart'
    if (dart.library.html) 'package:hously_flutter/platforms/html_utils_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/models/crm/agent_transaction_model.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm_with_back.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/widgets/bottom_bar_client.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/widgets/side_buttons_client.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/utils/view_changer.dart';
import 'package:hously_flutter/widgets/screens/feed/map/map_ad.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../../../../../../routes/navigation_history_provider.dart';

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

class ClientsViewFull extends ConsumerStatefulWidget {
  final dynamic clientViewPop;
  final String tagClientViewPop;
  final String activeSection;
  final String activeAd;

  const ClientsViewFull({
    super.key,
    required this.clientViewPop,
    required this.tagClientViewPop,
    required this.activeSection,
    required this.activeAd,
  });

  @override
  ClientsViewFullState createState() => ClientsViewFullState();
}

class ClientsViewFullState extends ConsumerState<ClientsViewFull> {
  late String mainImageUrl;
  final SecureStorage secureStorage = SecureStorage();

  bool _isMapActivated = false;
  bool _isMapVisible = false;

  String activeSection = 'dashboard';
  String openTransaction = '';

  @override
  void initState() {
    super.initState();

    // Ustawienie aktywnej sekcji na podstawie przekazanej wartości
    setState(() {
      activeSection = widget.activeSection;
    });
  }

  // Map activation handler
  void _activateMap() {
    setState(() {
      _isMapActivated = true;
    });
  }

  // Map visibility toggle
  void _toggleMapVisibility() {
    setState(() {
      _isMapVisible = !_isMapVisible;
    });
  }

  // Combined function to change the section and open the transaction
  void openTransactionSection(String section, AgentTransactionModel transaction) {
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
    final userAsyncValue =
        ref.watch(userProvider); // Pobranie stanu użytkownika

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double bottomBarClientWidth = screenWidth / 2;

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
                  filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
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
                    Column(
                      children: [
                        const TopAppBarCRMWithBack(
                          routeName: Routes.proClients,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SidebarClientAgentCrm(
                                    onTabSelected: _changeSection,
                                    activeSection: activeSection),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClientViewContent(
                                          activeSection: activeSection,
                                          clientViewPop: widget.clientViewPop,
                                          activeAd: widget.activeAd,
                                          openTransaction:
                                              openTransaction, // Przekaż openTransaction
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 25),
                             
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: SideButtonsClient(
                        ref: ref,
                        isMapVisible: _isMapVisible,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Błąd: $error'.tr),
      ),
    );
  }
}

