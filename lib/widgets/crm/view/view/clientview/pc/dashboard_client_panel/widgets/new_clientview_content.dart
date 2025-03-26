import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_details.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_event.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_photo_card.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_premium.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_todo.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_transaction.dart';

class ClientDashboardContent extends ConsumerWidget {
  final dynamic clientViewPop;
  const ClientDashboardContent({super.key, required this.clientViewPop});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final clientTilecolor = theme.clientTilecolor;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    GlobalKey showMenukey = GlobalKey();
    double dynamicSpacer = screenHeight/54;
    double biggerDynamicSpacer = dynamicSpacer*1.5;
    double screen = screenHeight - 80;
    double screenSpace = screen - dynamicSpacer;
    double upSectionHeight =  screen/1.65;
    double downSectionHeight =  screen - upSectionHeight;

    return SizedBox(
            height: screen,
              child: Padding(
                padding: EdgeInsets.only(left: dynamicSpacer, right: dynamicSpacer, bottom: dynamicSpacer),
                child: SingleChildScrollView(
                  child: Column(
                        spacing: dynamicSpacer,
                    children: [
                      Column(
                        children: [
                          // change to production
                          //need to check the responsiveness in screen with larger hight
                          Container(
                            height: 498 + biggerDynamicSpacer,
                            child: Row(
                              spacing: dynamicSpacer,
                              children: [
                                Expanded(
                                  flex: screenWidth >= 1415 ? 50 : 28,
                                  child: Column(
                                    spacing: biggerDynamicSpacer,
                                    children: [
                                      ClientPhotowidget(clientViewPop: clientViewPop),
                                      Row(
                                        spacing: dynamicSpacer,
                                        children: const [
                                          Expanded(
                                              flex: 15,
                                              child: NewClientDetails()),
                                          Expanded(
                                              flex: 45,
                                              child: NewClientEvent())
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const Expanded(
                                    flex: 15, 
                                    child: NewClientTodo())
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: downSectionHeight ,
                        child: Row(
                          spacing: dynamicSpacer,
                          children: [
                            Expanded(
                                flex: screenWidth >= 1415 ? 50 : 29,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: clientTilecolor,
                                  ),
                                  child: NewClientTransaction(
                                    key: showMenukey,
                                  ),
                                )),
                            Expanded(
                                flex: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: CustomBackgroundGradients.getMainMenuBackground(context, ref),
                                  ),
                                  child: const NewClientPremium(),
                                )),
                                
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );
  }
}
