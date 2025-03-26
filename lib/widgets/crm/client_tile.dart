import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/crm/clients/client_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/clients_pro.dart';
import 'package:hously_flutter/widgets/drad_scroll_widget.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:shimmer/shimmer.dart';

const configUrl = URLs.baseUrl;

const defaultAvatarUrl = '$configUrl/media/avatars/avatar.jpg';

class ClientListAppBar extends ConsumerStatefulWidget {
  final String routeName;

  const ClientListAppBar({super.key, required this.routeName});

  @override
  ConsumerState<ClientListAppBar> createState() => _ClientListAppBarState();
}

class _ClientListAppBarState extends ConsumerState<ClientListAppBar> {
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

  @override
  Widget build(BuildContext context) {
    final clientListAsyncValue = ref.watch(clientProvider);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final theme = ref.watch(themeColorsProvider);
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

    return Row(
      children: [
        const SizedBox(width: 4),
        PieMenu(
          onPressedWithDevice: (kind) {
            if (kind == PointerDeviceKind.mouse ||
                kind == PointerDeviceKind.touch) {
                  ref.read(navigationService)
                      .pushNamedScreen('${widget.routeName}${Routes.addClientForm}');
            }
          },
          actions: buildPieMenuActionsClientsPro(ref, 1, 1, context), //change to production
          child: Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              gradient: CustomBackgroundGradients.crmClientAppbarGradient(
                  context, ref),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppIcons.add,
                color: theme.mobileTextcolor,
                height: 25,
                width: 25,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isExpanded ? 200 : 32,
            height: 32,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: CustomBackgroundGradients.crmClientAppbarGradient(
                  context, ref),
              borderRadius: BorderRadius.circular(8),
            ),
            child: isExpanded
                ? Focus(
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        setState(() {
                          isExpanded = false;
                        });
                      }
                    },
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        ref.watch(clientProvider.notifier).fetchClients(
                              searchQuery: value,
                            );
                      },
                      onSubmitted: (value) {
                        ref.watch(clientProvider.notifier).fetchClients(
                              searchQuery: value,
                            );
                        setState(() {
                          isExpanded = false;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Szukaj klienta...'.tr, // search client
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0), // Wyśrodkowanie pionowe
                        hintStyle: AppTextStyles.interRegular12,
                      ),
                      style: AppTextStyles.interRegular12,
                      textAlign: TextAlign.start, // Wyśrodkowanie horyzontalne
                    ),
                  )
                : SvgPicture.asset(AppIcons.search,
                    color: theme.mobileTextcolor, height: 25, width: 25),
          ),
        ),
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
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            gradient: CustomBackgroundGradients.adGradient1(
                                context, ref),
                            borderRadius: BorderRadius.circular(8),
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
                        return PieMenu(
                          onPressedWithDevice: (kind) {
                            if (kind == PointerDeviceKind.mouse ||
                                kind == PointerDeviceKind.touch) {
                              ref.read(navigationService).pushNamedScreen(
                                '${widget.routeName}/${client.id}/Dashboard',
                                data: {'clientViewPop': client},
                              );
                            }
                          },
                          actions: buildPieMenuActionsClientsPro(
                              ref, client.id, client, context),
                          child: Container(
                            height: 32,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: CustomBackgroundGradients
                                  .crmClientAppbarGradient(context, ref),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            client.avatar ?? defaultAvatarUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(client.name,
                                      style: AppTextStyles.interRegular14
                                          .copyWith(
                                              color: theme.mobileTextcolor)),
                                  const SizedBox(width: 5),
                                  Text(client.lastName.toString(),
                                      style: AppTextStyles.interRegular14
                                          .copyWith(
                                              color: theme.mobileTextcolor)),
                                  const SizedBox(width: 6),
                                ],
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
                    10,
                    (index) => Container(
                      height: 32,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient:
                            CustomBackgroundGradients.crmClientAppbarGradient(
                                context, ref),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 6),
                            Shimmer.fromColors(
                              baseColor: ShimmerColors.base(context),
                              highlightColor: ShimmerColors.highlight(context),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: ShimmerColors.background(context),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Shimmer.fromColors(
                              baseColor: ShimmerColors.base(context),
                              highlightColor: ShimmerColors.highlight(context),
                              child: Container(
                                width: 160,
                                height: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: ShimmerColors.background(context),
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
            error: (err, stack) => DragScrollView(
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
                        gradient:
                            CustomBackgroundGradients.crmClientAppbarGradient(
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
                                  baseColor: ShimmerColors.base(context),
                                  highlightColor:
                                      ShimmerColors.highlight(context),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: ShimmerColors.background(context),
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
                              baseColor: ShimmerColors.base(context),
                              highlightColor: ShimmerColors.highlight(context),
                              child: Container(
                                width: 160,
                                height: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: ShimmerColors.background(context),
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
      ],
    );
  }
}
