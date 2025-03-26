import 'dart:ui' as ui;
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_appbar.dart';

import 'package:shimmer/shimmer.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/models/crm/agent_transaction_model.dart';

import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/secure_storage.dart';

import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/widgets/bottom_bar_client.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/widgets/side_buttons_client.dart';

class ClientShimmer extends ConsumerStatefulWidget {
  const ClientShimmer({super.key});

  @override
  ConsumerState<ClientShimmer> createState() => _ClientShimmerState();
}

class _ClientShimmerState extends ConsumerState<ClientShimmer> {
  late String mainImageUrl;
  final SecureStorage secureStorage = SecureStorage();

  bool _isMapActivated = false;
  bool _isMapVisible = false;

  String activeSection = 'dashboard';
  String openTransaction = '';

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  void _activateMap() {
    setState(() {
      _isMapActivated = true;
    });
  }

  void _toggleMapVisibility() {
    setState(() {
      _isMapVisible = !_isMapVisible;
    });
  }

  void openTransactionSection(String section, AgentTransactionModel transaction) {
    setState(() {
      activeSection = section;
      openTransaction = transaction.id.toString();
    });
  }

  // Changing section
  void _changeSection(String section) {
    setState(() {
      activeSection = section;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = ref.watch(themeColorsProvider);
    final clientTilecolor = theme.clientTilecolor;
    double screenWidth = MediaQuery.of(context).size.width;
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
              SizedBox(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 70),
                        Shimmer.fromColors(
                          baseColor: clientTilecolor.withOpacity(0.3),
                          highlightColor: clientTilecolor.withOpacity(0.1),
                          child: SidebarClientAgentCrm(
                            onTabSelected: _changeSection,
                            activeSection: activeSection,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          Expanded(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.85,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 523,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex:
                                                            screenWidth >= 1415
                                                                ? 50
                                                                : 29,
                                                        child: Column(
                                                          children: [
                                                            Shimmer.fromColors(
                                                              baseColor:
                                                                  clientTilecolor
                                                                      .withOpacity(
                                                                          0.3),
                                                              highlightColor:
                                                                  clientTilecolor
                                                                      .withOpacity(
                                                                          0.1),
                                                              child: Container(
                                                                height: 152,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color:
                                                                      clientTilecolor,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 25),
                                                            Shimmer.fromColors(
                                                              baseColor:
                                                                  clientTilecolor
                                                                      .withOpacity(
                                                                          0.3),
                                                              highlightColor:
                                                                  clientTilecolor
                                                                      .withOpacity(
                                                                          0.1),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 15,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          345,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color:
                                                                            clientTilecolor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          SizedBox()),
                                                                  Expanded(
                                                                    flex: 45,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          345,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color:
                                                                            clientTilecolor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Expanded(
                                                          flex: 1,
                                                          child: SizedBox()),
                                                      Expanded(
                                                        flex: 15,
                                                        child:
                                                            Shimmer.fromColors(
                                                          baseColor:
                                                              clientTilecolor
                                                                  .withOpacity(
                                                                      0.3),
                                                          highlightColor:
                                                              clientTilecolor
                                                                  .withOpacity(
                                                                      0.1),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  clientTilecolor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 350,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex:
                                                            screenWidth >= 1415
                                                                ? 50
                                                                : 29,
                                                        child:
                                                            Shimmer.fromColors(
                                                          baseColor:
                                                              clientTilecolor
                                                                  .withOpacity(
                                                                      0.3),
                                                          highlightColor:
                                                              clientTilecolor
                                                                  .withOpacity(
                                                                      0.1),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  clientTilecolor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const Expanded(
                                                          flex: 1,
                                                          child: SizedBox()),
                                                      Expanded(
                                                        flex: 15,
                                                        child:
                                                            Shimmer.fromColors(
                                                          baseColor:
                                                              clientTilecolor
                                                                  .withOpacity(
                                                                      0.3),
                                                          highlightColor:
                                                              clientTilecolor
                                                                  .withOpacity(
                                                                      0.1),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  clientTilecolor,
                                                            ),
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
              ),
              const Align(
                  alignment: Alignment.topRight, child: NewClientAppbar()),
            ],
          ),
        ],
      ),
    );
  }
}
