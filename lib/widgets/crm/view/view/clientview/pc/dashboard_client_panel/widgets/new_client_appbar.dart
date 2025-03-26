import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/clients_pro.dart';
import 'package:hously_flutter/widgets/drad_scroll_widget.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:shimmer/shimmer.dart';

import 'package:hously_flutter/const/url.dart';

const configUrl = URLs.baseUrl;

const defaultAvatarUrl = '$configUrl/media/avatars/avatar.jpg';

class NewClientAppbar extends ConsumerStatefulWidget {
  const NewClientAppbar({super.key});

  @override
  ConsumerState<NewClientAppbar> createState() => _NewClientAppbarState();
}

class _NewClientAppbarState extends ConsumerState<NewClientAppbar> {
  bool isExpanded = false; // Flaga dla stanu rozwinięcia
  TextEditingController searchController = TextEditingController();
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int extractClientIdFromUrl(Uri uri) {
    List<String> pathSegments = uri.pathSegments;

    int clientIndex = pathSegments.indexOf('clients');
    if (clientIndex != -1 && clientIndex + 1 < pathSegments.length) {
      // Try parsing the client ID as an integer
      return int.tryParse(pathSegments[clientIndex + 1]) ??
          0; // Returns 0 if parsing fails
    } else {
      return 0; // Return 0 if the client ID is not found
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientListAsyncValue = ref.watch(clientProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    Uri currentUri = Uri.base; // Gets the current URL in Flutter web
    int clientIdfromUrl = extractClientIdFromUrl(currentUri);
    final theme = ref.watch(themeColorsProvider);
    final clientTilecolor = theme.clientTilecolor;
    final isdark = ref.watch(isDefaultDarkSystemProvider);
    final Map<String, String> sortOptions = {
      'amount_asc': 'Kwota rosnąco',
      'amount_desc': 'Kwota malejąco',
      'date_create_asc': 'Data utworzenia rosnąco',
      'date_create_desc': 'Data utworzenia malejąco',
      'date_update_asc': 'Data aktualizacji rosnąco',
      'date_update_desc': 'Data aktualizacji malejąco',
      'name_asc': 'Imię alfabetycznie',
      'name_desc': 'Imię malejąco',
      'last_name_asc': 'Nazwisko alfabetycznie',
      'last_name_desc': 'Nazwisko malejąco',
    };

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 4),
          SizedBox(
            width: 100,
            child: IconButton(
                onPressed: () {}, icon: SvgPicture.asset(AppIcons.iosArrowLeft)),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: clientListAsyncValue.when(
              data: (clients) {
                if (clients.isEmpty) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                            height: 32,
                            decoration: BoxDecoration(
                              gradient: CustomBackgroundGradients.adGradient1(
                                  context, ref),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text('No clients available',
                                      style: AppTextStyles.interRegular12)),
                            )),
                      ),
                    ],
                  );
                }
                return DragScrollView(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...clients.map((client) {
                          bool isClientMatch = client.id == clientIdfromUrl;
                          bool isBlackWhiteScheme =
                              colorscheme == FlexScheme.blackWhite;

                          Color getTileColor() {
                            if (isdark) {
                              return isClientMatch
                                  ? clienttileTextcolor
                                  : Colors.white;
                            } else {
                              if (isBlackWhiteScheme) {
                                return isClientMatch
                                    ? Colors.blue
                                    : theme.whitewhiteblack;
                              } else {
                                return isClientMatch
                                    ? Theme.of(context).primaryColor
                                    : theme.whitewhiteblack;
                              }
                            }
                          }

                          return PieMenu(
                            onPressedWithDevice: (kind) {
                              if (kind == PointerDeviceKind.mouse ||
                                  kind == PointerDeviceKind.touch) {
                                ref.read(navigationService).pushNamedScreen(
                                  '${Routes.proClients}/${client.id}/dashboard',
                                  data: {'clientViewPop': client},
                                );
                              }
                            },
                            actions: buildPieMenuActionsClientsPro(
                                ref, client.id, client, context),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                height: 32,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: clientTilecolor,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(client.name,
                                          style: AppTextStyles.interRegular14
                                              .copyWith(color: getTileColor())),
                                      const SizedBox(width: 5),
                                      Text(client.lastName.toString(),
                                          style: AppTextStyles.interRegular14
                                              .copyWith(color: getTileColor())),
                                      const SizedBox(width: 6),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              },
              loading: () => SizedBox(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      15,
                      (index) => Container(
                        height: 32,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: clientTilecolor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 6),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[800]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 110,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              error: (err, stack) => Expanded(
                child: DragScrollView(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        10,
                        (index) => Container(
                          height: 32,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: CustomBackgroundGradients.crmadgradient(
                                context, ref),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 6),
                                Stack(
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[800]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 5,
                                      top: 5,
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 15,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 6),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[800]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 160,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                          ),
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
