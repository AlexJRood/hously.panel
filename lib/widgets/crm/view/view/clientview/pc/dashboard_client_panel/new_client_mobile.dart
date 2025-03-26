import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';

import 'package:hously_flutter/widgets/appbar/hously/mobile/clientview_appbar.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/client_calendar.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/no_todo_widget.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/mobile/components/event_mobile.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/mobile/components/todo_mobile.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/mobile/components/transaction_mobile.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/mobile/widgets/new_client_details_mobile.dart';

import 'package:hously_flutter/widgets/crm/view/view/clientview/mobile/widgets/new_client_list_mobile.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/mobile/widgets/new_client_card_mobile.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/components/client_text_styles.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/const.dart';

import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_event.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/dashboard_client_panel/widgets/new_client_premium.dart';

import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:pie_menu/pie_menu.dart';

class NewClientMobile extends ConsumerWidget {
  final dynamic clientViewPop;
  final String tagClientViewPop;
  final String activeSection;
  final String activeAd;

  const NewClientMobile({
    super.key,
    required this.clientViewPop,
    required this.tagClientViewPop,
    required this.activeSection,
    required this.activeAd,
  });

  @override
  Widget build(BuildContext context, ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    final theme = ref.watch(themeColorsProvider);
    final clientTilecolor = theme.clientTilecolor;
    final userAsyncValue = ref.watch(userProvider);
    double screenWidth = MediaQuery.of(context).size.width;
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
            backgroundColor: theme.checkoutbackground,
            body: SideMenuManager.sideMenuSettings(
              menuKey: sideMenuKey,
              child: Container(
                color: theme.checkoutbackground,
                child: Column(
                  children: [
                    ClientviewAppbar(
                      sideMenuKey: sideMenuKey,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const NewClientListMobile(),
                    Expanded(
                      child: SizedBox(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                NewClientCardMobile(
                                  onTap: () {},
                                  id: clientViewPop.id ?? '',
                                  avatar: clientViewPop.avatar ?? '',
                                  name: clientViewPop.name ?? '',
                                  lastName: clientViewPop.lastName ?? '',
                                  email: clientViewPop.email ?? '',
                                  phoneNumber: clientViewPop.phoneNumber ?? '',
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const NewClientDetailsMobile(),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Planned Events",
                                      style: TextStyle(
                                          color: theme.whitewhiteblack,
                                          fontSize: 18),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.add,
                                          size: 20,
                                          color: theme.whitewhiteblack,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: theme.clientTilecolor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const NewClientEventMobile()),
                                const SizedBox(
                                  height: 20,
                                ),
                                todo.isNotEmpty
                                    ? Row(
                                        children: [
                                          Text(
                                            "To-Do",
                                            style: TextStyle(
                                                color: theme.whitewhiteblack,
                                                fontSize: 18),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.add,
                                                size: 20,
                                                color: theme.whitewhiteblack,
                                              )),
                                        ],
                                      )
                                    : const SizedBox(),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                    height: 400,
                                    child: todo.isNotEmpty
                                        ? TodoListMobile(
                                            todo: todo,
                                          )
                                        : const TodoNoclient(
                                            isPc: false,
                                          )),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Transaction",
                                      style: TextStyle(
                                          color: theme.whitewhiteblack,
                                          fontSize: 18),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          ref
                                              .read(navigationService)
                                              .pushNamedScreen(
                                                '${Routes.proClients}/${clientViewPop.id}/dashboard/alltransaction',
                                              );
                                        },
                                        child: const Text(
                                          "View All",
                                          style: TextStyle(
                                              color: clienttileTextcolor,
                                              fontSize: 18),
                                        ))
                                  ],
                                ),
                                NewClientMobileTransaction(
                                  id: clientViewPop.id ?? '',
                                  data: clientViewPop,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    gradient: CustomBackgroundGradients
                                        .getMainMenuBackground(context, ref),
                                  ),
                                  child: const NewClientPremium(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Błąd: $error'),
      ),
    );
  }
}
