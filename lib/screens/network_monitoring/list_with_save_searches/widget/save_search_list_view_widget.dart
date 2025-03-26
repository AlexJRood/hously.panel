import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/saved_search/api.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/search_page/filters_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/network_monitoring/filter/fileds.dart';
import 'package:pie_menu/pie_menu.dart';

class SaveSearchListViewWidget extends ConsumerWidget {
  const SaveSearchListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedSearchesAsyncValue = ref.watch(savedSearchesProvider);

    return savedSearchesAsyncValue.when(
      data: (data) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final search = data[index];
            return PieMenu(
              onPressedWithDevice: (kind) {
                if (kind == PointerDeviceKind.mouse ||
                    kind == PointerDeviceKind.touch) {
                  ref
                      .read(networkMonitoringFilterCacheProvider.notifier)
                      .setFiltersFromJson(search.toJson());
                  ref
                      .read(networkMonitoringFilterProvider.notifier)
                      .applyFiltersFromCacheNM(
                          ref.read(
                              networkMonitoringFilterCacheProvider.notifier),
                          ref);
                  ref
                      .read(networkMonitoringFilterButtonProvider.notifier)
                      .loadSavedFilters(ref
                          .read(networkMonitoringFilterCacheProvider.notifier)
                          .state); // Load saved filters to buttons
                  ref
                      .read(navigationService)
                      .pushNamedScreen(Routes.networkMonitoring);
                }
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 31),
                          child: Column(
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                search.createdAt,
                                style: const TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                search.title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Text(
                                    'Filters applied:',
                                    style: TextStyle(
                                        color: Color.fromRGBO(166, 215, 227, 1),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(50, 50, 50, 1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: const Text(
                                      'For Sale',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(233, 233, 233, 1),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(50, 50, 50, 1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: const Text(
                                      '\$100k to \$150k',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(233, 233, 233, 1),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(50, 50, 50, 1),
                                        borderRadius: BorderRadius.circular(4)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: const Text(
                                      '120 m²  to 240 m²',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(233, 233, 233, 1),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(50, 50, 50, 1),
                                        borderRadius: BorderRadius.circular(4)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: const Text(
                                      '3 rooms',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(233, 233, 233, 1),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(50, 50, 50, 1),
                                        borderRadius: BorderRadius.circular(4)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: const Text(
                                      '3 bathrooms',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(233, 233, 233, 1),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 31),
                        child: InkWell(
                          onTapDown: (details) => onTap(details, context),
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(233, 233, 233, 1)),
                                borderRadius: BorderRadius.circular(6)),
                            child: const Icon(
                              Icons.more_horiz,
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider()
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text(
        'Failed to load saved searches: $error',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  void onTap(TapDownDetails details, BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      color: const Color.fromRGBO(
          233, 233, 233, 1), // Background color of the menu
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(40, 40),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color.fromRGBO(
                  255, 255, 255, 1), // Background color for 'Edit'
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: const Text(
              'Edit',
              style:
                  TextStyle(color: Color.fromRGBO(35, 35, 35, 1)), // Text color
            ),
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color.fromRGBO(
                  255, 255, 255, 1), // Background color for 'Edit'
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: const Text(
              'Delete',
              style:
                  TextStyle(color: Color.fromRGBO(35, 35, 35, 1)), // Text color
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        print('Selected: $value'); // Handle actions
      }
    });
  }
}
