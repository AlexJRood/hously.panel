import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/utils/extensions/context_extension.dart';
import 'package:hously_flutter/modules/todo/board/board_card_widget.dart';
import 'package:hously_flutter/modules/todo/board/provider/board_provider.dart';
import 'package:hously_flutter/modules/todo/view/widgets/star_rating_widget.dart';
import 'package:hously_flutter/widgets/bars/sidebar.dart';

import '../../../routing/route_constant.dart';
import '../../../theme/design/design.dart';
import '../../../routing/navigation_service.dart';
import '../../../widgets/side_menu/side_menu_manager.dart';
import '../../../widgets/side_menu/slide_rotate_menu.dart';

class BoardPc extends ConsumerStatefulWidget {
  const BoardPc({super.key});

  @override
  ConsumerState<BoardPc> createState() => _BoardPcState();
}

class _BoardPcState extends ConsumerState<BoardPc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(boardManagementProvider.notifier).fetchBoards(ref);
    });
  }
  @override
  Widget build(BuildContext context) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    final boardData = ref.watch(boardManagementProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    const double maxWidth = 1920;
    const double minWidth = 480;
    const double maxLogoSize = 30;
    const double minLogoSize = 16;
    double logoSize = (screenWidth - minWidth) /
        (maxWidth - minWidth) *
        (maxLogoSize - minLogoSize) +
        minLogoSize;
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);
    final userData = boardData.results?.isNotEmpty == true
        ? boardData.results!.last.user
        : null;
    return Scaffold(
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Container(
          decoration: const BoxDecoration(
            gradient: CrmGradients.crmGradientRight,
          ),
          child: Row(
            children: [
               Sidebar(
                 sideMenuKey: sideMenuKey,
               ),
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 40.0, left: 40),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70,),
                          Container(
                            height: 50,
                            width: context.screenWidth / 6,
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Horizontal List of Cards
                          SizedBox(
                            height: context.screenHeight / 3.6, // Set height to fit the cards
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: boardData.results?.length,
                              itemBuilder: (context, index) {
                                if (index < 0 || index >= boardData.results!.length) {
                                  return const SizedBox();
                                }
                                final data = boardData.results?[index];
                                return Container(
                                  color: Colors.transparent,
                                  height: 800,
                                  child:   InkWell(
                                    onTap: () {
                                      ref.read(boardIdProvider.notifier).state = data.id!;
                                      ref.read(navigationService).pushNamedScreen(
                                          Routes.proTodo);
                                      print(data.id);
                                    },
                                    child: BoardCardWidget(
                                      title: '${data?.name}',
                                      imageUrl: 'assets/images/landingpage.webp',
                                      notificationCount: data!.id!,
                                      comments: const ['', ''],
                                      id: data.id!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 50,
                            width: context.screenWidth / 6,
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Grid of Cards
                          GridView.builder(
                            shrinkWrap: true, // Avoid unbounded height errors
                            physics:
                            const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                            itemCount: boardData.results?.length,
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2
                            ),
                            itemBuilder: (context, index) {
                              if (index < 0 || index >= boardData.results!.length) {
                                return const SizedBox();
                              }
                              final data = boardData.results?[index];
                              return Container(
                                color: Colors.transparent,
                                height: 400,
                                child: BoardCardWidget(
                                  title: '${data?.name}',
                                  imageUrl: 'assets/images/landingpage.webp',
                                  notificationCount: data!.id!,
                                  comments: ['', ''],
                                  id: data.id!,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0,right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text(
                          'HOUSLY.AI',
                          style: AppTextStyles.houslyAiLogo
                              .copyWith(fontSize: logoSize),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius:
                            const BorderRadius.all(Radius.circular(32)),
                          ),
                          width: context.screenWidth / 8,
                          child: Column(
                            children: [
                              Container(
                                height: context.screenWidth / 12,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(32)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'assets/images/landingpage.webp'),
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 22.0, bottom: 22),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${userData?.username}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text('${userData?.email}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const StarRating(rating: 0),
                                    Text('${userData?.email}',
                                      style:const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),
                    Expanded(
                      child: SizedBox(
                        width: 73,
                        child: ListView.builder(
                          itemCount: 5,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                              const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Container(
                                height: 70,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.grey[500],
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(90))),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}