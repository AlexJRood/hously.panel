import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';

import 'package:hously_flutter/widgets/appbar/hously/mobile/clientview_appbar.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/components/client_calendar.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/mobile/components/todo_mobile.dart';
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

class NewClientMid extends ConsumerWidget {
  final dynamic clientViewPop;
  final String tagClientViewPop;
  final String activeSection;
  final String activeAd;

  const NewClientMid({
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
            backgroundColor: theme.clientbackground,
            body: SideMenuManager.sideMenuSettings(
              menuKey: sideMenuKey,
              child: Container(
                color: theme.clientbackground,
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
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1110,
                                        child: Column(
                                          children: [
                                            // ignore: prefer_const_constructors
                                            Row(
                                              children: const [
                                                Text(
                                                  "Details",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                Spacer(),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const NewClientDetailsMobile(),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Planned Events",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 20,
                                                      color: Colors.white,
                                                    )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: theme.clientTilecolor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 300,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            events.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return EventCard(
                                                              event: events[
                                                                  index]);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 400,
                                                      child: CustomTableCalendarMobile(
                                                          primaryColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fillColor:
                                                              Colors.white,
                                                          firstDay:
                                                              DateTime.utc(
                                                                  2010, 10, 16),
                                                          lastDay: DateTime.utc(
                                                              2030, 3, 14),
                                                          focusedDay:
                                                              DateTime.now(),
                                                          events: events),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1110,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "To-Do",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      Icons.add,
                                                      size: 20,
                                                      color: Colors.white,
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              height: 350,
                                              child: TodoListMobile(
                                                todo: todo,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Transaction",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                const Spacer(),
                                                TextButton(
                                                  onPressed: () {},
                                                  child: const Text(
                                                    "View All",
                                                    style: TextStyle(
                                                        color:
                                                            clienttileTextcolor,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                color: theme.clientTilecolor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              height: 300,
                                              child: ListView.builder(
                                                itemCount: transactions.length,
                                                itemBuilder: (context, index) {
                                                  final transaction =
                                                      transactions[index];
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            flex: 22,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/image.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        transaction[
                                                                            'project']!,
                                                                        style: customtextStyle(
                                                                            context,
                                                                            ref),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1, // Truncates text to prevent overflow
                                                                      ),
                                                                      Text(
                                                                        transaction[
                                                                            'location']!,
                                                                        style: textStylesubheading(
                                                                            context,
                                                                            ref),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1, // Truncates text to prevent overflow
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 8,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  transaction[
                                                                      'amount']!,
                                                                  style:
                                                                      customtextStyle(
                                                                          context,
                                                                          ref),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                ),
                                                                Text(
                                                                  '${transaction['amounteuro']!} EUR',
                                                                  style:
                                                                      textStylesubheading(
                                                                          context,
                                                                          ref),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 1,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color: const Color
                                                                .fromARGB(255,
                                                                109, 109, 109)
                                                            .withOpacity(0.2),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              height: 350,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                gradient:
                                                    CustomBackgroundGradients
                                                        .getMainMenuBackground(
                                                            context, ref),
                                              ),
                                              child: const NewClientPremium(),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
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





// Row(
//                                   children: [
//                                     const NewClientDetailsMobile(),
//                                     Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             const Text(
//                                               "Planned Events",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18),
//                                             ),
//                                             const Spacer(),
//                                             IconButton(
//                                                 onPressed: () {},
//                                                 icon: const Icon(
//                                                   Icons.add,
//                                                   size: 20,
//                                                   color: Colors.white,
//                                                 )),
//                                           ],
//                                         ),
//                                         
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             const Text(
//                                               "To-Do",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18),
//                                             ),
//                                             const Spacer(),
//                                             IconButton(
//                                                 onPressed: () {},
//                                                 icon: const Icon(
//                                                   Icons.add,
//                                                   size: 20,
//                                                   color: Colors.white,
//                                                 )),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         SizedBox(
//                                           height: 400,
//                                           child: TodoListMobile(
//                                             todo: todo,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 20,
//                                         ),
//                                         Row(
//                                           children: [
//                                             const Text(
//                                               "Transaction",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 18),
//                                             ),
//                                             const Spacer(),
//                                             TextButton(
//                                                 onPressed: () {},
//                                                 child: const Text(
//                                                   "View All",
//                                                   style: TextStyle(
//                                                       color:
//                                                           clienttileTextcolor,
//                                                       fontSize: 18),
//                                                 ))
//                                           ],
//                                         ),
                                        
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     Container(
//                                       height: 350,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(5),
//                                         gradient: CustomBackgroundGradients
//                                             .getMainMenuBackground(
//                                                 context, ref),
//                                       ),
//                                       child: const NewClientPremium(),
//                                     )
//                                   ],
//                                 ),